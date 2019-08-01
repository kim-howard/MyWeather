//
//  AddRegionDelegate.swift
//  MyWeather
//
//  Created by Hyeontae on 02/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import CoreLocation

protocol AddRegionDelegate: class {
    func addRegion(_ location: CLLocationCoordinate2D)
}
