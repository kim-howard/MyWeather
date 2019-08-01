//
//  CustomLocationManager.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import CoreLocation

class CustomLocationManager: CLLocationManager {
    
    override init() {
        super.init()
    }
    
    /// 위치 사용이 가능한지 확인하는 함수 가능하다면
    ///
    /// - Parameter status: 가능하다면 사용할 status
    func checkLocationService(didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.locationServicesEnabled() {
            authorize(didChangeAuthorization: status)
        } else {
            print("unavailable")
        }
    }
    
    
    /// status 를 확인해서 알맞은 알림을 띄워준다.
    ///
    /// - Parameter status: 바뀐 status
    func authorize(didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            self.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .denied, .restricted:
            print("denied")
        default: // authorizedAlways && others
            print("not supported")
        }
    }
    
}
