//
//  SettingViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup
import SwiftEventBus

class SettingViewController: BaseViewController {
    // Mark: - Attributes -
    var settingView : SettingView!
    var popUp : STPopupController!
    var alertController : BaseAlertController!
    
    
    var moreMenuPopUp : WYPopoverController!
    var popUpMenuType : PopUpMenuType!
    var isBackButton = false
    
    // MARK: - Lifecycle -
    
    init(iPopUpMenuType : PopUpMenuType,isBackButton : Bool, peopleData : People) {
        
        self.popUpMenuType = iPopUpMenuType
        self.isBackButton = isBackButton
        
        settingView = SettingView(iPopUpMenuType: iPopUpMenuType, peopleData: peopleData)
        super.init(iView: settingView, andNavigationTitle: "User Profile")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingView.segmentView.setSegementSelectedAtIndex(0)
      
    }
    
    deinit {
        print("SettingViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if moreMenuPopUp != nil {
            moreMenuPopUp.dismissPopover(animated: false)
            if let controller : MoreMenuViewController = moreMenuPopUp.contentViewController as? MoreMenuViewController {
                controller.tableView.delegate = nil
                controller.tableView.dataSource = nil
            }
            moreMenuPopUp.delegate = nil
            moreMenuPopUp = nil
        }
        
        if settingView != nil && settingView.superview != nil {
            settingView.removeFromSuperview()
            settingView = nil
        }
        popUpMenuType = nil
        
        popUp = nil
        alertController = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.settingView.scheduleView.tblSchedule.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            InterfaceUtility.setCircleViewWith(.clear, width: 0.1, ofView: self!.settingView.imgProfile)
        }
    }
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
        if !self.isBackButton {
            self.displayMenuButton()
        }
        
        var btnName : UIButton!
        btnName = UIButton()
        btnName.setImage(UIImage(named: "MoreMenu"), for: UIControlState())
        btnName.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnName.addTarget(self, action: #selector(btnMoreTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnName)
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
        
        baseLayout.releaseObject()
    }
    
    func btnMoreTapped(sender : UIButton) {
        var controller : MoreMenuViewController! = MoreMenuViewController(iPopUpMenuType: popUpMenuType)
        
        switch self.popUpMenuType.rawValue {
        case PopUpMenuType.loginUser.rawValue :
            controller.preferredContentSize = CGSize(width: 160.0, height: 120)
            break
        case PopUpMenuType.otherUser.rawValue :
            controller.preferredContentSize = CGSize(width: 160.0, height: 40)
            break
        default: break
        }
        
        controller.tableView.delegate = self
        controller.tableView.dataSource = self
        
        moreMenuPopUp = WYPopoverController(contentViewController: controller)
        moreMenuPopUp.delegate = self
        
         moreMenuPopUp.presentPopover(from: sender.bounds, in: sender, permittedArrowDirections: .right, animated: true, options: .fadeWithScale)
        
        controller = nil
        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        self.alertController = nil
        popUp.dismiss()
    }
    
    
    // MARK: - Internal Helpers -
    
    
    // MARK: - Server Request -
    
    fileprivate func addFriendRequest() {
        self.settingView.operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(self!.settingView.peopleData.userId, forKey: "friendId")
            
            BaseAPICall.shared.postReques(URL: APIConstant.addFriend, Parameter: dictParameter, Type: APITask.AddFriend, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(_, let error):
                    self!.settingView.hideProgressHUD()
                    
                    AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
                        if self == nil {
                            return
                        }
                        
                        self!.settingView.peopleData.friendStatus = "1"
                        SwiftEventBus.post(NotificationKey.addFriend, sender: self!.settingView.peopleData.userId as AnyObject)
                        self!.settingView.makeToast(error!.alertMessage, duration: ToastManager.shared.duration, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tappable) in
                            if self == nil {
                                return
                            }
                            _ = self!.navigationController?.popViewController(animated: true)
                        })
                    }
                    break
                    
                case .Error(let error):
                    self!.settingView.hideProgressHUD()
                    self!.settingView.makeToast(error!.alertMessage)
                    break
                    
                case .Internet(let isOn):
                    self!.settingView.handleNetworkCheck(isAvailable: isOn, insideView: AppUtility.getAppDelegate().window!)
                    break
                }
            })
        }
    }
    
    fileprivate func removeFriendRequest() {
        
        self.settingView.operationQueue.cancelAllOperations()
        self.settingView.operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(self?.settingView.peopleData.userId, forKey: "friendId")
            
            self?.navigationItem.rightBarButtonItem?.isEnabled = false
            
            BaseAPICall.shared.postReques(URL: APIConstant.removeFriend, Parameter: dictParameter, Type: APITask.RemoveFriend, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                self?.navigationItem.rightBarButtonItem?.isEnabled = true

                
                switch result{
                case .Success(_, let error):
                    self!.settingView.hideProgressHUD()
                    self!.settingView.peopleData.friendStatus = "1"
                    SwiftEventBus.post(NotificationKey.friendRemove, sender: self!.settingView.peopleData.userId as AnyObject)
                    
                    self!.settingView.makeToast(error!.alertMessage, duration: ToastManager.shared.duration, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tappable) in
                        if self == nil {
                            return
                        }
                        _ = self!.navigationController?.popViewController(animated: true)
                    })
                    
                    break
                    
                case .Error(let error):
                    
                    self!.settingView.hideProgressHUD()
                    self?.settingView.makeToast(error!.alertMessage)
                    
                    break
                case .Internet(let isOn):
                    self!.settingView.handleNetworkCheck(isAvailable: isOn, insideView: AppUtility.getAppDelegate().window!)
                    break
                }
            })
        }
    }
}

