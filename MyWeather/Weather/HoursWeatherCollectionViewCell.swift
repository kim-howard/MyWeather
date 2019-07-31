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
    @IBOutlet weak var rainyLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temparatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 강수량이 없는 경우 보이지 않는다.
        rainyLabel.isHidden = true
    }
    
    func setRainPercent() {
        // if else ishidden
    }

}
