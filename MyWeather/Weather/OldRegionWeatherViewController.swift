//
//  RegionWeatherViewController.swift
//  MyWeather
//
//  Created by Hyeontae on 31/07/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class OldRegionWeatherViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    // MARK: - Method
    
    // 테이블 뷰 기본 설정
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        setTableHeaderView()
        registerTableViewCell()
    }
    
    // tableView Header
    private func setTableHeaderView() {
        guard let headerView = Bundle.main.loadNibNamed("RegionWeatherHeaderView", owner: self, options: nil)?.first as? RegionWeatherHeaderView else {
            return
        }
        headerView.frame.size = CGSize(width: view.frame.width, height: 130.0)
        tableView.tableHeaderView = headerView
    }
    
    // 셀 등록
    private func registerTableViewCell() {
        // cell
        tableView.register(UINib(nibName: "RegionWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "RegionWeatherTableViewCell")
    }
}

extension OldRegionWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegionWeatherTableViewCell") as? RegionWeatherTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
}

extension OldRegionWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // cell 의 높이가 120 + 마진 각 5
        return 130.0
    }
    
    // collectionView 넣어야 한다.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let hoursWeahterCollectionView = HoursWeatherCollectionView(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 130.0))
            
//            let sectionHeader = UIView(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 100.0))
            return hoursWeahterCollectionView
        }
        return nil
    }
}



