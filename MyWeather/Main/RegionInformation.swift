//
//  RegionInformation.swift
//  MyWeather
//
//  Created by Hyeontae on 02/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import MapKit
import CoreLocation

struct RegionInformation: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    let weatherInfo: DarkSkyForecastModel
}


