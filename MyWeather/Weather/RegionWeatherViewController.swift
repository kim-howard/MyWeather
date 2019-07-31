//
//  RegionWeatherViewController.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

// statusbar 20?
// 지역 이름 100
// 도 + 요일 100
// 시간별 날씨 130
// 테이블 뷰
// 하단 50

import UIKit

class RegionWeatherViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.showsVerticalScrollIndicator = false
        }
    }
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.showsVerticalScrollIndicator = false
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHeight.constant = view.frame.height - 300
    }
    

}

extension RegionWeatherViewController: UIScrollViewDelegate {
    
}

extension RegionWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension RegionWeatherViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
    }
}


