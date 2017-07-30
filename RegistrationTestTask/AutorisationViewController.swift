//
//  AutorisationViewController.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 30.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import RxSwift

class AutorisationViewController: UIViewController {
    
    @IBOutlet weak var eMailInputView: AutorisationInputView!
    @IBOutlet weak var passwordInputView: AutorisationPasswordInputView!
    @IBOutlet weak var enterButton: EnterButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    var keyboardFrameInScreen = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: 0, height: 0)
    
    let viewModel = AutorisationScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Bindings
    
    func initBindings() {
        
        //  Observe Keyboard appearence
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        //  Show temperature when it is fetched
        _ = viewModel.temperatureInMoscow.asObservable()
            .skip(1)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (temp) in
                guard let weakself = self else { return }
                weakself.showTemperatureInMoscow()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Setup UI
    
    func setupUI() {
        eMailInputView.title.value = "Почта"
        eMailInputView.textField.keyboardType = .emailAddress
        passwordInputView.title.value = "Пароль"
        self.navigationController?.navigationBar.topItem?.title = "";
    }
    
    // MARK: Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutSubviews()
    }
    
    func layoutSubviews() {
        let leadingSpace : CGFloat = 15
        let inputViewHeight: CGFloat = 45
        let betweenInputViewsSpace: CGFloat = 12
        let betweenPasswordInputAndEnterButtonSpace: CGFloat = 34
        let enterButtonSize = CGSize(width: 147, height: 44)
        let betweenButtonsSpace: CGFloat = 21
        let registerButtonSize = CGSize(width: 258, height: 18)
        let contentHeight: CGFloat = inputViewHeight * 2 + betweenInputViewsSpace + betweenPasswordInputAndEnterButtonSpace + enterButtonSize.height + betweenButtonsSpace + registerButtonSize.height
        let inputEMailViewYCoord = { (keyboardFrameInScreen: CGRect, screenHeight: CGFloat, contentHeight: CGFloat, navigationBarHeight: CGFloat) -> CGFloat in
            let defaultTopSpace: CGFloat = 211
            if keyboardFrameInScreen.origin.y - 5.0 < defaultTopSpace + contentHeight {
                return (keyboardFrameInScreen.origin.y - navigationBarHeight - contentHeight) / 2 + navigationBarHeight
            }else{
                return defaultTopSpace
            }
        }(keyboardFrameInScreen, UIScreen.main.bounds.size.height, contentHeight, (navigationController?.navigationBar.frame.size.height)!)
        let inputViewWidth = view.frame.size.width - leadingSpace * 2
        
        eMailInputView.frame = CGRect(x: leadingSpace, y: inputEMailViewYCoord, width: inputViewWidth, height: inputViewHeight)
        passwordInputView.frame = CGRect(x: leadingSpace, y: inputEMailViewYCoord + inputViewHeight + betweenInputViewsSpace, width: inputViewWidth, height: inputViewHeight)
        enterButton.frame = CGRect(x: (view.frame.size.width - enterButtonSize.width) / 2, y: inputEMailViewYCoord + inputViewHeight * 2 + betweenInputViewsSpace + betweenPasswordInputAndEnterButtonSpace,
                                   width: enterButtonSize.width, height: enterButtonSize.height)
        registerButton.frame = CGRect(x: (view.frame.size.width - registerButtonSize.width) / 2, y: inputEMailViewYCoord + inputViewHeight * 2 + betweenInputViewsSpace + enterButtonSize.height + betweenButtonsSpace + betweenPasswordInputAndEnterButtonSpace,
                                      width: registerButtonSize.width, height: registerButtonSize.height)
    }
    
    // MARK: Actions
    
    @IBAction func enterButtonPressed(_ sender: Any) {
        var errorMessage = EMailValidator().isValid(eMail: eMailInputView.textField.text!)
        if errorMessage != nil {
            showErrorMessage(message: errorMessage!)
            return
        }
        errorMessage = PasswordValidator().isValid(password: passwordInputView.password.value)
        if errorMessage != nil {
            showErrorMessage(message: errorMessage!)
            return
        }
        viewModel.fetchTemperature()
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        //  Empty method
    }
    
    // MARK: Show dislog
    
    func showErrorMessage(message: String) {
        let newMessage = message + "\nПожалуйста, откорректируйте введенные данные и попробуйте войти еще раз"
        let alert = UIAlertController(title: "Ошибка", message: newMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showTemperatureInMoscow() {
        let newMessage = "В Москве \(viewModel.temperatureInMoscow.value) градус Цельсия"
        let alert = UIAlertController(title: "", message: newMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Notifications
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        guard let destinationFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let duration: TimeInterval = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
        keyboardFrameInScreen = destinationFrame
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: {
                        self.layoutSubviews()
        },
                       completion: nil)
    }
    
}
