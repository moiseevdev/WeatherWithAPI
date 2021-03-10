//
//  NetworkWeatherManager.swift
//  WeatherWithAPI
//
//  Created by Андрей Моисеев on 07.03.2021.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    enum SelectRequest {
        case cityName(city: String)
        case coordinate(latitide: CLLocationDegrees, logitude: CLLocationDegrees)
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forSelectRequest selectRequest: SelectRequest) {
        var urlString = ""
        switch selectRequest {
        case .cityName(city: let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&apikey=105a9207bffb3ade01dc2c893db322a7"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&apikey=105a9207bffb3ade01dc2c893db322a7"
        }
        runRequest(withURLString: urlString)
    }
    
    func runRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(weatherData: weatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error)
        }
        return nil
    }

    
}
