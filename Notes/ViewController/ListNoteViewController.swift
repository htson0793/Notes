//
//  ListNoteViewController.swift
//  Notes
//
//  Created by Hoang Son on 11/6/18.
//  Copyright © 2018 Hoang ap. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ListNoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tvListNote: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var db: Firestore!
    var notes = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        customizeUI()
        readList()
    }
    
    func customizeUI()
    {
        self.tvListNote.delegate = self
        self.tvListNote.dataSource = self
        self.tvListNote.register(UINib(nibName: "ListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListNote")
    }
    
    
    func reference(to collectionReference: referenceSevices ) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    
    func readList() {
        reference(to: .notes).getDocuments{(Snapshot, error ) in
            if let error = error {
                print("Lỗi")
            } else {
            if let Snapshot = Snapshot {
                for document in Snapshot.documents {
                    if let dataDoc = document.data() as! [String:Any]? {
                        var objNote = Notes()
                        objNote.title = dataDoc["title"] as! String
                        objNote.content = dataDoc["content"] as! String
                        self.notes.append(objNote)
                        }
                    self.tvListNote.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func btnList(_ sender: Any) {
        
    }
    
    @IBAction func btnSetting(_ sender: Any) {
        
    }
    
    @IBAction func btnNewNote(_ sender: Any) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier:"ListNote", for: indexPath) as! ListTableViewCell
       let note = notes[indexPath.row]
        cell.lbTitle.text = note.title
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
}
