//
//  WeatherData.swift
//  Clima
//
//  Created by Justyn Henman on 27/06/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {

    let current: Current
    let daily: [Daily]
    
}

struct Current: Decodable {
    
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let weather: Weather
    
}

struct Daily: Decodable{
    
    let dt: Double
    let main: Main
    let weather: Weather
    let clouds: Int
    let pop: Double
    let visibility: Double
    let wind_speed: Double
    let wind_deg: Double
    let temp: Temp
    
}

struct Temp: Decodable {
    
    let day: Double
    let min: Double
    let max: Double
    
}

struct Weather: Decodable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
}
