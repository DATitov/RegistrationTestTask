//
//  WeatherSourceOpenWeatherMap.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 31.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import Alamofire

class WeatherSourceOpenWeatherMap: WeatherSource {
    
    fileprivate let city = "Moscow"
    fileprivate let location_short = "ru"
    fileprivate let app_id = "3aaa7759572ba90b33a04ea144548276"
    fileprivate let version = "2.5"
    
    func getTomorowTemperatureInMoscow(success: @escaping ((Double) ->())) {
        Alamofire.request("http://api.openweathermap.org/data/\(version)/weather?q=\(city),\(location_short)&appid=\(app_id)").responseJSON { response in
            
            if let json = response.result.value {
                let dict = json as! [String: Any]
                guard let main = dict["main"] as? [String: Any] else { return }
                guard let temp = main["temp"] as? Double else { return }
                success(temp)
            }
        }
    }
    
}
