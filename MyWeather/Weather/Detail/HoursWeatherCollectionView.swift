//
//  HoursWeatherCollectionView.swift
//  MyWeather
//
//  Created by Hyeontae on 31/07/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class HoursWeatherCollectionView: UICollectionView {

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
        self.dataSource = self
        self.delegate = self
        self.registerReusableCell(HoursWeatherCollectionViewCell.self)
    }
}

extension HoursWeatherCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: "HoursWeatherCollectionViewCell", for: indexPath) as? ReusableCollectionViewCell else {
            fatalError("dequeue collection View Fail")
        }
        return cell
    }
    
}

extension HoursWeatherCollectionView: UICollectionViewDelegate {
    
}

extension HoursWeatherCollectionView: UICollectionViewDelegateFlowLayout {
    
}
