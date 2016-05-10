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
    
    init(cityName: String, temp: Double, description: String) {
        
        self.cityName = cityName
        self.temp = temp
        self.description = description
    }
    
}