//
//  ViewController.swift
//  WeatherWithAPI
//
//  Created by Андрей Моисеев on 01.03.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconLabel: UIImageView!
    @IBOutlet weak var feelsLikeTemperature: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()


    @IBAction func searchPressed(_ sender: UIButton) {
        searchAlertController(withTitle: "Enter the name of the city", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forSelectRequest: .cityName(city: city))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.tempString
            self.feelsLikeTemperature.text = weather.feelsLikeTempString
            self.iconLabel.image = UIImage(systemName: weather.iconNameString)
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forSelectRequest: .coordinate(latitide: latitude, logitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}


