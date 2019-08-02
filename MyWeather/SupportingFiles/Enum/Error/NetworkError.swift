//
//  NetworkError.swift
//  MyWeather
//
//  Created by Hyeontae on 02/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case failToURLWithLocation
    case dataTaskError
    case dataIsNil
    case jsonParsingError
    
    var alertMessage: String {
        switch self {
        case .failToURLWithLocation:
            return "URL을 만드는데 실패하였습니다."
        case .dataTaskError:
            return "날씨 요청에 실패하였습니다."
        case .dataIsNil:
            return "데이터를 확인할 수 없습니다."
        case .jsonParsingError:
            return "JSON 의 형식이 잘못 되었습니다."
        }
    }
}
