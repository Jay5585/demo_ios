//
//  SignUpViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 02/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    // Mark: - Attributes -
    var signUpView : SignUpView!
    
    // MARK: - Lifecycle -
    
    override init() {
        
        signUpView = SignUpView(frame: .zero)
        super.init(iView: signUpView, andNavigationTitle: "Registration")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("SignUpViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if signUpView != nil && signUpView.superview != nil {
            signUpView.removeFromSuperview()
            signUpView = nil
        }
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
        self.baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -

}
