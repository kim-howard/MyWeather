//
//  DarkSkyAPI.swift
//  MyWeather
//
//  Created by Hyeontae on 02/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation

enum DarkSkyAPI: APIBase {

    case weather(_ latitude: String, _ longitude: String)
    
    // TODO: RESET KEY
    private var APIKey: String {
        return "089b1a213049e66cef1c1054f4e4b444"
    }
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.darksky.net"
    }
    
    var path: String? {
        switch self {
        case .weather(let latitude, let longitude):
            return "/forecast/\(self.APIKey)/\(latitude),\(longitude)"
        }
    }
    
    var query: String? {
        return "lang=ko&exclude=[minutely,alerts,flags]"
//        return "exclude=[minutely,alerts,flags]"
    }
    
    var requestURL: URL? {
        var component = URLComponents()
        component.scheme = self.scheme
        component.host = self.host
        if let path = self.path {
            component.path = path
        }
        if let query = self.query {
            component.query = query
        }
        return component.url
    }
}
