//
//  MainTableViewCell.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell, Reusable {

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
        if let timeZone = TimeZone(identifier: item.timezone) {
            timeLabel.text = Date(timeIntervalSince1970: TimeInterval(item.currently.time)).userTime(timeZone)
        }
        let temparature = item.currently.temperature.switchDegree(.celsius)
        nowTemparatireLabel.text = String(temparature).markTemparature()
    }
    
    func configure(_ isUserLocation: Bool) {
        if isUserLocation {
            userLocationImage.isHidden = false
            // image 적용
        }
    }
}
