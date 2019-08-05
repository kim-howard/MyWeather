//
//  String.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation

extension String {
    // 도씨 를 넣을 때 사용
    func markTemparature() -> String {
        return "\(self)°"
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}
