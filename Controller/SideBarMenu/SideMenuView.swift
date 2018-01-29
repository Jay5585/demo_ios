//
//  SideMenuView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 05/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//


import UIKit
import SwiftEventBus


enum Menu : Int {
    case unkown = -2
    case setting = -1
    case home = 0
    case friends = 1
    case search = 2
    case friend_Feed = 3
    case logout = 4
    
}

class SideMenuView: BaseView {
    
    // Mark: - Attributes -
    
    var profileView : UIView!
    var imgProfile : BaseImageView!
    var lblName : BaseLabel!
    var lblEmail : BaseLabel!
    
    var menuTableView : UITableView!
    
    var kProfileViewFullHeight : NSLayoutConstraint!
    var kProfilrViewZeroHeight : NSLayoutConstraint!
    
    fileprivate var selectedMenuItem : Int = 0
    fileprivate var cellSelecteEvent : TableCellSelectEvent!
    
    var loginUser : People? = nil
    
    internal var arrMenuData : NSMutableArray! = NSMutableArray()

    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        self.setViewlayout()
        self.loadMenuData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("SideMenuView Deinit called")

        self.releaseObject()
        SwiftEventBus.unregister(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            InterfaceUtility.setCircleViewWith(Color.appSecondaryBG.value, width: 0, ofView: self!.imgProfile)
        }
        
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if menuTableView != nil && menuTableView.superview != nil {
            menuTableView.removeFromSuperview()
            menuTableView = nil
        }
        
        if lblEmail != nil && lblEmail.superview != nil {
            lblEmail.removeFromSuperview()
            lblEmail = nil
        }
        
        if lblName != nil && lblName.superview != nil {
            lblName.removeFromSuperview()
            lblName = nil
        }
        
        if imgProfile != nil && imgProfile.superview != nil {
            imgProfile.removeFromSuperview()
            imgProfile = nil
        }
        
        if profileView != nil && profileView.superview != nil {
            profileView.removeFromSuperview()
            profileView = nil
        }
        
        kProfileViewFullHeight = nil
        kProfilrViewZeroHeight = nil
        cellSelecteEvent = nil
        loginUser = nil
        arrMenuData = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        profileView = UIView(frame: .zero)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.backgroundColor = Color.appIntermidiateBG.value
        self.addSubview(profileView)
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        profileView.addGestureRecognizer(tap)
        profileView.isUserInteractionEnabled = true
        
        imgProfile = BaseImageView(type: .defaultImg, superView: profileView)
        
        lblName = BaseLabel(labelType: .large, superView: profileView)
        lblName.textColor = Color.appPrimaryBG.value
        lblName.textAlignment = .left
        lblName.numberOfLines = 2
        
        lblEmail = BaseLabel(labelType: .medium, superView: profileView)
        lblEmail.textColor = Color.appPrimaryBG.value
        lblEmail.textAlignment = .left
        lblEmail.numberOfLines = 2
        
        menuTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.backgroundColor = UIColor.clear
        menuTableView.separatorStyle = .none
        menuTableView.cellLayoutMarginsFollowReadableWidth = false
        menuTableView.bounces = false
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.tableFooterView = UIView(frame: .zero)
        menuTableView.register(MenuCell.self, forCellReuseIdentifier: CellIdentifire.menuCell)
        self.addSubview(menuTableView)
        
        self.setData()
        
