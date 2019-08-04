//
//  RegionWeatherDailyTableViewCell.swift
//  MyWeather
//
//  Created by Hyeontae on 03/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class RegionWeatherDailyTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var maxTemparatureLabel: UILabel!
    @IBOutlet weak var minTemparatureLabel: UILabel!
    
    func configure(_ dayInfo: Datum, _ timezoneIdentifier: String) {
        weekDayLabel.text = Date(timeIntervalSince1970: TimeInterval(dayInfo.time)).weekDay(timezoneIdentifier)
        iconImage.image = WeatherStatus(dayInfo.icon).icon
        maxTemparatureLabel.text = String(dayInfo.temperatureHigh.switchDegree(.celsius))
        minTemparatureLabel.text = String(dayInfo.temperatureMin.switchDegree(.celsius))
    }
}
