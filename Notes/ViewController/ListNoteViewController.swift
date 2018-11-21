//
//  ListNoteViewController.swift
//  Notes
//
//  Created by Hoang Son on 11/6/18.
//  Copyright © 2018 Hoang ap. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn


class ListNoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tvListNote: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var notes = [Notes]()
    var currentNotes = [Notes]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        readList()
    }
    
    func customizeUI()
    {
        self.searchBar.delegate = self
        self.tvListNote.delegate = self
        self.tvListNote.dataSource = self
        self.tvListNote.register(UINib(nibName: "ListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListNote")
    }
    
    
    func reference(to collectionReference: referenceSevices ) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    
    func readList() {
        let user =  Auth.auth().currentUser
        let userUid = user?.uid
        
        reference(to: .notes).whereField(Users.uid, isEqualTo: userUid as Any).addSnapshotListener{(Snapshot, error) in
            self.notes.removeAll()
            guard let documents = Snapshot?.documents else {
                print("khong lay duoc du lieu")
                return
            }
            for document in documents {
                
                var objDoc = Notes()
                objDoc.title = document.get(notesDocuments.title) as? String
                objDoc.content = document.get(notesDocuments.content) as? String
                objDoc.listid = document.documentID
                self.notes.append(objDoc)
                self.currentNotes = self.notes
            }
            DispatchQueue.main.async {
            self.tvListNote.reloadData()
            }
        }
    }
    
   

   
    @IBAction func btnList(_ sender: UIButton) {
        if sender.currentImage == #imageLiteral(resourceName: "ic_list") {
            sender.setImage(#imageLiteral(resourceName: "ic_list"), for: .normal)
        }else{
            sender.setImage(#imageLiteral(resourceName: "ic_list_off"), for: .normal)
        }
    }
    
    @IBAction func btnSetting(_ sender: UIButton) {
        if sender.currentImage == #imageLiteral(resourceName: "ic_setting_off") {
            sender.setImage(#imageLiteral(resourceName: "ic_setting"), for: .normal)
            let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
            let createSettingVC = sb.instantiateViewController(withIdentifier: "CreateSettingVC") as! SettingViewController
            self.navigationController?.pushViewController(createSettingVC, animated: true)
           
        }else{
            sender.setImage(#imageLiteral(resourceName: "ic_setting_off"), for: .normal)
        }
    }
    
    @IBAction func btnNewNote(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let creVC = sb.instantiateViewController(withIdentifier: "newVC") as! CreateViewController
        self.navigationController?.pushViewController(creVC, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard  !searchText.isEmpty else {
            currentNotes = notes
            tvListNote.reloadData()
            return
        }
        currentNotes = notes.filter({ note -> Bool in
             note.title!.lowercased().contains(searchText.lowercased())
        })
        tvListNote.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentNotes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ListNote", for: indexPath) as! ListTableViewCell
        let note = currentNotes[indexPath.row]
        cell.lbTitle.text = note.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        let user =  Auth.auth().currentUser
        let userUid = user?.uid
        let deletedNote = notes[indexPath.row]
        let documentID = deletedNote.listid
        self.reference(to: .notes).document(documentID!).delete()
        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let editVC = sb.instantiateViewController(withIdentifier: "editVC") as! EditViewController
        editVC.contentList = notes[indexPath.row].content
        editVC.titleList = notes[indexPath.row].title
        editVC.editID = notes[indexPath.row].listid
        self.navigationController?.pushViewController(editVC, animated: true)
        
        }
    
}



