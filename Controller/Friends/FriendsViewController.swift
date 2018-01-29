//
//  FriendsViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class FriendsViewController: BaseViewController {
    // Mark: - Attributes -
    var friendsView : FriendsView!
    
    // MARK: - Lifecycle -
    
    override init() {
        friendsView = FriendsView(frame: .zero)
        super.init(iView: friendsView, andNavigationTitle: "Friends")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("FriendsViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if friendsView != nil && friendsView.superview != nil {
            friendsView.removeFromSuperview()
            friendsView = nil
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
        self.baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    
    
}
