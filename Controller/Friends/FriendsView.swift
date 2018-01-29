//
//  FriendsView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import SwiftEventBus

class FriendsView: BaseView {
    // Mark: - Attributes -
    
    
    var tblFriendList : UITableView!
    var lblError : BaseLabel!
    var refreshControl : UIRefreshControl!
    
    var arrFriendList : [People]! = [People]()
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        self.setViewlayout()
        self.loadFriendsRequest()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("FriendsView deinit called")
        self.releaseObject()
        SwiftEventBus.unregister(self)
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if tblFriendList != nil && tblFriendList.superview != nil {
            tblFriendList.removeFromSuperview()
            tblFriendList = nil
        }
        
        refreshControl = nil
        arrFriendList = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        tblFriendList = UITableView(frame: CGRect.zero)
        tblFriendList.translatesAutoresizingMaskIntoConstraints = false
        tblFriendList.backgroundColor = UIColor.clear
        tblFriendList.dataSource = self
        tblFriendList.delegate = self
        tblFriendList.separatorStyle = UITableViewCellSeparatorStyle.none
        tblFriendList.rowHeight = UITableViewAutomaticDimension
        self.addSubview(tblFriendList)
        tblFriendList.register(FriendTableViewCell.self, forCellReuseIdentifier: CellIdentifire.friendsCell)
        
        lblError = BaseLabel(labelType: .large, superView: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 7
        let attrString = NSMutableAttributedString(string: "⚠️ You don't have any friends \nPull to refresh")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        lblError.attributedText = attrString
        lblError.numberOfLines = 0
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        tblFriendList.addSubview(refreshControl)
   
        SwiftEventBus.onMainThread(self, name : NotificationKey.friendRemove) { [weak self] result in
            if self == nil {
                return
            }
            
            if let userId : String = result.object as? String {
                for (index, friend) in self!.arrFriendList.enumerated() {
                    if friend.userId == userId {
                        self!.arrFriendList.remove(at: index)
                        let indexPath : IndexPath = IndexPath(row: index, section: 0) as IndexPath
                        self!.tblFriendList.deleteRows(at: [indexPath as IndexPath], with: .fade)
                        break
                    }
                }
            }
        }
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        //tblFriendList
        baseLayout.expandView(tblFriendList, insideView: self)
        
        lblError.leadingAnchor.constraint(equalTo: tblFriendList.leadingAnchor, constant: 8).isActive = true
        lblError.trailingAnchor.constraint(equalTo: tblFriendList.trailingAnchor, constant: -8).isActive = true
        lblError.centerYAnchor.constraint(equalTo: tblFriendList.centerYAnchor).isActive = true
        lblError.centerXAnchor.constraint(equalTo: tblFriendList.centerXAnchor).isActive = true
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    func refresh(_ sender:AnyObject) {
        self.refreshControl.endRefreshing()
        self.loadFriendsRequest()
    }
    
    
    // MARK: - Server Request -
    fileprivate func loadFriendsRequest() {
        operationQueue.cancelAllOperations()
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            
            BaseAPICall.shared.postReques(URL: APIConstant.loadFriends, Parameter: dictParameter, Type: APITask.LoadFriends, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(let object, let error):
                    self!.hideProgressHUD()
                    
                    self!.arrFriendList = object as! [People]
                    self!.tblFriendList.reloadData()
                    self!.tblFriendList.scrollsToTop = true
                    self!.makeToast(error!.alertMessage)
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
    
    fileprivate func fetchUserDetailRequest(index : Int) {
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(self!.arrFriendList[index].userId, forKey: "profileId")
            
            
            BaseAPICall.shared.postReques(URL: APIConstant.fetchUserDetails, Parameter: dictParameter, Type: APITask.FetchUserDetails, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(let object, _):
                    self!.hideProgressHUD()
                    
                    if let controller : FriendsViewController = self!.getViewControllerFromSubView() as? FriendsViewController {                        
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
extension FriendsView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.lblError.isHidden = arrFriendList.count == 0 ? false : true
        return arrFriendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : FriendTableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.friendsCell) as? FriendTableViewCell
        if cell == nil {
            cell = FriendTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifire.friendsCell)
        }
        
        cell.setData(friend: self.arrFriendList[indexPath.row])
        return cell
    }
}



//MARK: - UITableViewDelegate

extension FriendsView : UITableViewDelegate {
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
