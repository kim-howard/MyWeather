//
//  MainViewController.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    lazy var footerView: MainTableFooterView = {
        guard let nibView: MainTableFooterView =
            Bundle.main.loadNibNamed("MainTableFooterView", owner: self, options: nil)?.first as? MainTableFooterView
            else { fatalError("footer nib") }
        nibView.delegate = self
        return nibView
    }()
    let customLocationManager = CustomLocationManager()
    let networkManager = NetworkManager()
    var locationList: [(item: MKMapItem, apiModel: DarkSkyForecaseModel)] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    // MARK: - Method
    
    // TODO: Nested Function 생각해보기
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCell()
        tableViewFooterview()
    }
    
    private func registerTableViewCell() {
        tableView.registerReusableCell(MainTableViewCell.self)
    }
    
    // TODO: 왜 아래는 안되는지 물어보기
    private func tableViewFooterview() {
        let footerViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50.0))
        footerView.frame = footerViewWrapper.bounds
        footerViewWrapper.addSubview(footerView)
        tableView.tableFooterView = footerViewWrapper
        
//        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50.0)
//        tableView.tableFooterView = footerView
    }

}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reusableIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        let locationInfo = locationList[indexPath.row]
        
        if let name = locationInfo.item.name {
            cell.configure(name)
        }
        
        cell.configure(locationInfo.apiModel)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
}

// MARK: - MainTableFooterViewDelegate

extension MainViewController: MainTableFooterViewDelegate {
    func didTapPlusButton() {
        guard let addResionViewController =
            UIStoryboard(name: "AddRegion", bundle: nil).instantiateInitialViewController() as? AddRegionViewController
            else { fatalError("AddRegion Error") }
        addResionViewController.delegate = self
        self.present(addResionViewController, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate

// TODO: 위치 확인해서 테이블뷰에 추가하는 로직
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        customLocationManager.checkLocationService(didChangeAuthorization: status)
    }
}

// MARK: - AddRegionDelegate

extension MainViewController: AddRegionDelegate {
    // 검색한 결과를 받는다.
    func addRegion(_ item: MKMapItem) {
        let coordinate = item.placemark.coordinate
        
        // locale 값에 따라서 언어가 변경된다.
//        print("name : \(item.name)")
//        print("placemark title : \(item.placemark.title)")
        
        
        networkManager.requestWeather(with: coordinate) { [weak self] (data, err) in
            guard let self = self else { return }
            if let error = err {
                // TODO: Error Handling
                let alertController = UIAlertController(title: "Fail To Request", message: error.alertMessage, preferredStyle: .alert)
                self.present(alertController, animated: true)
            }

            guard let data = data else {
                return
            }
            
            self.locationList.append((item: item, apiModel: data))
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                // TODO: Section change
                self.tableView.insertRows(at: [IndexPath(row: self.locationList.count-1, section: 0)], with: .automatic)
                self.tableView.endUpdates()
            }
            
        }
    }
}
