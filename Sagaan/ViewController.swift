//
//  ViewController.swift
//  Sagaan
//
//  Created by Abdelrahman Mohamed on 5/5/16.
//  Copyright © 2016 Abdelrahman Mohamed. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, WeatherServiceDelegate {
    
    let weatherService = WeatherService()

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherCondition: UIImageView!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var clouds: UILabel!
    @IBOutlet weak var percipitation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherService.delegate = self
    }

    @IBAction func setCity(sender: UIButton) {
        openCityAlert()
    }
    
    func openCityAlert() {
        
        let alert = UIAlertController(title: "City", message: "Enter City Name :)", preferredStyle: .Alert)

        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction) in
            
            let textField = alert.textFields?[0]
            let cityName = textField?.text
            self.weatherService.getWeather(cityName!)
        }
        alert.addAction(ok)
        
        
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            
            textField.placeholder = "City Name"
        }
        
        presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - Weather Service Delegate Methods
    
    func setWeather(weather: Weather) {
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        
        let C = formatter.stringFromNumber(weather.tempC)!
        tempLabel.text = "\(C) °"
        
        weatherCondition.image = UIImage(named: weather.icon)
        descriptionLabel.text = weather.description
        cityButton.setTitle(weather.cityName, forState: .Normal)
        clouds.text = "Clouds \(weather.clouds) %"
        
        let min = formatter.stringFromNumber(weather.tempMinC)!
        minTemp.text = "Min Temp \(min) °"
        
        let max = formatter.stringFromNumber(weather.tempMaxC)!
        maxTemp.text = "Max Temp \(max) °"
        
        
        percipitation.text = "\(weather.pressure) % Pressure"
    }
    
    func weatherErrorWithMessage(message: String) {
        
        print("Weather Error Message: \(message)")
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        alert.addAction(cancel)
        self.presentViewController(alert, animated: true, completion: nil)
    }
   
}

