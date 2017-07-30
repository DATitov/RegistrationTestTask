//
//  PasswordValidator.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 31.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

class PasswordValidator {

    func isValid(password: String) -> String? {
        if password.characters.count < 6 {
            return "Пароль должен состаять из шести и более символов"
        }
        if password.uppercased() == password {
            return "Пароль должен содержать как минимум одну строчную букву"
        }
        if password.lowercased() == password {
            return "Пароль должен содержать как минимум одну заглавную букву"
        }
        var numbersCount = 0
        let digitSet = CharacterSet.decimalDigits
        for char in password.unicodeScalars {
            if digitSet.contains(char) {
                numbersCount += 1
            }
        }
        if numbersCount <= 0 {
            return "Пароль должен содержать как минимум одну цифру"
        }
        return nil
    }
    
}
