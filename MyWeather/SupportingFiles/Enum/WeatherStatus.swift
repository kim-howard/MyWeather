//
//  WeatherStatus.swift
//  MyWeather
//
//  Created by Hyeontae on 03/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

// clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night
// partly-cloudy-night
// lang을 지정하더라도 항상 영어로 온다.
enum WeatherStatus: String, CaseIterable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain = "rain"
    case snow = "snow"
    case sleet = "sleet"
    case wind = "wind"
    case fog = "fog"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case unknown = "unknown"
    
    init(_ identifier: String) {
        var result: WeatherStatus {
            for item in WeatherStatus.allCases where identifier == item.rawValue {
                return item
            }
            return .unknown
        }
        self = result
    }
    
    var icon: UIImage {
        if let weatherIcon = UIImage(named: self.rawValue) {
            return weatherIcon
        }
        return UIImage()
    }
    
    var backgroundImage: UIImage {
        // partlyCloudyDay 처리
        switch self {
        case .partlyCloudyDay, .partlyCloudyNight, .cloudy:
            if let weatherBackgroundImage = UIImage(named: "cloudy-image") {
                return weatherBackgroundImage
            }
        default:
            if let weatherBackgroundImage = UIImage(named: "\(self.rawValue)-image") {
                return weatherBackgroundImage
            }
        }
        
        return UIImage(named: "unknown-image")!
    }
}
