//
//  EditProfileController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 11/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class EditProfileController: BaseViewController {
    
    // Mark: - Attributes -
    var editProfileView : EditProfileView!
    
    // MARK: - Lifecycle -
    
    init(userDetail : People) {
        editProfileView = EditProfileView(userDetail: userDetail)
        super.init(iView: editProfileView, andNavigationTitle: "Edit Profile")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("EditProfileController deinit called")
        if editProfileView != nil && editProfileView.superview != nil {
            editProfileView.releaseObject()
            editProfileView.removeFromSuperview()
            editProfileView = nil
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
        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
}
