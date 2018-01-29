//
//  WelcomeViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 01/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {

    // Mark: - Attributes -
    var welcomeView : WelcomeView!
    
    // MARK: - Lifecycle -
    
    override init() {
        self.welcomeView = WelcomeView(frame: .zero)
        super.init(iView: welcomeView, andNavigationTitle: "")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("WelcomeViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        if welcomeView != nil && welcomeView.superview != nil {
            welcomeView.removeFromSuperview()
            welcomeView = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        self.welcomeView.btnStart.setButtonTouchUpInsideEvent { (sender, object) in
            self.navigationController?.pushViewController(BasicDetailViewController(), animated: false)
        }
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
