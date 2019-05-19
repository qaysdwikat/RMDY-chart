//
//  SplashViewController.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    
        if let data = LoginManager.shareInstance.loginModel {
            
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
            
            let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "loginStoryboard")
            
            DispatchQueue.main.async {
                
                if let window = (UIApplication.shared.delegate as? AppDelegate)?.window {
                    
                    window.rootViewController = controller
                    window.makeKeyAndVisible()
                }
            }
        }
    }
}
