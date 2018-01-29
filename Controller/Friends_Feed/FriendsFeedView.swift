//
//  FriendsFeedView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup
import SwiftEventBus

class FriendsFeedView: BaseView {
    
    // Mark: - Attributes -
    var tblFriendsFeed : UITableView!
    var lblError : BaseLabel!

    var refreshControl : UIRefreshControl!
    var schedules : [Schedule] = [Schedule]()
    var popUp : STPopupController!
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewControls()
        self.setViewlayout()
        self.friendsFeedRequest()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if tblFriendsFeed != nil && tblFriendsFeed.superview != nil {
            tblFriendsFeed.removeFromSuperview()
            tblFriendsFeed = nil
        }
        
        refreshControl = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        tblFriendsFeed = UITableView(frame: CGRect.zero)
        tblFriendsFeed.translatesAutoresizingMaskIntoConstraints = false
        tblFriendsFeed.backgroundColor = UIColor.clear
        tblFriendsFeed.dataSource = self
        tblFriendsFeed.delegate = self
        tblFriendsFeed.separatorStyle = UITableViewCellSeparatorStyle.none
        tblFriendsFeed.rowHeight = UITableViewAutomaticDimension
        self.addSubview(tblFriendsFeed)
        tblFriendsFeed.register(FriendFeedCell.self, forCellReuseIdentifier: CellIdentifire.friendFeedCell)
        
        lblError = BaseLabel(labelType: .large, superView: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 7
        let attrString = NSMutableAttributedString(string: "⚠️ No friends feed available \nPull to refresh")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        lblError.attributedText = attrString
        lblError.numberOfLines = 0
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        tblFriendsFeed.addSubview(refreshControl)
        
        
        SwiftEventBus.onMainThread(self, name : NotificationKey.friendRemove) { [weak self] result in
            if self == nil {
                return
            }
            
            if let userId : String = result.object as? String {
                
                var temp : [Schedule] = [Schedule]()
                for (_, schedule) in self!.schedules.enumerated() {
                    if schedule.user.userId != userId {
                        temp.append(schedule)
                    }
                }
                self!.schedules = temp
                self!.tblFriendsFeed.reloadData()
            }
        }
    }
    
    override func setViewlayout() {
        super.setViewlayout()

        //tblFriendList
        baseLayout.expandView(tblFriendsFeed, insideView: self)
        
        lblError.leadingAnchor.constraint(equalTo: tblFriendsFeed.leadingAnchor, constant: 8).isActive = true
        lblError.trailingAnchor.constraint(equalTo: tblFriendsFeed.trailingAnchor, constant: -8).isActive = true
        lblError.centerYAnchor.constraint(equalTo: tblFriendsFeed.centerYAnchor).isActive = true
        lblError.centerXAnchor.constraint(equalTo: tblFriendsFeed.centerXAnchor).isActive = true
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    func refresh(_ sender:AnyObject) {
        self.refreshControl.endRefreshing()
        self.friendsFeedRequest()
    }
    
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        popUp.dismiss()
        popUp = nil
    }
    
    // MARK: - Server Request -
    fileprivate func friendsFeedRequest() {
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            
            if AppUtility.isUserLogin() {
                self!.operationQueue.addOperation { [weak self] in
                    if self == nil {
                        return
                    }
                    
                    let dictParameter : NSMutableDictionary = NSMutableDictionary()
                    dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
                    dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
                    dictParameter.setValue(Int(Date().timeIntervalSince1970), forKey: "currentTime")
                    
                    
                    BaseAPICall.shared.postReques(URL: APIConstant.friendsFeed, Parameter: dictParameter, Type: APITask.FriendsFeed, completionHandler: { [weak self] (result) in
                        if self == nil {
                            return
                        }
                        
                        switch result{
                        case .Success(let object, let error):
                            self!.hideProgressHUD()
                            self!.makeToast(error!.alertMessage)
                            
                            self!.schedules = object as! [Schedule]
                            self!.tblFriendsFeed.reloadData()
                            break
                            
                        case .Error(let error):
                            
                            self!.hideProgressHUD()
                            self!.makeToast(error!.alertMessage)
                            
                            break
                        case .Internet(let isOn):
                            self!.handleNetworkCheck(isAvailable: isOn, insideView: self!)
                            break
                        }
                    })
                }
            }
            else {
                if let searchViewController : FriendsFeedViewController = self!.getViewControllerFromSubView() as? FriendsFeedViewController {
                    let forceToLoginPopUp = BaseAlertController(iTitle: "Login Required", iMassage: "You must login to see Friends Feed", iButtonTitle: "Login", index: -1)
                    forceToLoginPopUp.delegate = self
                    
                    self!.popUp = STPopupController.init(rootViewController: forceToLoginPopUp)
                    self!.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self!, action: #selector(self!.closePoup(_:))))
                    self!.popUp.navigationBarHidden = true
                    self!.popUp.hidesCloseButton = true
                    self!.popUp.present(in: searchViewController)
                }
            }
        }
    }
    
    fileprivate func fetchUserDetailRequest(index : Int) {
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(self!.schedules[index].user.userId, forKey: "profileId")
            
            
            BaseAPICall.shared.postReques(URL: APIConstant.fetchUserDetails, Parameter: dictParameter, Type: APITask.FetchUserDetails, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(let object, _):
                    self!.hideProgressHUD()
                    
                    if let controller : FriendsFeedViewController = self!.getViewControllerFromSubView() as? FriendsFeedViewController {                        
                        controller.navigationController?.pushViewController(SettingViewController(iPopUpMenuType: PopUpMenuType.otherUser, isBackButton: true, peopleData: object as! People), animated: true)
                    }
                    
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
}


//MARK: - UITableViewDatasource
extension FriendsFeedView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.lblError.isHidden = schedules.count == 0 ? false : true
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : FriendFeedCell!
        cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.friendFeedCell) as? FriendFeedCell
        if cell == nil {
            cell = FriendFeedCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifire.friendFeedCell)
        }
        
        cell.setData(schedule: self.schedules[indexPath.row])
        return cell
    }
}



//MARK: - UITableViewDelegate

extension FriendsFeedView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.fetchUserDetailRequest(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}


extension FriendsFeedView : BaseAlertViewDelegate {
    func didTappedOkButton(_ alertView: BaseAlertController) {
        alertView.delegate = nil
        AppUtility.getAppDelegate().displayLoginViewOnWindow()
        popUp = nil
    }
}
