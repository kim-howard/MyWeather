//
//  UICollectionView.swift
//  MyWeather
//
//  Created by Hyeontae on 31/07/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    typealias ReusableCollectionViewCell = UICollectionViewCell & Reusable
    
    func registerReusableCell<ReusableCell: ReusableCollectionViewCell >(_ reusableCell: ReusableCell.Type) {
        register(UINib(reusableCell), forCellWithReuseIdentifier: reusableCell.reusableIdentifier)
    }
}
