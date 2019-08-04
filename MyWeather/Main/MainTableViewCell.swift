//
//  MainTableViewCell.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    // default isHidden = true
    @IBOutlet weak var userLocationImage: UIImageView!
    @IBOutlet weak var regionNameLabel: UILabel!
    @IBOutlet weak var nowTemparatireLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userLocationImage.isHidden = true
    }
    
    func configure(_ name: String) {
        regionNameLabel.text = name
    }
    
    func configure(_ item: DarkSkyForecastModel) {
        backgroundImage.image = WeatherStatus(item.currently.icon).backgroundImage
        
        timeLabel.text = Date(timeIntervalSince1970: TimeInterval(item.currently.time)).userTime(item.timezone)
        if let sharedAppDelegate = UIApplication.shared.delegate as? AppDelegate,
            sharedAppDelegate.isUserPreferCelsius
        {
            let temparature = item.currently.temperature.switchDegree(.celsius)
            nowTemparatireLabel.text = String(temparature).markTemparature()
        } else {
            nowTemparatireLabel.text = String(Int(item.currently.temperature)).markTemparature()
        }
    }
    
    func configure(_ isUserLocation: Bool) {
        if isUserLocation {
            userLocationImage.isHidden = false
            // image 적용
        }
    }
}
