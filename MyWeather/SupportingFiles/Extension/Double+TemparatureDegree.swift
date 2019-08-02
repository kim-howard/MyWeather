//
//  Double+TemparatureDegree.swift
//  MyWeather
//
//  Created by Hyeontae on 02/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

// API 기본은 fahrenheit
import Foundation

extension Double {
    func switchDegree(_ to: TemparatureDegree) -> Int{
        switch to {
        case .celsius:
            // (32°F − 32) × 5/9 = 0°C
            return Int((self - 32) * (5.0 / 9.0))
        case .fahrenheit:
            // (0°C × 9/5) + 32 = 32°F
            return Int(self * (9.0 / 5.0)) + 32
        }
    }
}
