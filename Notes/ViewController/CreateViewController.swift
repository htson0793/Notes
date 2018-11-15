//
//  CreateViewController.swift
//  Notes
//
//  Created by Hoang Son on 11/9/18.
//  Copyright © 2018 Hoang ap. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class CreateViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txvContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out ", style: .done, target: self, action:#selector (btnSignOut))
    }
    
    func reference(to collectionReference: referenceSevices  ) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    
    @IBAction func btnSignOut() {
        GIDSignIn.sharedInstance().signOut()
        print("Sign Out")
    }
    
    @IBAction func btnNewNote(_ sender: Any) {
        let user =  Auth.auth().currentUser
        let userUid = user?.uid
        
        guard let textTitle = txtTitle.text else {return}
        guard let textContent = txvContent.text else {return}
        let dataSave : [String: Any] = [notesDocuments.title : textTitle,
                                        notesDocuments.content : textContent,
                                        Users.uid : userUid as Any]
        reference(to: .notes).addDocument(data: dataSave){(error) in
            if let error = error {
                print("Error")
                
            } else {
                print("OK!")
                
            }
      
        }
    }
}
