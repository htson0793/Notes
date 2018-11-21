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
        customNavigation()
    }
    func customNavigation() {
    navigationItem.title = "Tạo Mới"
    self.navigationItem.hidesBackButton = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Xong", style: .done, target: self, action:#selector (btnSuccess))
    }
    
    func reference(to collectionReference: referenceSevices  ) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    
    @IBAction func btnSuccess() {
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
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNewNote(_ sender: Any) {
    navigationController?.popViewController(animated: true)
    }
}
