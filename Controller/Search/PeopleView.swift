//
//  PeopleView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 09/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup
import SwiftEventBus

class PeopleView: BaseView {
    // Mark: - Attributes -
    var tblPeopleList : UITableView!
    var popUp : STPopupController!
    
    var addFriendPopUp : BaseAlertController!
    var forceToLoginPopUp : BaseAlertController!
    
    var peopleArr : [People]! = [People]()
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("PeopleView denint called")
        self.releaseObject()
        SwiftEventBus.unregister(self)

    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if tblPeopleList != nil && tblPeopleList.superview != nil {
            tblPeopleList.removeFromSuperview()
            tblPeopleList = nil
        }
        
        popUp = nil
        addFriendPopUp = nil
        forceToLoginPopUp = nil
        peopleArr = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        tblPeopleList = UITableView(frame: CGRect.zero)
        tblPeopleList.translatesAutoresizingMaskIntoConstraints = false
        tblPeopleList.backgroundColor = UIColor.clear
        tblPeopleList.dataSource = self
        tblPeopleList.delegate = self
        tblPeopleList.separatorStyle = UITableViewCellSeparatorStyle.none
        tblPeopleList.rowHeight = UITableViewAutomaticDimension
        self.addSubview(tblPeopleList)
        tblPeopleList.register(PeopleCell.self, forCellReuseIdentifier: CellIdentifire.peopleCell)
        
        SwiftEventBus.onMainThread(self, name : NotificationKey.addFriend) { [weak self] result in
            if self == nil {
                return
            }
            
            if let userId : String = result.object as? String {
                for (index, people) in self!.peopleArr.enumerated() {
                    if people.userId == userId {
                        self!.peopleArr[index].friendStatus = "1"
                        let indexPath : IndexPath = IndexPath(row: index, section: 0)
                        self!.tblPeopleList.reloadRows(at: [indexPath as IndexPath], with: .fade)
                    }
                }
            }
        }
        
        SwiftEventBus.onMainThread(self, name : NotificationKey.friendRemove) { [weak self] result in
            if self == nil {
                return
            }
            
            if let userId : String = result.object as? String {
                for (index, people) in self!.peopleArr.enumerated() {
                    if people.userId == userId {
                        self!.peopleArr[index].friendStatus = "2"
                        let indexPath : IndexPath = IndexPath(row: index, section: 0)
                        self!.tblPeopleList.reloadRows(at: [indexPath as IndexPath], with: .fade)
                    }
                }
            }
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.expandView(tblPeopleList, insideView: self)
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        popUp.dismiss()
    }
    
    func btnAddFriendTapped(sender : UIButton) {
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            if let searchViewController : SearchViewController = self!.getViewControllerFromSubView() as? SearchViewController {
                if AppUtility.isUserLogin() {
                    self!.addFriendPopUp = BaseAlertController(iTitle: "Add Friend", iMassage: "Are you sure you want to add \(self!.peopleArr[sender.tag].firstName + " " + self!.peopleArr[sender.tag].lastName) as a friend?", iButtonTitle: "Yes", index: sender.tag)
                    self!.addFriendPopUp.delegate = self
                    
                    self!.popUp = STPopupController.init(rootViewController: self!.addFriendPopUp)
                    self!.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self!, action: #selector(self!.closePoup(_:))))
                    self!.popUp.navigationBarHidden = true
                    self!.popUp.hidesCloseButton = true
                    self!.popUp.present(in: searchViewController)
                }
                else {
                    
                    self!.forceToLoginPopUp = BaseAlertController(iTitle: "Login Required", iMassage: "You must login to add a friend", iButtonTitle: "Login", index: -1)
                    self!.forceToLoginPopUp.delegate = self
                    
                    self!.popUp = STPopupController.init(rootViewController: self!.forceToLoginPopUp)
                    self!.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self!, action: #selector(self!.closePoup(_:))))
                    self!.popUp.navigationBarHidden = true
                    self!.popUp.hidesCloseButton = true
                    self!.popUp.present(in: searchViewController)
                    
                }
            }
        }
        
    }
    
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    fileprivate func addFriendRequest(id : Int) {
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(self?.peopleArr[id].userId, forKey: "friendId")
            
            BaseAPICall.shared.postReques(URL: APIConstant.addFriend, Parameter: dictParameter, Type: APITask.AddFriend, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(_, let error):
                    self!.hideProgressHUD()
                    
                    AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
                        if self == nil {
                            return
                        }
                        
                        self!.peopleArr[id].friendStatus = "1"
                        let indexPath : NSIndexPath = NSIndexPath(row: id, section: 0)
                        self!.tblPeopleList.reloadRows(at: [indexPath as IndexPath], with: .fade)
                        self!.makeToast(error!.alertMessage)
                    }
                    break
                    
                case .Error(let error):
                    self!.hideProgressHUD()
                    self?.makeToast(error!.alertMessage)
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
            dictParameter.setValue(self!.peopleArr[index].userId, forKey: "profileId")
            
            
            BaseAPICall.shared.postReques(URL: APIConstant.fetchUserDetails, Parameter: dictParameter, Type: APITask.FetchUserDetails, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(let object, _):
                    self!.hideProgressHUD()
                    
                    if let controller : SearchViewController = self!.getViewControllerFromSubView() as? SearchViewController {
                        
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
extension PeopleView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peopleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : PeopleCell!
        cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.peopleCell) as? PeopleCell
        if cell == nil {
            cell = PeopleCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifire.peopleCell)
        }
        
        cell.btnAddFriend.tag = indexPath.row
        cell.btnAddFriend.addTarget(self, action: #selector(self.btnAddFriendTapped(sender:)), for: .touchUpInside)
        
        cell.setData(people: self.peopleArr[indexPath.row])
        return cell
    }
}



//MARK: - UITableViewDelegate

extension PeopleView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let searchViewController : SearchViewController = self.getViewControllerFromSubView() as? SearchViewController {
            
            AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
                if self == nil {
                    return
                }
                
                
                if AppUtility.isUserLogin() {
                    self!.fetchUserDetailRequest(index: indexPath.row)
                }
                else {
                    
                    self!.forceToLoginPopUp = BaseAlertController(iTitle: "Login Required", iMassage: "You must login to see user's profile", iButtonTitle: "Login", index: -1)
                    self!.forceToLoginPopUp.delegate = self
                    
                    self!.popUp = STPopupController.init(rootViewController: self!.forceToLoginPopUp)
                    self!.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self!, action: #selector(self!.closePoup(_:))))
                    self!.popUp.navigationBarHidden = true
                    self!.popUp.hidesCloseButton = true
                    self!.popUp.present(in: searchViewController)
                    
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

extension PeopleView : BaseAlertViewDelegate {
    func didTappedOkButton(_ alertView: BaseAlertController) {
        if self.addFriendPopUp != nil && self.addFriendPopUp == alertView {
            self.addFriendPopUp = nil
            self.addFriendRequest(id: alertView.index)
        }
        else if self.forceToLoginPopUp != nil && self.forceToLoginPopUp == alertView {
            self.forceToLoginPopUp = nil
            AppUtility.getAppDelegate().displayLoginViewOnWindow()
        }
    }
}
