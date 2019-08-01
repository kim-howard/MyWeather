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
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var wrapperScrollView: UIScrollView! {
        didSet {
            wrapperScrollView.delegate = self
            wrapperScrollView.showsVerticalScrollIndicator = false
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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHeight.constant = view.frame.height - 300
    }
    
    // MARK: - Method
    
    

}

// MARK: - UITableViewDataSource

extension RegionWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension RegionWeatherViewController: UITableViewDelegate {
    
}

// MARK: - UIScrollViewDelegate

extension RegionWeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 전달할 스크롤에 offset을 더하고 기존 스크롤은 유지한다.
        // 테이블뷰를 내리는 액션으로 스크롤뷰를 내리는 경우
        if scrollView == tableView && wrapperScrollView.contentOffset.y < 100{
            wrapperScrollView.setContentOffset(
                CGPoint(x: 0, y: wrapperScrollView.contentOffset.y + scrollView.contentOffset.y),
                animated: false)
            tableView.setContentOffset(CGPoint.zero, animated: false)
        }
        
        // 테이블뷰를 계속 올리는 경우
        if scrollView == tableView && tableView.contentOffset.y <= 0 {
            wrapperScrollView.setContentOffset(
                CGPoint(x: 0, y: wrapperScrollView.contentOffset.y + scrollView.contentOffset.y),
                animated: false)
            tableView.setContentOffset(CGPoint.zero, animated: false)
        }
    }
}


