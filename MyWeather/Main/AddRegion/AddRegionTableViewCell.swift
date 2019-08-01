//
//  AddRegionTableViewCell.swift
//  MyWeather
//
//  Created by Hyeontae on 02/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class AddRegionTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ addressName: String) {
        nameLabel.text = addressName
    }
    
}
