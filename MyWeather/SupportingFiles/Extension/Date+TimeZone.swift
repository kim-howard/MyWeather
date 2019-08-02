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
    func userTime(_ timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a HH:mm"
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: self)
    }
}
