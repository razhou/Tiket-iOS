//
//  UIViewControllerExt.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 22/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import MBProgressHUD

extension UIViewController{
    
    func showHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }
    
    /*
     show alert with ok and cancel
     can fill function with nill if isn't want do action
     */
    
    func showAlertMessage(vc: UIViewController,
                          withTitle: String,
                          message: String,
                          isOk:(() -> Void)?,
                          isCancel:(() -> Void)?) -> Void {
        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            
            if (isOk != nil){
                
                do {
                    
                    try isOk!()
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }))
        
        if (isCancel != nil) {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in
                isCancel!()
            }))
        }
        
        vc.present(alert, animated: true, completion: nil)
    }
    
}
