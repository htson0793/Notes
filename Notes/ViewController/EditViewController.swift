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
    var notes = [Notes]()
    var edit = [Edits]()
    var editID : String?
    var titleList : String?
    var contentList : String?
    
    @IBOutlet weak var lbEditTitle: UITextField!
    @IBOutlet weak var lbEditContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldData()
        customNavigation()
    }
    
    func customNavigation() {
        navigationItem.title = "Sửa"
        self.navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Xong", style: .done, target: self, action:#selector (btnSuccess))
    }
    
    func reference(to collectionReference: referenceSevices  ) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    @IBAction func btnSuccess() {
        let user =  Auth.auth().currentUser
        let userUid = user?.uid
        
        
        guard let textTitle = lbEditTitle.text else {return}
        guard let textContent = lbEditContent.text else {return}
        let dataSave : [String: Any] = [notesDocuments.title : textTitle,
                                        notesDocuments.content : textContent,
                                        Users.uid : userUid as Any]
        
        reference(to: .notes).document(editID!).setData(dataSave)
         navigationController?.popViewController(animated: true)
        
    }

    
    func textFieldData(){
        self.lbEditTitle.text = titleList!
        self.lbEditContent.text = contentList!
    }
    
    @IBAction func btnEdit(_ sender: Any) {
    navigationController?.popViewController(animated: true)
        
    }

}

