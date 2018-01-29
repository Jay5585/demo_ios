//
//  LoginViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 01/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup

class LoginViewController: BaseViewController {

    // Mark: - Attributes -
    var loginView : LoginView!
    var popUp : STPopupController!
    
    // MARK: - Lifecycle -
    
    override init() {
        loginView = LoginView(frame: .zero)
        super.init(iView: loginView, andNavigationTitle: "Login")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    deinit {
        print("LoginViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
     
        if loginView != nil && loginView.superview != nil {
            loginView.removeFromSuperview()
            loginView = nil
        }
        
        popUp = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        popUp.dismiss()
    }
    // MARK: - Server Request -

}
