//
//  SettingViewController.swift
//  Notes
//
//  Created by Hoang Son on 11/17/18.
//  Copyright © 2018 Hoang ap. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseStorage

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lbProfile: UILabel!
    
    @IBOutlet weak var tvSetting: UITableView!
    
    var mysetting = ["Cỡ Chữ", "Màu Chữ", "Mã Bảo Vệ"]
    var setting = [SettingValue]()
    var photos = [Photo]()
    @IBOutlet weak var btnSignOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvSetting.delegate = self
        self.tvSetting.dataSource = self
        self.tvSetting.register(UINib(nibName: "SettingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SettingCell")
        CustomSetting()
    }
    
    func CustomSetting() {
        //self.navigationController?.isNavigationBarHidden = true
        
        let user =  Auth.auth().currentUser
        let userUid = user?.uid
        
        btnSignOut.layer.cornerRadius = btnSignOut.frame.height/2
        btnSignOut.layer.shadowColor = UIColor.gray.cgColor
        btnSignOut.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        
        //PhotoID
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child(Photo.image)
        
        let data = Data()
        let uploadData = imageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                return
            }
        let size = metadata.size
            imageRef.downloadURL{(url, error) in
                guard let downloadURL = url else {
                    return
                }
            }
        }
        
        
        //email
        self.lbProfile.text = Auth.auth().currentUser?.email
        
    }
    
    
    @IBAction func btnSignout(_ sender: Any) {
        //SignOut
        GIDSignIn.sharedInstance().signOut()
        
        
        //Backsignin
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = sb.instantiateViewController(withIdentifier: "signinVC")
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mysetting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingTableViewCell
        
        cell.lbSetting.text = mysetting[indexPath.row]
 
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

