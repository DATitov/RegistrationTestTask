//
//  NetworkInteractor.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 31.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

private let sharedInstance = NetworkInteractor()

class NetworkInteractor {
    
    class var shared : NetworkInteractor {
        return sharedInstance
    }

    fileprivate let weatherSource: WeatherSource = WeatherSourceOpenWeatherMap()
    
    func getTomorowTemperatureInMoscow(success: @escaping ((Double) ->())) {
        weatherSource.getTomorowTemperatureInMoscow(success: success)
    }
    
}
