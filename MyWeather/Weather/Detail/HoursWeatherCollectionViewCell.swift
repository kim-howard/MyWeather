//
//  HoursWeatherCollectionViewCell.swift
//  MyWeather
//
//  Created by Hyeontae on 31/07/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

// Enum 활용해서 아이콘 사용할 것
// 강수량 확인해서 없으면 안보이게
class HoursWeatherCollectionViewCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temparatureLabel: UILabel!
    
    func configure(_ hourInfo: Currently, _ timezoneIdentifier: String) {
        timeLabel.text = Date(timeIntervalSince1970: TimeInterval(hourInfo.time)).userTime(timezoneIdentifier)
        weatherIcon.image = WeatherStatus(hourInfo.icon).icon
        if let sharedAppDelegate = UIApplication.shared.delegate as? AppDelegate,
            sharedAppDelegate.isUserPreferCelsius
        {
            temparatureLabel.text = String(hourInfo.temperature.switchDegree(.celsius)).markTemparature()
        } else {
            temparatureLabel.text = String(Int(hourInfo.temperature)).markTemparature()
        }
        
    }

}
