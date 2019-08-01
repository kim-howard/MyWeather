//
//  DarkSkyForecastModel.swift
//  MyWeather
//
//  Created by Hyeontae on 01/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation

struct DarkSkyForecaseModel: Codable {
    
    let latitude, longitude: Double
    let timezone: String
    let currently: Currently
    let hourly: Hourly
    let daily: Daily
    
}

struct Currently: Codable {
    let time: Int
//    let summary: Summary
    let summary: String
//    let icon: Icon
    let icon: String
    let nearestStormDistance, nearestStormBearing: Int?
    let precipIntensity, precipProbability, temperature, apparentTemperature: Double
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility, ozone: Double
    let precipType: String?
}

// clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night
// 나중에 다른 것이 추가될 수도 있다. thunder ... 등등
// TODO: Icon
//enum Icon: String, Codable {
//    case clearDay = "clear-day"
//    case partlyCloudyDay = "partly-cloudy-day"
//    case partlyCloudyNight = "partly-cloudy-night"
//}

// TODO: Summary
//enum Summary: String, Codable {
//    case clear = "Clear"
//    case mostlyCloudy = "Mostly Cloudy"
//    case partlyCloudy = "Partly Cloudy"
//}

// MARK: - Daily
struct Daily: Codable {
    let summary: String
    //    let icon: Icon
    let icon: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let time: Int
    let summary: String
    //    let icon: Icon
    let icon: String
    let sunriseTime, sunsetTime: Int
    let moonPhase, precipIntensity, precipIntensityMax: Double
    let precipIntensityMaxTime: Int
    let precipProbability: Double
    let precipType: String?
    let temperatureHigh: Double
    let temperatureHighTime: Int
    let temperatureLow: Double
    let temperatureLowTime: Int
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Int
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Int
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
    let windGustTime, windBearing: Int
    let cloudCover: Double
    let uvIndex, uvIndexTime: Int
    let visibility, ozone, temperatureMin: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Int
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Int
}

// MARK: - Hourly
struct Hourly: Codable {
    let summary: String
//    let icon: Icon
    let icon: String
    let data: [Currently]
}
