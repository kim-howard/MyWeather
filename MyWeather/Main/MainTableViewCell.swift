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
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nowTemparatireLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
