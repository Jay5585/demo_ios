//
//  HomeView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 03/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup


class HomeView: BaseView {

    // Mark: - Attributes -
    var lblHeader : BaseLabel!
    var segmentView : SegmentControlView!
    var scrollView : BaseScrollView!
    var contantView : UIView!
    
    var btnHereNow : BaseButton!
    var btnBethereLater : BaseButton!
    
    var viewThereNow : CollectionView!
    var viewThreLater : ThereLatterView!
    
    var refreshControl : UIRefreshControl!
    
    var thereNowHomeCourtData : Court! = Court()

    var isBackButton : Bool = false
    var courtId : String = ""
    
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        self.setViewlayout()
        self.fetchThereNowRequest()
    }
    
    init(isBackButton : Bool, courtId : String) {
        super.init(frame: .zero)
        
        self.isBackButton = isBackButton
        self.courtId = courtId
        
        self.loadViewControls()
        self.setViewlayout()
        self.fetchThereNowRequestOfCourt(courtId: courtId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("HomeView deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if viewThreLater != nil && viewThreLater.superview != nil {
            viewThreLater.removeFromSuperview()
            viewThreLater = nil
        }
        
        if viewThereNow != nil && viewThereNow.superview != nil {
            viewThereNow.removeFromSuperview()
            viewThereNow = nil
        }
        
        if btnBethereLater != nil && btnBethereLater.superview != nil {
            btnBethereLater.removeFromSuperview()
            btnBethereLater = nil
        }
        
        if btnHereNow != nil && btnHereNow.superview != nil {
            btnHereNow.removeFromSuperview()
            btnHereNow = nil
        }
        
        if contantView != nil && contantView.superview != nil {
            contantView.removeFromSuperview()
            contantView = nil
        }
        
        if scrollView != nil && scrollView.superview != nil {
            scrollView.removeFromSuperview()
            scrollView = nil
        }
        
        if segmentView != nil && segmentView.superview != nil {
            segmentView.removeFromSuperview()
            segmentView = nil
        }
        
        if lblHeader != nil && lblHeader.superview != nil {
            lblHeader.removeFromSuperview()
            lblHeader = nil
        }
        thereNowHomeCourtData = nil
        refreshControl = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        lblHeader = BaseLabel(labelType: .headerSmall, superView: self)
        lblHeader.text = " "
        
        segmentView = SegmentControlView(titleArray: ["There Now", "There Later"], iSuperView: self)
        
        scrollView = BaseScrollView(scrollType: .horizontal, superView: self)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isScrollEnabled = false
        contantView = scrollView.container
        
        viewThereNow = CollectionView(frame: .zero)
        viewThereNow.collection.dataSource = self
        viewThereNow.collection.delegate = self
        contantView.addSubview(viewThereNow)
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        viewThereNow.collection.addSubview(refreshControl)
        
        if self.isBackButton {
            viewThreLater = ThereLatterView(isBackButton: self.isBackButton, courtId: courtId)
        }
        else {
            viewThreLater = ThereLatterView(frame: .zero)
        }
        
        contantView.addSubview(viewThreLater)
        
        btnHereNow = BaseButton(ibuttonType: .primary, iSuperView: self)
        btnHereNow.setTitle("Here Now", for: .normal)
        
        btnBethereLater = BaseButton(ibuttonType: .primary, iSuperView: self)
        btnBethereLater.setTitle("Be There Later", for: .normal)
        
        btnHereNow.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            
            if let controller : HomeViewController = self!.getViewControllerFromSubView() as? HomeViewController {
                let playingHours : PlayingHourPopUpController = PlayingHourPopUpController(playingStartTime: Date())
                controller.popUp = STPopupController.init(rootViewController: playingHours)
                controller.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(controller.closePoup(_:))))
                controller.popUp.navigationBarHidden = true
                controller.popUp.hidesCloseButton = true
                controller.popUp.present(in: controller)
            }
        }
        
        btnBethereLater.setButtonTouchUpInsideEvent { (sender, object) in
            if let controller : HomeViewController = self.getViewControllerFromSubView() as? HomeViewController {
                let TimePicker : TimePickerPopUpController = TimePickerPopUpController()
                TimePicker.delegate = self
                
                controller.popUp = STPopupController.init(rootViewController: TimePicker)
                controller.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(controller.closePoup(_:))))
                controller.popUp.navigationBarHidden = true
                controller.popUp.hidesCloseButton = true
                controller.popUp.present(in: controller)
            }
        }
        
        
        segmentView.setSegmentTabbedEvent { [weak self] (index) in
            if self == nil {
                return
            }
            
            if index == 0 {
                let scrollPoint = CGPoint(x: 0, y: 0)
                self!.scrollView.setContentOffset(scrollPoint, animated: false)
            }
            else if index == 1 {
                let scrollPoint = CGPoint(x: self!.scrollView.frame.size.width, y: 0)
                self!.scrollView.setContentOffset(scrollPoint, animated: false)
            }
        }
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["lblHeader" : lblHeader,
                                     "segmentView" : segmentView,
                                     "scrollView" : scrollView,
                                     "contantView" : contantView,
                                     "btnHereNow" : btnHereNow,
                                     "btnBethereLater" : btnBethereLater,
                                     "viewThereNow" : viewThereNow,
                                     "viewThreLater" : viewThreLater]
        
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
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[lblHeader]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-secondaryVirticalPadding-[lblHeader(30)]-virticalPadding-[segmentView]-virticalPadding-[scrollView]", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        scrollView.bottomAnchor.constraint(equalTo: btnHereNow.topAnchor, constant: -secondaryVirticalPadding).isActive = true
        
        if isBackButton {
            btnHereNow.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
        else {
            btnHereNow.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -secondaryVirticalPadding).isActive = true
        }
        
        
        
        //buttons
        btnHereNow.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        btnBethereLater.widthAnchor.constraint(equalTo: btnHereNow.widthAnchor, multiplier: 1.0).isActive = true
        
        baseLayout.position_CenterX = NSLayoutConstraint(item: btnHereNow, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.5, constant: 0)
        self.addConstraint(baseLayout.position_CenterX)
        
        baseLayout.position_CenterX = NSLayoutConstraint(item: btnBethereLater, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.5, constant: 0)
        self.addConstraint(baseLayout.position_CenterX)
        
        btnBethereLater.topAnchor.constraint(equalTo: btnHereNow.topAnchor).isActive = true
        
        
        //contantView
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[viewThereNow]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        contantView.addConstraints(baseLayout.control_V)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[viewThereNow][viewThreLater]|", options: [.alignAllTop, .alignAllBottom], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        contantView.addConstraints(baseLayout.control_H)
        
        viewThereNow.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0).isActive = true
        viewThreLater.widthAnchor.constraint(equalTo: viewThereNow.widthAnchor, multiplier: 1.0).isActive = true
        
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    func refresh(_ sender:AnyObject) {
        self.refreshControl.endRefreshing()
        if isBackButton {
            self.fetchThereNowRequestOfCourt(courtId: courtId)
        }
        else {
            self.fetchThereNowRequest()
        }
    }
    
    
    
    // MARK: - Server Request -
    func fetchThereNowRequest() {
        
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
                
                BaseAPICall.shared.postReques(URL: APIConstant.thereNow, Parameter: dictParameter, Type: APITask.ThereNow, completionHandler: { [weak self] (result) in
                    if self == nil {
                        return
                    }
                    
                    switch result{
                    case .Success(let object, _):
                        self!.hideProgressHUD()
                        self!.isLoadedRequest = false
                        self!.thereNowHomeCourtData = object as! Court
                        self!.lblHeader.text = self!.thereNowHomeCourtData.homeCourtName
                        self?.viewThereNow.collection.reloadData()
                        
                    case .Error(let error):
                        self!.hideProgressHUD()
                        self!.isLoadedRequest = false
                        self?.makeToast(error!.alertMessage)
                        break
                    case .Internet(let isOn):
                        self!.handleNetworkCheck(isAvailable: isOn, insideView: self!.viewThereNow)
                        break
                    }
                })
            }
        }
    }
    
    
    func fetchThereNowRequestOfCourt(courtId : String) {
        
        if !self.isLoadedRequest {
            operationQueue.addOperation { [weak self] in
                if self == nil{
                    return
                }
                
                let dictParameter : NSMutableDictionary = NSMutableDictionary()
                
                dictParameter.setValue(courtId, forKey: "homeCourtId")
                dictParameter.setValue(Int(Date().timeIntervalSince1970), forKey: "currentTime")
                
                self!.isLoadedRequest = true
                
                BaseAPICall.shared.postReques(URL: APIConstant.checkWhosThereNow, Parameter: dictParameter, Type: APITask.CheckWhosThereNow, completionHandler: { [weak self] (result) in
                    if self == nil {
                        return
                    }
                    
                    switch result{
                    case .Success(let object, _):
                        self!.hideProgressHUD()
                        self!.isLoadedRequest = false
                        self!.thereNowHomeCourtData = object as! Court
                        self!.lblHeader.text = self!.thereNowHomeCourtData.homeCourtName
                        self?.viewThereNow.collection.reloadData()
                        
                    case .Error(let error):
                        self!.hideProgressHUD()
                        self!.isLoadedRequest = false
                        self?.makeToast(error!.alertMessage)
                        break
                    case .Internet(let isOn):
                        self!.handleNetworkCheck(isAvailable: isOn, insideView: self!.viewThereNow)
                        break
                    }
                })
            }
        }
    }
    
    fileprivate func fetchUserDetailRequest(userId : Int) {
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
                    self!.handleNetworkCheck(isAvailable: isOn, insideView: AppUtility.getAppDelegate().window!)
                    break
                }
            })
        }
    }
}


