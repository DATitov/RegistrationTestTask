//
//  EntryViewController.swift
//  RegistrationTestTask
//
//  Created by Dmitrii Titov on 30.07.17.
//  Copyright © 2017 Dmitriy Titov. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
