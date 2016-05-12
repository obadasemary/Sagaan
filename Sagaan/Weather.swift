//
//  Weather.swift
//  Sagaan
//
//  Created by Abdelrahman Mohamed on 5/8/16.
//  Copyright © 2016 Abdelrahman Mohamed. All rights reserved.
//

import Foundation

struct Weather {
    
    let cityName: String
    let temp: Double
    let description: String
    let icon: String
    let clouds: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Double
    let pressure: Double
    
    var tempC: Double {
        get {
            return temp - 273.15
        }
    }
    
    var tempMinC: Double {
        get {
            return tempMin - 273.15
        }
    }
    
    var tempMaxC: Double {
        get {
            return tempMax - 273.15
        }
    }
    
    
    
    init(cityName: String,
         temp: Double,
         description: String,
         icon: String,
         clouds: Double,
         tempMin: Double,
         tempMax: Double,
         humidity: Double,
         pressure: Double) {
        
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.icon = icon
        self.clouds = clouds
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.humidity = humidity
        self.pressure = pressure
    }
    
}