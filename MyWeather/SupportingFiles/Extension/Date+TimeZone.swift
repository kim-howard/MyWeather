//
//  Date.swift
//  MyWeather
//
//  Created by Hyeontae on 02/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation

extension Date {
    // PM 07:00 or 오후 10:12
    func userTime(_ timezoneIdentifier: String) -> String {
        if let timeZone = TimeZone(identifier: timezoneIdentifier) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "a hh:mm"
            dateFormatter.timeZone = timeZone
            return dateFormatter.string(from: self)
        }
        return ""
    }
    
    // 목요일 Thursday
    func weekDay(_ timezoneIdentifier: String) -> String {
        if let timeZone = TimeZone(identifier: timezoneIdentifier) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeZone = timeZone
            return dateFormatter.string(from: self)
        }
        return ""
    }
}
