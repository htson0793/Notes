//
//  CreateViewController.swift
//  Notes
//
//  Created by Hoang Son on 11/9/18.
//  Copyright © 2018 Hoang ap. All rights reserved.
//

import UIKit
import Firebase

class CreateViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txvContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reference(to collectionReference: referenceSevices ) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    @IBAction func btnNewNote(_ sender: Any) {
        guard let textTitle = txtTitle.text else {return}
        guard let textContent = txvContent.text else {return}
        let dataSave : [String: Any] = ["title" : textTitle,
                                    "content" : textContent]
        reference(to: .notes).addDocument(data: dataSave){(error) in
            if let error = error {
                print("Error")
            } else {
                print("OK!")
            }
        }
    }
}
