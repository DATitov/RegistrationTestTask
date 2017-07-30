//
//  AutorisationPasswordInputView.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 30.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import RxSwift

class AutorisationPasswordInputView: AutorisationInputView {

    let changePasswordButton = UIButton()
    
    let password = Variable<String>("")
    
    fileprivate let changePasswordButtonTitle = "Забыли пароль?"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        
        textField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButtons()
        
        textField.delegate = self
    }
    
    // MARK: Setup UI
    
    func setupButtons() {
        addSubview(changePasswordButton)
        
        changePasswordButton.layer.cornerRadius = 3
        changePasswordButton.layer.borderColor = UIColor(red: 235 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1).cgColor
        changePasswordButton.layer.borderWidth = 1
        
        setButtonUnhighlightedState()
        
        changePasswordButton.addTarget(self, action: #selector(buttonPresed), for: .touchUpInside)
        changePasswordButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        changePasswordButton.addTarget(self, action: #selector(buttonCanceled), for: .touchUpOutside)
        changePasswordButton.addTarget(self, action: #selector(buttonCanceled), for: .touchCancel)
        changePasswordButton.addTarget(self, action: #selector(buttonCanceled), for: .touchDragExit)

    }
    
    // MARK: Actions
    
    @objc func buttonPresed() {
        setButtonUnhighlightedState()
    }
    
    @objc func buttonHighlighted() {
        setButtonHighlightedState()
    }
    
    @objc func buttonCanceled() {
        setButtonUnhighlightedState()
    }
    
    func setButtonHighlightedState() {
        let attributetTitle = NSAttributedString(string: changePasswordButtonTitle,
                                                 attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12),
                                                              NSForegroundColorAttributeName: UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)])
        changePasswordButton.setAttributedTitle(attributetTitle, for: .normal)
    }
    
    func setButtonUnhighlightedState() {
        let attributetTitle = NSAttributedString(string: changePasswordButtonTitle,
                                                 attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12),
                                                              NSForegroundColorAttributeName: UIColor(red: 121 / 255, green: 121 / 255, blue: 121 / 255, alpha: 1)])
        changePasswordButton.setAttributedTitle(attributetTitle, for: .normal)
    }
    
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonWidth: CGFloat = 113
        let betweenSpace: CGFloat = 5
        textField.frame = CGRect(x: 0, y: textField.frame.origin.y,
                                 width: frame.size.width - betweenSpace - buttonWidth, height: textField.frame.height)
        changePasswordButton.frame = CGRect(x: frame.size.width - buttonWidth, y: 6,
                                            width: buttonWidth, height: 30)
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = { (oldText: String, range: NSRange, string: String) -> String in
            var newText = ""
            let leftPart = { (text: String, selectionRange: NSRange) -> String in
                if selectionRange.location < 1 {
                    return ""
                }else{
                    let index = text.index(text.startIndex, offsetBy: selectionRange.location)
                    return text.substring(to: index)
                }
            }(oldText, range)
            let rightPart = { (text: String, selectionRange: NSRange) -> String in
                if selectionRange.location >= text.characters.count {
                    return ""
                }else{
                    let index = text.index(text.startIndex, offsetBy: selectionRange.location + selectionRange.length)
                    return text.substring(from: index)
                }
            }(oldText, range)
            newText = leftPart + string + rightPart
            return newText
        }(password.value, range, string)
        password.value = newText
        let newSecureText = { (length) -> String in
            var newText = ""
            for _ in 0..<length {
                newText += "*"
            }
            return newText
        }(password.value.characters.count)
        textField.text = newSecureText
        return false
    }

}

