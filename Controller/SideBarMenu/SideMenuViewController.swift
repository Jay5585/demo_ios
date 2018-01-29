//
//  SideMenuViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 05/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup

class SideMenuViewController: BaseViewController {
    
    // Mark: - Attributes -
    var sideMenuView : SideMenuView!
    var popUp : STPopupController!

    var currentSelectedMenu : Int = Menu.home.rawValue
    
    // MARK: - Lifecycle -
    
    override init() {
        sideMenuView = SideMenuView(frame: .zero)
        super.init(iView: sideMenuView)
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("SideMenuViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if sideMenuView != nil && sideMenuView.superview != nil {
            sideMenuView.removeFromSuperview()
            sideMenuView = nil
        }
        popUp = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        sideMenuView.cellSelectedEvent { [weak self] (sendor, object) in
            if self == nil{
                return
            }
            if let index : Int = object as? Int {
                self?.displaySelectedView(type: index)
            }
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
        self.baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        popUp.dismiss()
    }
    
    
    // MARK: - Internal Helpers -
    private func displaySelectedView(type : Int){
        
        if currentSelectedMenu != type || type == Menu.logout.rawValue {
            var controller : BaseViewController? = self.setSelectedMenuObject(menuType: type)
            
            if controller != nil{
                AppUtility.getAppDelegate().navigationController.viewControllers = [controller!]
                if AppUtility.getAppDelegate().frostedController != nil{
                    AppUtility.getAppDelegate().frostedController.hideMenuViewController(completionHandler: { [weak self] in
                        if self == nil{
                            return
                        }
                        AppUtility.getAppDelegate().frostedController.contentViewController = AppUtility.getAppDelegate().navigationController
                    })
                }
                
            }
            
            defer {
                controller = nil
            }
        }
    }
    
    
    private func setSelectedMenuObject(menuType : Int) -> BaseViewController?{
        
        var controller : BaseViewController?
        switch menuType {
        case Menu.home.rawValue:
            
            if let homeCourtId : String = AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KHomeCourtId) as? String, homeCourtId != "" {
                controller = HomeViewController()
            }
            else {
                controller = SelectHomeCourtController()                
            }
            
            break
            
        case Menu.friends.rawValue:
            
            controller = FriendsViewController()
            break
            
        case Menu.search.rawValue:
            
            controller = SearchViewController()
            break
            
        case Menu.friend_Feed.rawValue:
            
            controller = FriendsFeedViewController()
            break
            
        case Menu.setting.rawValue:
            
            controller = SettingViewController(iPopUpMenuType: PopUpMenuType.loginUser, isBackButton: false, peopleData: self.sideMenuView.loginUser!)            
            
            self.sideMenuView.loginUser = nil
            break
            
        default:
            break
        }
        
        if menuType == Menu.logout.rawValue{
            //closeSlider()
            AppUtility.executeTaskInGlobalQueueWithCompletion { [weak self] in
                if self == nil{
                    return
                }
                self!.logoutUser()
            }
            return nil
        }
        else{
            currentSelectedMenu = menuType
        }
        return controller
    }
    
    fileprivate func logoutUser() {
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            
            var controller : BaseAlertController! = BaseAlertController(iTitle: "Logout", iMassage: "Are you sure you want to logout?", iButtonTitle: "Ok",index: -1)
            controller.delegate = self
            
            self!.popUp = STPopupController.init(rootViewController: controller)
            self!.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self!, action: #selector(self!.closePoup(_:))))
            self!.popUp.navigationBarHidden = true
            self!.popUp.hidesCloseButton = true
            self!.popUp.present(in: self!)
            
            controller = nil
        }
    }
    
    // MARK: - Server Request -
    
}

extension SideMenuViewController : BaseAlertViewDelegate {
    
    func didTappedOkButton(_ alertView: BaseAlertController) {
        self.sideMenuView.logoutRequest()
    }
}
