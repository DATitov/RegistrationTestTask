//
//  AutorisationInputView.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 30.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AutorisationInputView: UIView {
    
    let disposeBag = DisposeBag()
    
    let titleLabel = UILabel()
    let textField = UITextField()
    let separatorView = UIView()
    
    let title = Variable<String>("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        initBindings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
        initBindings()
    }
    
    // MARK: Bindings
    
    func initBindings() {
        
        _ = title.asObservable()
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (title) in
                guard let weakSelf = self else { return }
                weakSelf.titleLabel.attributedText = NSAttributedString(string: title,
                                                                        attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16),
                                                                                     NSForegroundColorAttributeName: UIColor(red: 121 / 255, green: 121 / 255, blue: 121 / 255, alpha: 1)])
            })
            .disposed(by: disposeBag)
        
    }
    
    // MARK: Setup UI
    
    func setupUI() {
        for view in [titleLabel,
                     textField,
                     separatorView] {
                        addSubview(view)
        }
        
        textField.delegate = self
        
        separatorView.backgroundColor = UIColor(red: 235 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1)
    }
    
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 17)
        textField.frame = CGRect(x: 0, y: 21, width: frame.size.width, height: 19)
        separatorView.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1)
    }
    
}

extension AutorisationInputView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}


