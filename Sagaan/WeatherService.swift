//
//  WeatherService.swift
//  Sagaan
//
//  Created by Abdelrahman Mohamed on 5/5/16.
//  Copyright © 2016 Abdelrahman Mohamed. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    
    func setWeather()
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    
    func getWeather(city: String) {
        
        
        print("Weather Service City: \(city)")
        
        if delegate != nil {
            delegate?.setWeather()
        }
        
    }
}