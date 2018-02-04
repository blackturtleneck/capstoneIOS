//
//  ViewController.swift
//  Capstone
//
//  Created by Zhanna Voloshina on 2/2/18.
//  Copyright © 2018 Zhanna Voloshina. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    override func viewDidLoad() {
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        
        // use constraints instead later
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height:50 )
        
        loginButton.delegate = self
        
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of FB")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Successfully logged in with Facebook")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

