//
//  NetworkManager.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import CoreLocation

// TODO: Custom Error 
class NetworkManager {
    
    private lazy var urlSession: URLSession = {
        return URLSession(configuration: .ephemeral)
    }()
    
    /// 위치를 통해서 날씨 데이터를 요청하는 로직
    ///
    /// - Parameters:
    ///   - location: 검색할 지역의 위치
    ///   - completion: 응답 클로저 longitude latitude
    func requestWeather(_ latitude: Double,
                        _ longitude: Double,
                        completion: @escaping (_ data: DarkSkyForecastModel?, _ err: NetworkError?) -> Void) {
        guard let url = DarkSkyAPI.weather(String(latitude), String(longitude)).requestURL else {
            completion(nil,.failToURLWithLocation)
            return
        }
        
        urlSession.dataTask(with: url) { (data, _, err) in
            if let error = err {
                print(error.localizedDescription)
                completion(nil, .dataTaskError)
                return
            }
            
            guard let data = data else {
                completion(nil,.dataIsNil)
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(DarkSkyForecastModel.self, from: data)
                completion(weatherData,nil)
            } catch {
                completion(nil,.jsonParsingError)
            }
        }.resume()
        
    }
}
