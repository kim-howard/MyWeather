//
//  NetworkResult.swift
//  MyWeather
//
//  Created by Hyeontae on 12/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case fail(NetworkError)
}
