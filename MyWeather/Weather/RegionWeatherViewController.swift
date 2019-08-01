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

// TODO: TableView section 3개 있어야 한다. 셀도 3개
class RegionWeatherViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nowTemparatureLabel: UILabel!
    @IBOutlet weak var todayInfoView: UIView!
    @IBOutlet weak var infoPerHourView: UIView!
    @IBOutlet weak var wrapperScrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    
    lazy var infoPerHourCollectionView: HoursWeatherCollectionView = {
       let collectionView = HoursWeatherCollectionView(frame: CGRect.zero)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
       return collectionView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        collectionViewForHourView()
        setTableView()
    }
    
    // MARK: - Method
    private func setScrollView() {
        wrapperScrollView.delegate = self
        wrapperScrollView.showsVerticalScrollIndicator = false
    }
    
    // TODO: Delegate 여기로 수정해야함
    private func collectionViewForHourView() {
        infoPerHourCollectionView.frame = infoPerHourView.bounds
        infoPerHourView.addSubview(infoPerHourCollectionView)
    }
    
    private func setTableView() {
        tableViewHeight.constant = view.frame.height - 300
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        tableView.registerReusableCell(RegionWeatherTableViewCell.self)
    }
    
    /// 오늘의 정보 알파값 조절 , scrollView의 offset에 따라서 조절된다.
    /// offset 0 -> alpha 1 , offset 50 - > alpha 0
    /// - Parameter scrollOffsetY: offset of scrollview
    private func todayInfoAlpha(_ scrollOffsetY: CGFloat) {
        
        var scrollAlpha: CGFloat {
            if scrollOffsetY <= 0 {
                return 1
            } else {
                return (50.0 - wrapperScrollView.contentOffset.y) / 50
            }
        }
        
        nowTemparatureLabel.alpha = scrollAlpha
        todayInfoView.alpha = scrollAlpha
    }

}

// MARK: - UITableViewDataSource

extension RegionWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier: RegionWeatherTableViewCell.reusableIdentifier) as? RegionWeatherTableViewCell
            else { return UITableViewCell() }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RegionWeatherViewController: UITableViewDelegate {
    
}

// MARK: - UIScrollViewDelegate

extension RegionWeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if wrapperScrollView.contentOffset.y <= 50 {
            todayInfoAlpha(wrapperScrollView.contentOffset.y)
        }
        
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


