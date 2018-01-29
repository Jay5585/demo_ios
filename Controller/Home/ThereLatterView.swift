//
//  ThereLatterView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 01/06/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup


class ThereLatterView: BaseView {
    
    // Mark: - Attributes -
    var tableView : UITableView!
    var lblError : BaseLabel!

    var refreshControl : UIRefreshControl!
    
    var thereLaterSchedule : [ThereLatter]! = [ThereLatter]()
    
    var isBackButton : Bool = false
    var courtId : String = "'"
    
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        self.setViewlayout()
        self.fetchThereLatterRequest()
    }
    
    
    init(isBackButton : Bool, courtId : String) {
        super.init(frame: .zero)
        
        self.isBackButton = isBackButton
        self.courtId = courtId
        
        self.loadViewControls()
        self.setViewlayout()
        
        self.fetchThereLatterOfCourtRequest(courtId: courtId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("ThereLatterView deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if tableView != nil && tableView.superview != nil {
            tableView.removeFromSuperview()
            tableView = nil
        }
        thereLaterSchedule = nil
        refreshControl = nil
        
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Color.appPrimaryBG.value
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ThereNowTableCell.self, forCellReuseIdentifier: CellIdentifire.thereNowTableCell)
        self.addSubview(tableView)
        
        lblError = BaseLabel(labelType: .large, superView: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 7
        let attrString = NSMutableAttributedString(string: "⚠️ Later schedules unavailable \nPull to refresh")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        lblError.attributedText = attrString
        lblError.numberOfLines = 0
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        //tableView
        baseLayout.expandView(tableView, insideView: self)
        
        lblError.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 8).isActive = true
        lblError.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -8).isActive = true
        lblError.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        lblError.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    
    func headerTapGestureRecognizer(gestureRecognizer: UIGestureRecognizer) {
        self.thereLaterSchedule[gestureRecognizer.view!.tag].isHidden = !self.thereLaterSchedule[gestureRecognizer.view!.tag].isHidden
        self.tableView.reloadSections(IndexSet(integer: gestureRecognizer.view!.tag), with: .fade)
    }
    
    
    func refresh(_ sender:AnyObject) {
        self.refreshControl.endRefreshing()
        if isBackButton {
            self.fetchThereLatterOfCourtRequest(courtId: courtId)
        }
        else {
            self.fetchThereLatterRequest()
        }
    }
    
    
    func formateThereLatterResponse(schedules : [Schedule]) {
        
        self.thereLaterSchedule.removeAll()
        
        var formattedArray : [ThereLatter] = [ThereLatter]()
        for i in 0..<24 {
            let obje : ThereLatter = ThereLatter()
            if i == 0 {
                obje.headerTime = "12:00 AM"
            }
            else if i > 0 && i < 12 {
                obje.headerTime = "\(i):00 AM"
            }
            else if i == 12 {
                obje.headerTime = "12:00 PM"
            }
            else {
                obje.headerTime = "\(i - 12):00 PM"
            }
            formattedArray.append(obje)
        }
        
        
        for (_, schedule) in schedules.enumerated() {
            formattedArray[getHourFromTimeStamp(time: Double(schedule.timeFrom)!)].schedules.append(schedule)
        }
        
        for (_, thereLatter) in formattedArray.enumerated() {
            if thereLatter.schedules.count != 0 {
                self.thereLaterSchedule.append(thereLatter)
            }
        }
        self.tableView.reloadData()
    }
    
    func getHourFromTimeStamp(time : Double) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return Int(formatter.string(from: NSDate(timeIntervalSince1970: time) as Date))!
    }
    
    
    // MARK: - Server Request -
    func fetchThereLatterRequest() {
        if !self.isLoadedRequest {
            operationQueue.addOperation { [weak self] in
                if self == nil{
                    return
                }
                
                let dictParameter : NSMutableDictionary = NSMutableDictionary()
                dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
                dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
                dictParameter.setValue(Int(Date().timeIntervalSince1970), forKey: "currentTime")
                
                self!.isLoadedRequest = true
                
                BaseAPICall.shared.postReques(URL: APIConstant.thereLater, Parameter: dictParameter, Type: APITask.ThereLater, completionHandler: { [weak self] (result) in
                    if self == nil {
                        return
                    }
                    switch result{
                    case .Success(let object, _):
                        self!.hideProgressHUD()
                        self!.isLoadedRequest = false
                        let court : Court = object as! Court
                        self!.formateThereLatterResponse(schedules: court.schedules)
                        
                    case .Error(let error):
                        self!.hideProgressHUD()
                        self!.isLoadedRequest = false
                        self!.makeToast(error!.alertMessage)
                        break
                    case .Internet(let isOn):
                        self!.handleNetworkCheck(isAvailable: isOn, insideView: self!)
                       
                        break
                    }
                })
            }
        }
    }
    
    
    func fetchThereLatterOfCourtRequest(courtId : String) {
        if !self.isLoadedRequest {
            operationQueue.addOperation { [weak self] in
                if self == nil{
                    return
                }
                
                let dictParameter : NSMutableDictionary = NSMutableDictionary()
                dictParameter.setValue(courtId, forKey: "homeCourtId")
                dictParameter.setValue(Int(Date().timeIntervalSince1970), forKey: "currentTime")
                
                self!.isLoadedRequest = true
                
                BaseAPICall.shared.postReques(URL: APIConstant.checkWhosThereLater, Parameter: dictParameter, Type: APITask.CheckWhosThereLater, completionHandler: { [weak self] (result) in
                    if self == nil {
                        return
                    }
                    
                    switch result{
                    case .Success(let object, _):
                        self!.hideProgressHUD()
                        self!.isLoadedRequest = false
                        let court : Court = object as! Court
                        self!.formateThereLatterResponse(schedules: court.schedules)
                        
                    case .Error(let error):
                        self!.hideProgressHUD()
                        self!.isLoadedRequest = false
                        self?.makeToast(error!.alertMessage)
                        break
                    case .Internet(let isOn):
                        self!.handleNetworkCheck(isAvailable: isOn, insideView: self!)
                        break
                    }
                })
            }
        }
    }
    
    
    fileprivate func fetchUserDetailRequest(userId : String) {
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(userId, forKey: "profileId")
            
            
            BaseAPICall.shared.postReques(URL: APIConstant.fetchUserDetails, Parameter: dictParameter, Type: APITask.FetchUserDetails, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(let object, _):
                    self!.hideProgressHUD()
                    
                    if let controller : HomeViewController = self?.getViewControllerFromSubView() as? HomeViewController {
                        let people : People = object as! People
                        if people.userId == AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId) as! String {
                            controller.navigationController?.pushViewController(SettingViewController(iPopUpMenuType: PopUpMenuType.loginUser, isBackButton: true, peopleData: object as! People), animated: true)
                        }
                        else {
                            controller.navigationController?.pushViewController(SettingViewController(iPopUpMenuType: PopUpMenuType.otherUser, isBackButton: true, peopleData: object as! People), animated: true)
                        }
                    }
                    
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
}



