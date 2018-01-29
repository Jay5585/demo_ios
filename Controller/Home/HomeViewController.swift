//  HomeViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 03/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup

class HomeViewController: BaseViewController {

    // Mark: - Attributes -
    var homeView : HomeView!
    
    var forceToLoginPopUp : BaseAlertController!
    var popUp : STPopupController!
    
    
    var isBackButton : Bool = false
    var courtId : String = ""
    // MARK: - Lifecycle -
    
    
    override init() {

        homeView = HomeView(frame: .zero)
        super.init(iView: homeView, andNavigationTitle: "Home")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    init(isBackButton : Bool, courtId : String) {
        
        self.isBackButton = isBackButton
        self.courtId = courtId
        
        homeView = HomeView(isBackButton : isBackButton, courtId : courtId)
        super.init(iView: homeView, andNavigationTitle: "Home")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("HomeViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if homeView != nil && homeView.superview != nil {
            homeView.removeFromSuperview()
            homeView = nil
        }
        popUp = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeView.segmentView.setSegementSelectedAtIndex(0)
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
        if self.isBackButton == false {
            self.displayMenuButton()
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
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        popUp.dismiss()
    }
    
    
    // MARK: - Server Request -

}
// MARK: - BaseAlertViewDelegate
extension HomeViewController : BaseAlertViewDelegate {
    func didTappedOkButton(_ alertView: BaseAlertController) {
        if self.forceToLoginPopUp != nil && self.forceToLoginPopUp == alertView {
            self.forceToLoginPopUp = nil
            AppUtility.getAppDelegate().displayLoginViewOnWindow()
        }
    }
}
