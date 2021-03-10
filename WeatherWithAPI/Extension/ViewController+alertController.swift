//
//  ViewController+alertController.swift
//  WeatherWithAPI
//
//  Created by Андрей Моисеев on 07.03.2021.
//

import Foundation
import UIKit

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
                let city = cityName.split(separator: " ").joined(separator: "%20")
                comletionHendler(city)
            }
        }
        
        ac.addAction(cancel)
        ac.addAction(search)
        present(ac, animated: true, completion: nil)
        
    }
}
