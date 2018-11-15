//
//  EditViewController.swift
//  Notes
//
//  Created by Hoang Son on 11/14/18.
//  Copyright © 2018 Hoang ap. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UIViewController {
    var note = [Notes]()
    var edit = [Edits]()
    var editID : String?
    @IBOutlet weak var lbEditTitle: UITextField!
    @IBOutlet weak var lbEditContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func reference(to collectionReference: referenceSevices  ) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        let user =  Auth.auth().currentUser
        let userUid = user?.uid
        
        let dataSave : [String:Any] = [notesDocuments.title : lbEditTitle.text as Any,
                                        notesDocuments.content : lbEditContent.text,
                                        Users.uid : userUid as Any]
        reference(to: .notes).whereField(Users.uid, isEqualTo: userUid as Any).addSnapshotListener{(Snapshot, error) in
            guard let documents = Snapshot?.documents else {
                print("khong lay duoc du lieu")
                return
            }
            
            for document in documents {
                let km = document.documentID
                self.reference(to: .notes).document(km).updateData(dataSave)
                
             
            }
        }
    }
}

        

