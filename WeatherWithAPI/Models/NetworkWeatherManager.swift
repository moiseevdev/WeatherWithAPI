//
//  NetworkWeatherManager.swift
//  WeatherWithAPI
//
//  Created by Андрей Моисеев on 07.03.2021.
//

import Foundation

struct NetworkWeatherManager {
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=105a9207bffb3ade01dc2c893db322a7"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, respinse, error) in
            if let data = data {
                self.parseJSON(withData: data)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            print(weatherData.main.temp)
        } catch let error as NSError {
            print(error)
        }

    }

    
}
