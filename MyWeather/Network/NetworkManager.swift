//
//  NetworkManager.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit

class NetworkManager {
    
    let darkSkyAPIKey = "089b1a213049e66cef1c1054f4e4b444"
    let darkSkyAPIHost: String = "api.darksky.net"
    
    init() {
        
    }
    
    // 위도 경도 잘 보기
    func url(_ latitude: String, _ longitude: String) -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = darkSkyAPIHost
        component.path = "/forecast/\(darkSkyAPIKey)/\(latitude),\(longitude)"
        component.query = "lang=ko&exclude=[minutely,alerts,flags]"
        return component.url
    }
    
    func requestWeather() {
        guard let apiURL = url("37.8267", "-122.4233") else {
            return
        }
        let urlSession = URLSession.init(configuration: .default)
        let dataTask = urlSession.dataTask(with: apiURL) { (data, response, err) in
            print(data)
        }
        dataTask.resume()
    }
    
    
}
