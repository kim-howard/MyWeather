//
//  APIBase.swift
//  MyWeather
//
//  Created by Hyeontae on 02/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation

/// API 생성에 필요한 Base
protocol APIBase {
    var scheme: String { get }
    var host: String { get }
    var path: String? { get }
    var query: String? { get }
}
