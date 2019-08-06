//
//  RegionWeatherSummaryTableViewCell.swift
//  MyWeather
//
//  Created by Hyeontae on 03/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class RegionWeatherSummaryTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var summaryLabel: UILabel!
    
    func configure(_ summary: String) {
        summaryLabel.text = summary
    }
}
