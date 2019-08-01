//
//  AddRegionViewController.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import MapKit

class AddRegionViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var regionSearchBar: UISearchBar!
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.addTarget(self, action: #selector(didTapCancelButton(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - Property
    
    /// 검색한 결과를 추가하기 위한 delgate
    weak var delegate: AddRegionDelegate?
    
    /// 검색바에 입력이 끝났는지 체크하는 타이머
    private var editingTimer: Timer?
    private var searchedItems: [MKMapItem]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    /// 현재 상태를 나타내기 위한 enum
    private enum SearchStatus: String {
        case noResult = "결과가 없습니다."
        case nowSearching = "검색중..."
        case searchFail = "검색에 실패하였습니다. 다시 입력해주세요"
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        setTableView()
        hideStatusLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 자연스럽게 키보드가 내려가도록 한다.
        if regionSearchBar.isFirstResponder {
            regionSearchBar.resignFirstResponder()
        }
    }
    
    // MARK: - Method
    
    private func setSearchBar() {
        regionSearchBar.delegate = self
        regionSearchBar.backgroundImage = UIImage()
        regionSearchBar.becomeFirstResponder()
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        registerCell()
    }
    
    private func registerCell() {
        tableView.registerReusableCell(AddRegionTableViewCell.self)
    }
    
    
    /// 상태에 따라서 라벨을 변경할 수 있도록 한다. Hidden 처리도 같이 해준다.
    ///
    /// - Parameter status: 선언해놓은 SearchStatus
    private func setStatusLabel(_ status: SearchStatus) {
        statusLabel.text = status.rawValue
        statusLabel.isHidden = false
    }
    
    /// label을 숨기기 위한 함수
    private func hideStatusLabel() {
        statusLabel.isHidden = true
    }
    
    // 텍스트를 받아서 Request를 만든 후 검색한다.
    private func locationSearch(with userText: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = userText
        locationSearch(with: searchRequest)
    }
    
    // MKLocalSearch.Request를 통해서 검색한다.
    private func locationSearch(with searchRequest: MKLocalSearch.Request) {
        // Use the network activity indicator as a hint to the user that a search is in progress.
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if searchedItems?.count == 0 {
            setStatusLabel(.nowSearching)
        }
        
        MKLocalSearch(request: searchRequest).start { [weak self] (response, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            guard let self = self else { return }
            self.hideStatusLabel()
            
            if let _ = error {
                self.setStatusLabel(.searchFail)
                self.searchedItems?.removeAll()
                return
            }
            
            guard let response = response else {
                self.setStatusLabel(.searchFail)
                self.searchedItems?.removeAll()
                return
            }
            
            // 결과가 없는 경우
            if response.mapItems.count == 0 {
                self.setStatusLabel(.noResult)
            }
            
            self.searchedItems = response.mapItems
        }
    }
    
    // MARK: - objc
    
    @objc func didTapCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddRegionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let editingTimer = editingTimer {
            editingTimer.invalidate()
        }
        
        editingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            // send Request
            guard let self = self,
                let text = searchBar.text
                else { return }
            self.locationSearch(with: text)
        })
    }
    
}

// MARK: - UITableViewDataSource

extension AddRegionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let placeItems = searchedItems else {
            return 0
        }
        return placeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let individualItem = searchedItems?[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: AddRegionTableViewCell.reusableIdentifier) as? AddRegionTableViewCell
            else { return UITableViewCell() }
        if let addressTitle = individualItem.placemark.title {
            cell.configure(addressTitle)
        } else {
            cell.configure("fail to find location")
        }
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension AddRegionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let individualItem = searchedItems?[indexPath.row] else {return}
        delegate?.addRegion(individualItem.placemark.coordinate)
        self.dismiss(animated: true, completion: nil)
    }
}