extension SettingViewController : WYPopoverControllerDelegate {
    func popoverControllerDidDismissPopover(_ popoverController: WYPopoverController!) {
        
        moreMenuPopUp.delegate = nil
        moreMenuPopUp = nil
    }
}

extension SettingViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.moreMenuPopUp.dismissPopover(animated: true, options: .fadeWithScale)
        if let controller : MoreMenuViewController = moreMenuPopUp.contentViewController as? MoreMenuViewController {
            controller.tableView.delegate = nil
            controller.tableView.dataSource = nil
        }
        
        switch self.popUpMenuType.rawValue {
        case PopUpMenuType.loginUser.rawValue :
            
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(SelectHomeCourtController(isBackButton: true), animated: true)
                break
                
            case 1:
                self.navigationController?.pushViewController(EditProfileController(userDetail : self.settingView.peopleData), animated: true)
                break
                
            case 2:
                self.popUp = STPopupController.init(rootViewController: ChangePasswordController())
                self.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closePoup(_:))))
                self.popUp.navigationBarHidden = true
                self.popUp.hidesCloseButton = true
                self.popUp.present(in: self)
                break
                
            default: break
            }
            
            break
            
        case PopUpMenuType.otherUser.rawValue :
            
            if self.settingView.peopleData.friendStatus == "1" {
                alertController = BaseAlertController(iTitle: "Remove Friend", iMassage: "Are you sure you want to remove \(self.settingView.peopleData.firstName + " " + self.settingView.peopleData.lastName) from your friend list?", iButtonTitle: "Yes", index: -1)
            }
            else {
                alertController = BaseAlertController(iTitle: "Add Friend", iMassage: "Are you sure you want to add \(self.settingView.peopleData.firstName + " " + self.settingView.peopleData.lastName) as a friend?", iButtonTitle: "Yes", index: -1)
            }
            
            alertController.delegate = self
            
            popUp = STPopupController.init(rootViewController: self.alertController)
            popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closePoup(_:))))
            popUp.navigationBarHidden = true
            popUp.hidesCloseButton = true
            popUp.present(in: self)
            
            break
        default:
            break
        }
    }
}


extension SettingViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.popUpMenuType.rawValue {
            case PopUpMenuType.loginUser.rawValue :
                return 3
            
            case PopUpMenuType.otherUser.rawValue :
                return 1
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell()
        cell.textLabel?.font = UIFont(name: FontStyle.bold, size: 14.0)
        cell.textLabel?.textColor = Color.lablePrimary.value
        cell.selectionStyle = .none
        
        switch self.popUpMenuType.rawValue {
        case PopUpMenuType.loginUser.rawValue :
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Change Home Court"
                break
                
            case 1:
                cell.textLabel?.text = "Edit Profile"
                break
                
            case 2:
                cell.textLabel?.text = "Change Password"
                break
                
            default:
                cell.textLabel?.text = ""
            }
            break
        case PopUpMenuType.otherUser.rawValue :
            
            if self.settingView.peopleData.friendStatus == "1" {
                cell.textLabel?.text = "Remove Friend"
            }
            else {
                cell.textLabel?.text = "Add Friend"
            }
            
            break
        default: break
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}


extension SettingViewController : BaseAlertViewDelegate {
    func didTappedOkButton(_ alertView: BaseAlertController) {
        if self.alertController != nil {
            self.alertController = nil
            self.popUp = nil
            
            if self.settingView.peopleData.friendStatus == "1" {
                self.removeFriendRequest()
            }
            else {
                self.addFriendRequest()
            }
        }
    }
}
