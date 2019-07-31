//
//  UITableView.swift
//  MyWeather
//
//  Created by Hyeontae on 31/07/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

extension UITableView {
    
    typealias ReusableTableViewCell = UITableViewCell & Reusable
    
    func registerReusableCell<ReusableCell: ReusableTableViewCell >(_ reusableCell: ReusableCell.Type) {
        register(UINib(reusableCell), forCellReuseIdentifier: reusableCell.reusableIdentifier)
    }

}
