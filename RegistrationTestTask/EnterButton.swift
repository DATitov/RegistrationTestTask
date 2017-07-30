//
//  EnterButton.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 30.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

class EnterButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = UIColor(red: 255 / 255, green: 155 / 255, blue: 0, alpha: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.size.height / 2
    }

}
