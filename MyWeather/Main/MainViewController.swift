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
    
    private var isInitialized: Bool = false
    let customLocationManager = CustomLocationManager()
    let networkManager = NetworkManager()
    
    var regionInformations: [RegionInformation] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        checkUserDefault()
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
    
    
    private func tableViewFooterview() {
        let footerViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50.0))
        footerView.frame = footerViewWrapper.bounds
        footerViewWrapper.addSubview(footerView)
        tableView.tableFooterView = footerViewWrapper
    // TODO: 왜 아래는 안되는지 물어보기
//        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50.0)
//        tableView.tableFooterView = footerView
    }
    
    /// 기존에 유저가 검색한 region 의 정보를 확인하여 보여준다.
    private func checkUserDefault() {
        guard let userRegionData = UserDefaults.standard.object(forKey: UserDefaultKey.regionInformations.rawValue) as? Data else {
            return
        }
        do {
            let userRegionInformations = try PropertyListDecoder().decode(Array<RegionInformation>.self, from: userRegionData)
            regionInformations = userRegionInformations
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func synchronizeUserDefault() {
        do {
            let data = try PropertyListEncoder().encode(regionInformations)
            UserDefaults.standard.set(data, forKey: UserDefaultKey.regionInformations.rawValue)
            UserDefaults.standard.synchronize()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionInformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reusableIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        let regionInformation = regionInformations[indexPath.row]
        cell.configure(regionInformation.name)
        cell.configure(regionInformation.weatherInfo)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let weatherContainerViewController =
            UIStoryboard(name: "WeatherContainer", bundle: nil).instantiateInitialViewController() as? WeatherContainerViewController else {
                fatalError("WeatherContainer instantiate fail")
        }
        weatherContainerViewController.pageSources = regionInformations
        weatherContainerViewController.initialIndex = indexPath.row
        self.present(weatherContainerViewController, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { [weak self] (_, _, success) in
            guard let self = self else { return }
            self.regionInformations.remove(at: indexPath.row)
            self.synchronizeUserDefault()
            success(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
        
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
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let coordinate = item.placemark.coordinate
        networkManager.requestWeather(coordinate.latitude, coordinate.longitude) { [weak self] (data, err) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let self = self else { return }
            if let error = err {
                let alertController = UIAlertController(title: "요청에 실패하였습니다.", message: error.alertMessage, preferredStyle: .alert)
                self.present(alertController, animated: true)
                return
            }
            // data == nil 인 경우도 error로 확인되기 때문에 fored unwrapping 사용
            let newRegionInformation = RegionInformation(
                                                        name: item.name ?? "",
                                                        latitude: item.placemark.coordinate.latitude,
                                                        longitude: item.placemark.coordinate.longitude,
                                                        weatherInfo: data!)
            self.regionInformations.append(newRegionInformation)
            self.synchronizeUserDefault()
            // UIUpdate
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                // TODO: Section change
                self.tableView.insertRows(at: [IndexPath(row: self.regionInformations.count-1, section: 0)], with: .automatic)
                self.tableView.endUpdates()
            }
        }
    }
}
