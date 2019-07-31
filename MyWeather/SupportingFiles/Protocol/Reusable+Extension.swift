//
//  Reusable+Extension.swift
//  MyWeather
//
//  Created by Hyeontae on 31/07/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation

protocol Reusable {
    static var reusableIdentifier: String { get }
}

extension Reusable {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
