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
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SignIn()
    }
    
    func SignIn() {
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    @IBAction func btnLogin(_ sender: Any) {
 
        self.performSegue(withIdentifier: "HomeNote", sender: nil)
    }
}

