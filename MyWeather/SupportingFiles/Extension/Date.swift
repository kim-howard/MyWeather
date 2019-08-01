//
//  Date.swift
//  MyWeather
//
//  Created by Hyeontae on 02/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation

extension Date {
    // TimeZone에 맞춰서 시간을 알기 위해서 사용한다.
    func with(_ format: String, _ timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
    // TimeZone에 맞춰서 시간을 알기 위해서 사용한다.
    // Base format으로 간편하게 알고 싶을때
    func withBaseFormat(_ timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd HH:mm"
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
}
