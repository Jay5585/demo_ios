//
//  ForgotPasswordViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 01/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    // Mark: - Attributes -
    var forgotPasswordView : ForgotPasswordView!
    
    // MARK: - Lifecycle -
    
    override init() {
        forgotPasswordView = ForgotPasswordView(frame: .zero)
        super.init(iView: forgotPasswordView, andNavigationTitle: "Forgot Password")
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("ForgotPasswordViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if forgotPasswordView != nil && forgotPasswordView.superview != nil {
            forgotPasswordView.removeFromSuperview()
            forgotPasswordView = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
        self.contentSizeInPopup = forgotPasswordView.container.frame.size
        self.contentSizeInPopup.width = self.view.frame.size.width - 30
        self.loadViewIfNeeded()
        
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
