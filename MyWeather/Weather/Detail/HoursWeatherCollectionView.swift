//
//  HoursWeatherCollectionView.swift
//  MyWeather
//
//  Created by Hyeontae on 31/07/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class HoursWeatherCollectionView: UICollectionView {
    
    weak var hoursCollectionDelegate: UICollectionViewDelegate?
    weak var hoursCollectionDatasource: UICollectionViewDataSource?

    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        self.setCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionView() {
        self.dataSource = hoursCollectionDatasource
        self.registerReusableCell(HoursWeatherCollectionViewCell.self)
    }
}
