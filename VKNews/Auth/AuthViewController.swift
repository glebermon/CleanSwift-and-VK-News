//
//  ViewController.swift
//  CreatingViews
//
//  Created by Глеб on 20/09/2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService : AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        authService = AuthService()
        authService = AppDelegate.shared().authService
    }
    
    
    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }
}
