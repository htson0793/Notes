//
//  Appdelegate:GoogleSignin.swift
//  Notes
//
//  Created by Hoang Son on 11/7/18.
//  Copyright © 2018 Hoang ap. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

extension AppDelegate: GIDSignInDelegate {

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let err = error {
                print("Đăng nhập thất bại: ",err)
            return
            } else {
                print("Đăng nhập thành công : ",user)
            }
        guard let authentication = user.authentication else { return }
        
         let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
         Auth.auth().signInAndRetrieveData(with: credential) {(result, error) in
            if let err = error {
                print("Tạo firebase không thành công ")
            } else {
                print("Tạo firebase thành công")
    
              let sb = UIStoryboard(name: "Main", bundle:Bundle.main)
              let views = sb.instantiateViewController(withIdentifier: "mainList") as! ListNoteViewController
                let nav:UINavigationController = UINavigationController(rootViewController: views)
               self.window?.rootViewController = nav
                
            }
            
         }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        }
    }