        SwiftEventBus.onMainThread(self, name : NotificationKey.profileChange) { [weak self] result in
            if self == nil {
                return
            }
            if let _ : People = result.object as? People {
                self!.setData()
            }
        }
    
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["profileView" : profileView,
                                     "imgProfile" : imgProfile,
                                     "lblName" : lblName,
                                     "lblEmail" : lblEmail,
                                     "menuTableView" : menuTableView]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryHorizontalPadding : CGFloat = ControlLayout.turneryHorizontalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        baseLayout.metrics = ["horizontalPadding" : horizontalPadding,
                              "virticalPadding" : virticalPadding,
                              "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                              "secondaryVirticalPadding" : secondaryVirticalPadding,
                              "turneryHorizontalPadding" : turneryHorizontalPadding,
                              "turneryVerticalPadding" : turneryVerticalPadding]
        
        
        //profileView
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[profileView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        kProfileViewFullHeight = profileView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.22)
        kProfilrViewZeroHeight = profileView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.0)
        kProfileViewFullHeight.isActive = true
        
        
        //imgProfile
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-35-[imgProfile]-secondaryVirticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        profileView.addConstraints(baseLayout.control_V)
        
        imgProfile.widthAnchor.constraint(equalTo: imgProfile.heightAnchor, multiplier: 1.0).isActive = true
        imgProfile.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: turneryHorizontalPadding).isActive = true
        
        //Lables
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[imgProfile]-secondaryHorizontalPadding-[lblName]-secondaryHorizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        profileView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[lblName]-virticalPadding-[lblEmail]", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        profileView.addConstraints(baseLayout.control_V)
        
        lblName.bottomAnchor.constraint(equalTo: imgProfile.centerYAnchor, constant: -virticalPadding / 2).isActive = true
        
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[profileView][menuTableView]|", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        self.baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        if AppUtility.isUserLogin() {
            if self.selectedMenuItem != Menu.setting.rawValue {
                self.fetchUserDetailRequest()
            }
        }
        else {
            AppUtility.getAppDelegate().displayLoginViewOnWindow()
        }
    }
    
    open func cellSelectedEvent( event : @escaping TableCellSelectEvent) -> Void{
        cellSelecteEvent = event
    }
    
    // MARK: - Internal Helpers -
    
    fileprivate func setData() {
        if AppUtility.isUserLogin() {
            imgProfile.isHidden = false
            lblName.isHidden = false
            lblEmail.isHidden = false
            
            if let name : String = AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KFullName) as? String {
                lblName.text = name
            }
            else {
                lblName.text = ""
            }
            
            if let image : String = AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KProfilePic) as? String {
                imgProfile.displayImageFromURL(image)
            }
            else {
                imgProfile.displayImageFromURL("")
            }
            
            if let email : String = AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KEmailId) as? String {
                lblEmail.text = email
            }
            else {
                lblEmail.text = ""
            }
            
            
        }
        else {
            imgProfile.displayImageFromURL("")
            lblName.isHidden = true
            lblEmail.isHidden = true
        }
    }
    
    open func loadMenuData(){
        arrMenuData.removeAllObjects()
        for menuData in PListManager().readFromPlist("MenuList") as! NSMutableArray {
            if let dictMenu : NSMutableDictionary = menuData as? NSMutableDictionary {
                if let index : Int = dictMenu.value(forKey: "index") as? Int {
                    
                    switch index {
                    case Menu.friends.rawValue, Menu.setting.rawValue, Menu.logout.rawValue :
                        if AppUtility.isUserLogin() {
                            arrMenuData.add(dictMenu)
                        }
                        break
                        
                    default:
                        arrMenuData.add(dictMenu)
                        break
                    }
                }
            }
        }
        menuTableView.reloadData()
    }
    
    // MARK: - Server Request -
    
    func fetchUserDetailRequest() {
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "profileId")

            
            BaseAPICall.shared.postReques(URL: APIConstant.fetchUserDetails, Parameter: dictParameter, Type: APITask.FetchUserDetails, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(let object, _):
                    self!.hideProgressHUD()
                   
                    self!.loginUser = (object as! People)
                    
                    AppUtility.setUserDefaultsObject("\(self!.loginUser!.firstName) \(self!.loginUser!.lastName)" as AnyObject, forKey: UserDefaultKey.KFullName)
                    
                    AppUtility.setUserDefaultsObject(self!.loginUser!.profilePicUrl as AnyObject, forKey: UserDefaultKey.KProfilePic)
                    AppUtility.setUserDefaultsObject(self!.loginUser!.paymentStatus as AnyObject, forKey: UserDefaultKey.KisPlayed)
                   
                    self!.imgProfile.displayImageFromURL(self!.loginUser!.profilePicUrl)
                    self!.lblName.text = "\(self!.loginUser!.firstName) \(self!.loginUser!.lastName)"
                    
                    self!.selectedMenuItem = Menu.setting.rawValue
                    self!.menuTableView.reloadRows(at: self!.menuTableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.none)
                    if self!.cellSelecteEvent != nil {
                        self!.cellSelecteEvent(nil,Menu.setting.rawValue as AnyObject)
                    }
                    
                    break
                    
                case .Error(let error):
                    self!.hideProgressHUD()
                    self?.makeToast(error!.alertMessage)
                    break
                case .Internet(let isOn):
                    self!.handleNetworkCheck(isAvailable: isOn, insideView: AppUtility.getAppDelegate().window!)
                    break
                }
            })
        }
    }
    
    
    func logoutRequest() {
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
           
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            
            BaseAPICall.shared.postReques(URL: APIConstant.logout, Parameter: dictParameter, Type: APITask.Logout, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success( _, let error):
                    self!.hideProgressHUD()
                    
                    self!.makeToast(error!.alertMessage, duration: 0.5, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tap) in
                        if self == nil {
                            return
                        }
                        
                        AppUtility.logoutUser()
                    })
                    
                    break
                    
                case .Error(let error):
                    self!.hideProgressHUD()
                    self!.makeToast(error!.alertMessage, duration: 0.5, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tap) in
                        if self == nil {
                            return
                        }
                        AppUtility.logoutUser()
                    })
                    
                    break
                case .Internet(let isOn):
                    self!.handleNetworkCheck(isAvailable: isOn, insideView: AppUtility.getAppDelegate().window!)
                    break
                }
            })
        }
    }
    
    
}

// MARK : Extension
// TODO : UITableView Delegate
extension SideMenuView : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView .deselectRow(at: indexPath, animated: true)
        self .endEditing(true)
        
        let menuDictionary : NSDictionary = arrMenuData[indexPath.row] as! NSDictionary
        let menuType : Int = menuDictionary["index"] as! Int
        
        if menuType != Menu.logout.rawValue {
            selectedMenuItem = indexPath.row
        }
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.none)
        
        if self.cellSelecteEvent != nil{
            self.cellSelecteEvent(nil,menuType as AnyObject)
        }
    }
}

// TODO : UITableView DataSource
extension SideMenuView : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMenuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell : MenuCell!
        cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.menuCell) as? MenuCell
        if cell == nil {
            cell = MenuCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifire.menuCell)
        }
        
        cell.setViewContentDetail(self.arrMenuData[indexPath.row] as! NSDictionary)
        
        if selectedMenuItem == indexPath.row {
            cell.setSelectedCell(true)
        }
        else {
            cell.setSelectedCell(false)
        }
        return cell
    }
    
}
