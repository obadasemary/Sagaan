//
//  ViewController.swift
//  Sagaan
//
//  Created by Abdelrahman Mohamed on 5/5/16.
//  Copyright © 2016 Abdelrahman Mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {
    
    let weatherService = WeatherService()

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
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
            self.cityLabel.text = textField?.text!
            let cityName = textField?.text
            self.weatherService.getWeather(cityName!)
        }
        alert.addAction(ok)
        
        
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            
            textField.placeholder = "City Name"
        }
        
        presentViewController(alert, animated: true, completion: nil)
    }

    func setWeather() {
        print("*** View Controller Set Weather")
    }
}

