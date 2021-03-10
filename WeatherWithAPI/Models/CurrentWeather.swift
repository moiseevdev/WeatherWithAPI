//
//  Weather.swift
//  WeatherWithAPI
//
//  Created by Андрей Моисеев on 09.03.2021.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let temp: Double
    var tempString: String {
        return String(format: "%.0f", temp)
    }
    
    let feelsLikeTemp: Double
    var feelsLikeTempString: String {
        return String(format: "%.0f", feelsLikeTemp)
    }
    
    let conditionCode: Int
    var iconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 700...781: return "smoke"
        case 800: return "sun.max"
        case 800...804: return "cloud"
        default:
            return "location.slash"
        }
    }
    
    init?(weatherData: WeatherData) {
        cityName = weatherData.name
        temp = weatherData.main.temp
        feelsLikeTemp = weatherData.main.feelsLike
        conditionCode = weatherData.weather.first!.id
    }
}
