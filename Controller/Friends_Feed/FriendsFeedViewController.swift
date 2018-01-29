//
//  FriendsFeedViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class FriendsFeedViewController: BaseViewController {
    
    // Mark: - Attributes -
    var friendsFeedView : FriendsFeedView!
    
    // MARK: - Lifecycle -
    
    override init() {
        friendsFeedView = FriendsFeedView(frame: .zero)
        super.init(iView: friendsFeedView, andNavigationTitle: "Friends Feed")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("FriendsFeedViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if friendsFeedView != nil && friendsFeedView.superview != nil {
            friendsFeedView.removeFromSuperview()
            friendsFeedView = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        self.displayMenuButton()
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
        baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
}
