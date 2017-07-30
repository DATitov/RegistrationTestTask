//
//  NetworkLayerProtocols.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 31.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import Foundation

protocol WeatherSource {
    func getTomorowTemperatureInMoscow(success: @escaping ((Double) ->()))
}
