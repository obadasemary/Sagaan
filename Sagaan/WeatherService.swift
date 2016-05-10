//
//  WeatherService.swift
//  Sagaan
//
//  Created by Abdelrahman Mohamed on 5/5/16.
//  Copyright © 2016 Abdelrahman Mohamed. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol WeatherServiceDelegate {
    
    func setWeather(weather: Weather)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    
    func getWeather(city: String) {

        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=56abb5d245399108961d3b2422a0f9da"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            
            let json = JSON(data: data!)
            
//            let lon = json["coord"]["lon"].double
//            let lat = json["coord"]["lat"].double
            let temp = json["main"]["temp"].double
            let name = json["name"].string
            let weatherDescription = json["weather"][0]["description"].string
//            let weatherMain = json["weather"][0]["main"].string
            
            let weather = Weather(cityName: name!, temp: temp!, description: weatherDescription!)
            
            if self.delegate != nil {
                dispatch_async(dispatch_get_main_queue(), { 
                
                    self.delegate?.setWeather(weather)
                })
            }
        }
        
        task.resume()
    }
}