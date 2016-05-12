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
    func weatherErrorWithMessage(message: String)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    
    func getWeather(city: String) {

        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let appID = "56abb5d245399108961d3b2422a0f9da"
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=\(appID)"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            
            guard (error == nil) else {
                print(error?.description)
                return
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            let json = JSON(data: data!)
            print(json)
            
            var status = 0
            
            if let cod = json["cod"].int {
                status = cod
            } else if let cod = json["cod"].string {
                status = Int(cod)!
            }
            
            print("Weather Status code: \(status)")
            
            if status == 200 {
                _ = json["coord"]["lon"].double
                _ = json["coord"]["lat"].double
                let temp = json["main"]["temp"].double
                let tempMin = json["main"]["temp_min"].double
                let tempMax = json["main"]["temp_max"].double
                let humidity = json["main"]["humidity"].double
                let pressure = json["main"]["pressure"].double
                let name = json["name"].string
                let weatherDescription = json["weather"][0]["description"].string
                let icon = json["weather"][0]["icon"].string
                let clouds = json["clouds"]["all"].double
                _ = json["weather"][0]["main"].string
                
                let weather = Weather(cityName: name!, temp: temp!, description: weatherDescription!, icon: icon!,clouds: clouds!, tempMin: tempMin!, tempMax: tempMax!, humidity: humidity!, pressure: pressure!)
                
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.delegate?.setWeather(weather)
                    })
                }
                
            } else if status == 404 {
                
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.delegate?.weatherErrorWithMessage("City Not Found")
                    })
                }
                
            } else {
                
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.delegate?.weatherErrorWithMessage("Something is wrong")
                    })
                }
            }
        }
        
        task.resume()
    }
}