//
//  AutorisationScreenViewModel.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 31.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import RxSwift

class AutorisationScreenViewModel {

    let temperatureInMoscow = Variable<Double>(0)
    
    func fetchTemperature() {
        NetworkInteractor.shared.getTomorowTemperatureInMoscow { [weak self] (temp) -> () in
            guard let weakSelf = self else { return }
            weakSelf.temperatureInMoscow.value = TemperatureParser().kelvinToCelsius(temp: temp)
        }
    }
    
}
