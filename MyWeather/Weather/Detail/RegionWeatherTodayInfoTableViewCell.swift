//
//  RegionWeatherTodayInfoTableViewCell.swift
//  MyWeather
//
//  Created by Hyeontae on 03/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

// height 65 정도
class RegionWeatherTodayInfoTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var firstKeyLabel: UILabel!
    @IBOutlet weak var firstValueLabel: UILabel!
    @IBOutlet weak var secondKeyLabel: UILabel!
    @IBOutlet weak var secondValueLabel: UILabel!
    
    func configure(_ firstLabel: Bool, _ key: String, _ value: String) {
        if firstLabel {
            firstKeyLabel.text = key
            firstValueLabel.text = value
        } else {
            secondKeyLabel.text = key
            secondValueLabel.text = value
        }
    }
}