extension HomeView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x == 0 {
            self.segmentView.setSegementSelectedAtIndex(0)
        }
        
        if scrollView.contentOffset.x == scrollView.frame.size.width  {
            self.segmentView.setSegementSelectedAtIndex(1)
        }
    }
}

extension HomeView : TimePickerDelegate {
    
    func didTappedOkButton(_ selected: Date) {
    
        if let controller : HomeViewController = self.getViewControllerFromSubView() as? HomeViewController {
            let playingHours : PlayingHourPopUpController = PlayingHourPopUpController(playingStartTime: selected)
            
            if controller.popUp == nil {
                return
            }
            controller.popUp.dismiss()
            controller.popUp = STPopupController.init(rootViewController: playingHours)
            controller.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(controller.closePoup(_:))))
            controller.popUp.navigationBarHidden = true
            controller.popUp.hidesCloseButton = true
            controller.popUp.present(in: controller)
        }
    }
}



extension HomeView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewThereNow.lblError.isHidden = thereNowHomeCourtData.schedules.count == 0 ? false : true
        return self.thereNowHomeCourtData.schedules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : CollectionViewCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifire.collectionViewCell, for: indexPath as IndexPath) as? CollectionViewCell
        
        if cell == nil {
            cell = CollectionViewCell(frame: CGRect.zero)
        }
        cell.setValue(sedule: self.thereNowHomeCourtData.schedules[indexPath.row])
        return cell
    }
}


extension HomeView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if AppUtility.isUserLogin() {
            self.fetchUserDetailRequest(userId: Int(self.thereNowHomeCourtData.schedules[indexPath.row].user.userId)!)
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

extension HomeView : UICollectionViewDelegateFlowLayout {
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

