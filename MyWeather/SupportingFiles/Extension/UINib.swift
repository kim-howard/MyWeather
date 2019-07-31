//
//  UINib.swift
//  MyWeather
//
//  Created by Hyeontae on 31/07/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

extension UINib {
    
    /// 이름과 클래스 명이 동일한 nib 사용
    ///
    /// - Parameter nibClass: nibClass
    convenience init(_ nibClass: AnyClass) {
        self.init(nibName: String(describing: nibClass), bundle: Bundle.main)
    }
}
