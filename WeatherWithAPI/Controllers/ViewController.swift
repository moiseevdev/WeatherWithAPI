//
//  ViewController.swift
//  WeatherWithAPI
//
//  Created by Андрей Моисеев on 01.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconLabel: UIImageView!
    @IBOutlet weak var feelsLikeTemperature: UILabel!
    
    let networkWetherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }


    @IBAction func searchPressed(_ sender: UIButton) {
        searchAlertController(withTitle: "test", message: "test2", style: .alert) { city in
            self.networkWetherManager.fetchCurrentWeather(forCity: city)
        }
    }
    
}



extension ViewController {
    func searchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, comletionHendler: @escaping (String
    ) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { (tf) in
            tf.placeholder = "Saint Petersburg"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let search = UIAlertAction(title: "Search", style: .default) { (UIAlertAction) in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
//                self.networkWetherManager.fetchCurrentWeather(forCity: cityName)
                let city = cityName.split(separator: " ").joined(separator: "%20")
                comletionHendler(city)
            }
        }
        
        ac.addAction(cancel)
        ac.addAction(search)
        present(ac, animated: true, completion: nil)
        
    }
}
