//
//  ViewController.swift
//  Capstone
//
//  Created by Zhanna Voloshina on 2/2/18.
//  Copyright © 2018 Zhanna Voloshina. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    override func viewDidLoad() {
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        
        // use constraints instead later
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height:50 )
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        
        let customFBButton = UIButton(type:.system)
        customFBButton.backgroundColor = .blue
        customFBButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        customFBButton.setTitle("Custom FB Login here", for: .normal)
        view.addSubview(customFBButton)
        
        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    
    }
    
    @objc func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: self) {
            (result, err) in
            if err != nil {
                print("This login has failed", err)
                return
            }
            self.showEmailAddress()

        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        print("Did log out of FB")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
        print("Successfully logged in with Facebook")
        
    }
    
    func showEmailAddress() {
     let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print ("Something went wrong with FB user: ", error)
                return
            }
            print ("Successfully logged in with our user: ", user, "")
            self.performSegue(withIdentifier: "LogInOnboardSegue", sender: self)
        }
        
        
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start{ (connection, result, err) in
            if err != nil {
                print ("Failed to start graph request!", err)
                return
            }
            print(result)
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

