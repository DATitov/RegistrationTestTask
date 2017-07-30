//
//  EMailValidator.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 31.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

class EMailValidator {
    
    func isValid(eMail:String) -> String? {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        if !emailTest.evaluate(with: eMail) {
            return "Почта введена некорректно"
        }
        return nil
    }
    
}