//MARK: - UITableViewDatasource
extension ThereLatterView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.lblError.isHidden = thereLaterSchedule.count == 0 ? false : true
        return self.thereLaterSchedule.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.thereLaterSchedule[section].isHidden {
//            return 0
//        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : ThereNowTableCell!
        cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.thereNowTableCell) as? ThereNowTableCell
        if cell == nil {
            cell = ThereNowTableCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifire.thereNowTableCell)
        }
        cell.collectionView.delegate = self
        cell.setData(thereLatter: self.thereLaterSchedule[indexPath.section], sectionNo : indexPath.section)
        return cell
    }
}



//MARK: - UITableViewDelegate

extension ThereLatterView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat((ceil(Double(self.thereLaterSchedule[indexPath.section].schedules.count)/3) * Double((UIScreen.main.bounds.size.width - 24) / 3)) + (ceil(Double(self.thereLaterSchedule[indexPath.section].schedules.count)/3) * 4))
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: 44))
        view.backgroundColor = Color.appPrimaryBG.value
        
        let innerView : UIView = UIView.init(frame: CGRect.init(x: 0, y: 2, width: tableView.bounds.width, height: 40))
        innerView.backgroundColor = Color.headerColor.value
        view.addSubview(innerView)
        
        let leftIcon : UIImageView = UIImageView.init(frame: CGRect(x: 15, y: 10, width: 20, height: 20))
        leftIcon.image = UIImage(named: "clock")
        innerView.addSubview(leftIcon)
        
//        let rightIcon : UIImageView = UIImageView.init(frame: CGRect(x: tableView.bounds.width - 35, y: 10, width: 20, height: 20))
//        rightIcon.image = self.thereLaterSchedule[section].isHidden ? UIImage(named: "DropRight") : UIImage(named: "DropDown")
//        innerView.addSubview(rightIcon)
        
        let lbl : UILabel = UILabel.init(frame: CGRect.init(x: 50, y: 10, width: tableView.bounds.width - 8, height: 20))
        
        lbl.font = UIFont(name: FontStyle.bold, size: 14.0)
        lbl.textColor = Color.lablePrimary.value
        
        lbl.text = self.thereLaterSchedule[section].headerTime
        innerView.addSubview(lbl)
        
        view.tag = section
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapGestureRecognizer(gestureRecognizer:)))
//        tapGesture.numberOfTouchesRequired = 1
//        tapGesture.numberOfTapsRequired = 1
//        view.addGestureRecognizer(tapGesture)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
}

extension ThereLatterView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if AppUtility.isUserLogin() {
            let user : People = self.thereLaterSchedule[collectionView.tag].schedules[indexPath.row].user
            self.fetchUserDetailRequest(userId: user.userId)
            
        }
        else {
            if let controller : HomeViewController = self.getViewControllerFromSubView() as? HomeViewController {
                controller.forceToLoginPopUp = BaseAlertController(iTitle: "Login Required", iMassage: "You must login to see user's profile", iButtonTitle: "Login", index: -1)
                controller.forceToLoginPopUp.delegate = controller
                controller.popUp = STPopupController.init(rootViewController: controller.forceToLoginPopUp)
                controller.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(controller.closePoup(_:))))
                controller.popUp.navigationBarHidden = true
                controller.popUp.hidesCloseButton = true
                controller.popUp.present(in: controller)
            }
        }
    }
}
extension ThereLatterView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width - 24) / 3, height: (UIScreen.main.bounds.size.width - 24) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
}

