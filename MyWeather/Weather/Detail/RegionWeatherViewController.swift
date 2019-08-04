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
import MapKit

// TODO: TableView section 3개 있어야 한다. 셀도 3개
class RegionWeatherViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var nowTemparatureLabel: UILabel!
    // TodayInfo -> tag 0: weekDay, tag1 : today, tag2: Max, tag3: Min
    @IBOutlet weak var todayInfoView: UIView!
    @IBOutlet weak var infoPerHourView: UIView!
    @IBOutlet weak var wrapperScrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nowIndexLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var listButton: UIButton! {
        didSet {
            listButton.addTarget(self, action: #selector(didTapListButton(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Property
    
    var pageIndex: Int!
    var totalIndex: Int!
    var regionInformation: RegionInformation!
    
    lazy var infoPerHourCollectionView: HoursWeatherCollectionView = {
       let collectionView = HoursWeatherCollectionView(frame: CGRect.zero)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
       return collectionView
    }()
    
    lazy var hourlyInformation: [Currently] = {
        return regionInformation.weatherInfo.hourly.data
    }()
    
    lazy var daliyInformation: [Datum] = {
        return regionInformation.weatherInfo.daily.data
    }()
    
    lazy var todaySummray: String = {
        return "Summary : " + todayInformation.summary
    }()
    
    lazy var todayInformation: Datum = {
        return regionInformation.weatherInfo.daily.data[0]
    }()
    
    // TODO: Struct
//    private struct WeatherDetailString {
//
//    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        collectionViewForHourView()
        setTableView()
        setContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // request
    }
    
    // MARK: - Method
    
    private func setScrollView() {
        wrapperScrollView.delegate = self
        wrapperScrollView.showsVerticalScrollIndicator = false
    }
    
    private func collectionViewForHourView() {
        infoPerHourCollectionView.frame = infoPerHourView.bounds
        infoPerHourView.addSubview(infoPerHourCollectionView)
    }
    
    private func setTableView() {
        tableViewHeight.constant = view.frame.height - 300
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        tableView.registerReusableCell(RegionWeatherDailyTableViewCell.self)
        tableView.registerReusableCell(RegionWeatherSummaryTableViewCell.self)
        tableView.registerReusableCell(RegionWeatherTodayInfoTableViewCell.self)
    }
    
    /// 오늘의 정보 알파값 조절 , scrollView의 offset에 따라서 조절된다.
    /// - Parameter scrollOffsetY: offset of scrollview
    private func todayInfoAlpha(_ scrollOffsetY: CGFloat) {
        var scrollAlpha: CGFloat {
            if scrollOffsetY <= 0 {
                return 1
            } else if scrollOffsetY <= 50{
                return (50.0 - wrapperScrollView.contentOffset.y) / 50
            } else {
                return 0
            }
        }
        nowTemparatureLabel.alpha = scrollAlpha
        todayInfoView.alpha = scrollAlpha
    }
    
    private func setContent() {
        let currentlyInfo = regionInformation.weatherInfo.currently
        let today = regionInformation.weatherInfo.daily.data.first!
        backgroundImage.image = WeatherStatus(currentlyInfo.icon).backgroundImage
        nameLabel.text = regionInformation.name
        summaryLabel.text = currentlyInfo.summary
        nowTemparatureLabel.text = String(currentlyInfo.temperature.switchDegree(.celsius)).markTemparature()
        todayInfoView.subviews.forEach { subView in
            guard let label = subView as? UILabel else { return }
            if subView.tag == 0 { // 요일
                let todayDate = Date(timeIntervalSince1970: TimeInterval(today.time))
                label.text = todayDate.weekDay(regionInformation.weatherInfo.timezone)
            } else if subView.tag == 1 { // 오늘
                label.text = "Today"
            } else if subView.tag == 2 { // max
                label.text = String(today.temperatureMax.switchDegree(.celsius))
            } else if subView.tag == 3 { // min
                label.text = String(today.temperatureMin.switchDegree(.celsius))
            }
        }
        nowIndexLabel.text = String(pageIndex)
        totalCountLabel.text = String(totalIndex)
    }
    
    // MARK: - objc
    
    @objc private func didTapListButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension RegionWeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyInformation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoursWeatherCollectionViewCell", for: indexPath) as? HoursWeatherCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(hourlyInformation[indexPath.row], regionInformation.weatherInfo.timezone)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RegionWeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
    }
}

// MARK: - UIScrollViewDelegate

extension RegionWeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        todayInfoAlpha(wrapperScrollView.contentOffset.y)
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

// MARK: - UITableViewDataSource

extension RegionWeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // Daily , Summary , Today Detail
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { // DailyInfo
            return daliyInformation.count
        } else if section == 1 { // Summary
            return 1
        } else { // Today Detail
            // 일출 sunrize Time / 일몰 sumset Time
            // 비올확률 precipProbability /  습도 humidity
            // 풍속 windSpeed / 가시거리 visibility => miles
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // DailyInfo
            guard let cell =
                tableView.dequeueReusableCell(withIdentifier: RegionWeatherDailyTableViewCell.reusableIdentifier) as? RegionWeatherDailyTableViewCell
                else { return UITableViewCell() }
            cell.configure(daliyInformation[indexPath.row], regionInformation.weatherInfo.timezone)
            return cell
            
        } else if indexPath.section == 1 {
            // Summary
            guard let cell =
                tableView.dequeueReusableCell(withIdentifier: RegionWeatherSummaryTableViewCell.reusableIdentifier) as? RegionWeatherSummaryTableViewCell
                else { return UITableViewCell() }
            cell.configure(todaySummray)
            return cell
            
        } else {
            // Today Detail
            guard let cell =
                tableView.dequeueReusableCell(withIdentifier: RegionWeatherTodayInfoTableViewCell.reusableIdentifier) as? RegionWeatherTodayInfoTableViewCell
                else { return UITableViewCell() }
            if indexPath.row == 0 {
                // 일출 sunrize Time / 일몰 sunset Time
                cell.configure( true, "Sunrize", Date(timeIntervalSince1970: TimeInterval(todayInformation.sunriseTime)).userTime(regionInformation.weatherInfo.timezone))
                cell.configure( false, "Sunset", Date(timeIntervalSince1970: TimeInterval(todayInformation.sunsetTime)).userTime(regionInformation.weatherInfo.timezone))
            } else if indexPath.row == 1 {
                // 비올확률 precipProbability /  습도 humidity
                cell.configure(true, "precipProbability", "\(Int(todayInformation.precipProbability * 100.0))%")
                cell.configure(false, "Humidity", "\(Int(todayInformation.humidity * 100.0))%")
            } else {
                // 풍속 windSpeed / 가시거리 visibility => miles
                cell.configure(true, "WindSpeed", "\(todayInformation.windSpeed) MPH")
                cell.configure(false, "Visibility", "\(todayInformation.visibility) Mi")
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension RegionWeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { // DailyInfo
            return 44.0
        } else if indexPath.section == 1 { // Summary
            var summaryBoundingRect: CGRect {
                let summaryString = NSAttributedString(string: todaySummray,
                                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)])
                
                return summaryString.boundingRect(with:CGSize(width: view.frame.width - 16.0, height: CGFloat.greatestFiniteMagnitude),
                                                  options: .usesFontLeading,
                                                  context: nil)
            }
            return summaryBoundingRect.size.height + 64.0
        } else { // Today Detail
            return 65.0
        }
    }
}
