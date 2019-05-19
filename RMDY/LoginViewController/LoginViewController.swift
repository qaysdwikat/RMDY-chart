//
//  LoginViewController.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/17/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField?
    @IBOutlet weak var password: UITextField?

    override func viewDidLoad() {
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        if let username = username?.text, let password = password?.text, !username.isEmpty, !password.isEmpty {
            
            let data = LoginModel()
            data.userName = username
            data.password = password
            
            WebServices.login(data) { response in
                
                if let response = response {
                    
                    LoginManager.shareInstance.tokens = response
                    
                    UserdefaultsUtil.setUser(user: data)
                    
                    let storyboard = UIStoryboard(name: "ChartStorybord", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "chartStorybord")
                    
                    DispatchQueue.main.async {
                        
                        if let window = (UIApplication.shared.delegate as? AppDelegate)?.window {
                            
                            window.rootViewController = controller
                            window.makeKeyAndVisible()
                        }
                    }
                }
            }
        } else {
            
            UIUtils.showAlertView(text: "Please enter valid Username & Password")
        }
    }
}
