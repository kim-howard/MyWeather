//
//  MainViewController.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var footerView: MainTableFooterView = {
        guard let nibView: MainTableFooterView =
            Bundle.main.loadNibNamed("MainTableFooterView", owner: self, options: nil)?.first as? MainTableFooterView
            else { fatalError("footer nib") }
        nibView.delegate = self
        return nibView
    }()
    
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reusableIdentifier) as? MainTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
}


extension MainViewController: MainTableFooterViewDelegate {
    func didTapPlusButton() {
        guard let addResionViewController =
            UIStoryboard(name: "AddRegion", bundle: nil).instantiateInitialViewController() as? AddRegionViewController
            else { fatalError("AddRegion Error") }
        self.present(addResionViewController, animated: true)
    }
}
