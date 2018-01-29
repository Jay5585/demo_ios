//
//  BasicDetailViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class BasicDetailViewController: BaseViewController {
    
    // Mark: - Attributes -
    var basicDetailView : BasicDetailView!
    
    // MARK: - Lifecycle -
    
    override init() {
        basicDetailView = BasicDetailView(frame: .zero)
        super.init(iView: basicDetailView, andNavigationTitle: "Create Profile")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("BasicDetailViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        if basicDetailView != nil && basicDetailView.superview != nil {
            basicDetailView.releaseObject()
            basicDetailView.removeFromSuperview()
            basicDetailView = nil
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
