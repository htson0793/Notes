//
//  ViewController.swift
//  Notes
//
//  Created by Hoang Son on 11/5/18.
//  Copyright © 2018 Hoang ap. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class SigninViewController: UIViewController ,GIDSignInUIDelegate {
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SignIn()
    }
    
    func SignIn() {
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userDefault.bool(forKey: "usersignedin") {
            performSegue(withIdentifier: "HomeNote", sender: self)
        }
    }
}

