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
    
    var users = [Users]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignIn()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func reference(to collectionReference: referenceSevices ) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    func SignIn() {
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
    }
    
    
    
    @IBAction func btnLogin(_ sender: Any) {
 
        self.performSegue(withIdentifier: "HomeNote", sender: nil)
    }
}

