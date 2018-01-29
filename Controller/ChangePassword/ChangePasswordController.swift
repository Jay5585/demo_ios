//
//  ChangePasswordController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 10/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class ChangePasswordController: BaseViewController {
    // Mark: - Attributes -
    var changePasswordView : ChangePasswordView!
    
    // MARK: - Lifecycle -
    
    override init() {
        changePasswordView = ChangePasswordView(frame: .zero)
        super.init(iView: changePasswordView)
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("ChangePasswordController Deinit called")
        NotificationCenter.default.removeObserver(self)

        if changePasswordView != nil && changePasswordView.superview != nil {
            changePasswordView.removeFromSuperview()
            changePasswordView = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
        self.contentSizeInPopup = changePasswordView.container.frame.size
        self.contentSizeInPopup.width = self.view.frame.size.width - 30
        self.loadViewIfNeeded()
        
        self.changePasswordView.btnClose.setButtonTouchUpInsideEvent { (sender, object) in
            self.popupController?.dismiss()
        }
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -

}
