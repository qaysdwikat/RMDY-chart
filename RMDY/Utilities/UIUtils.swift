//
//  UIUtils.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import UIKit


class UIUtils {
    
    //get currentViewController (topViewController)
    class func currentViewController() -> UIViewController? {
        
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        if topController != nil {
            
            while topController?.presentedViewController != nil {
                
                topController = topController?.presentedViewController
            }
        }
        
        return topController
    }
    
    //get currentNavigationController
    class func currentNavController() -> UINavigationController? {
        
        return UIUtils.currentViewController() as? UINavigationController ?? UIUtils.currentViewController()?.navigationController
    }
    
    class func showAlertView(text: String)  {
        
        let alertController = UIAlertController(title: "Error message", message: text, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        UIUtils.currentViewController()?.present(alertController, animated: true, completion: nil)
    }
    
}
