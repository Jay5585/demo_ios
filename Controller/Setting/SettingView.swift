//
//  SettingView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import DynamicBlurView
import SwiftEventBus

class SettingView: BaseView {
    
    // Mark: - Attributes -
    var imgProfile : BaseImageView!
    var lblUserName : BaseLabel!
    var locationInfoView : UIView!
    var lblLocation : BaseLabel!
    var lblUserDetal : BaseLabel!
    
    var statisticalView : UIView!
    
    var blurView : DynamicBlurView!
    var btnUnlock : BaseButton!
    
    var segmentView : SegmentControlView!
    var scrollView : BaseScrollView!
    var contantView : UIView!
    
    var detailsView : DetailsView!
    var scheduleView : ScheduleView!
    
    var collectionView : UICollectionView!
    var btnRateUser : UIButton!
    
    var popUpMenuType : PopUpMenuType!
    var isStatasticVisible : Bool = true
    var segmentTopWithStatasticLayout : NSLayoutConstraint!
    var segmentTopWithView : NSLayoutConstraint!
    
    var swipeDownGesture : UISwipeGestureRecognizer!
    var swipeUpGesture : UISwipeGestureRecognizer!
    
    var collectionHeight : CGFloat = 90.0
    
    var peopleData : People!
    
    // MARK: - Lifecycle -
    
    init(iPopUpMenuType : PopUpMenuType, peopleData : People) {
        super.init(frame: .zero)
        
        self.peopleData = peopleData
        self.popUpMenuType = iPopUpMenuType
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("SettingView Denit called")
        self.releaseObject()
        SwiftEventBus.unregister(self)
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if btnRateUser != nil && btnRateUser.superview != nil {
            btnRateUser.removeFromSuperview()
            btnRateUser = nil
        }
        
        if scheduleView != nil && scheduleView.superview != nil {
            scheduleView.removeFromSuperview()
            scheduleView = nil
        }
        
        if detailsView != nil && detailsView.superview != nil {
            detailsView.removeFromSuperview()
            detailsView = nil
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
        
        if collectionView != nil && collectionView.superview != nil {
            collectionView.removeFromSuperview()
            collectionView = nil
        }
        
        if btnUnlock != nil && btnUnlock.superview != nil {
            btnUnlock.removeFromSuperview()
            btnUnlock = nil
        }
        
        if blurView != nil && blurView.superview != nil {
            blurView.removeFromSuperview()
            blurView = nil
        }
        
        if statisticalView != nil && statisticalView.superview != nil {
            statisticalView.removeFromSuperview()
            statisticalView = nil
        }
        
        if lblUserDetal != nil && lblUserDetal.superview != nil {
            lblUserDetal.removeFromSuperview()
            lblUserDetal = nil
        }
        //
        if lblLocation != nil && lblLocation.superview != nil {
            lblLocation.removeFromSuperview()
            lblLocation = nil
        }
        
        if locationInfoView != nil && locationInfoView.superview != nil {
            locationInfoView.removeFromSuperview()
            locationInfoView = nil
        }
        
        if lblUserName != nil && lblUserName.superview != nil {
            lblUserName.removeFromSuperview()
            lblUserName = nil
        }
        
        if imgProfile != nil && imgProfile.superview != nil {
            imgProfile.removeFromSuperview()
            imgProfile = nil
        }
        
        popUpMenuType = nil
        segmentTopWithStatasticLayout = nil
        segmentTopWithView = nil
        swipeDownGesture = nil
        swipeUpGesture = nil
        peopleData = nil
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            self!.statisticalView.layer.shadowColor = Color.appSecondaryBG.value.cgColor
            self!.statisticalView.layer.shadowOpacity = 0.8
            self!.statisticalView.layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
            self!.statisticalView.layer.shadowRadius = 1.0
            self!.statisticalView.layer.cornerRadius = 3
            
        }
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        self.backgroundColor = Color.appPrimaryBG.value
        
        imgProfile = BaseImageView(type: .defaultImg, superView: self)
        
        
        lblUserName = BaseLabel(labelType: .large, superView: self)
        
        locationInfoView = UIView(frame: .zero)
        locationInfoView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(locationInfoView)
        
        lblLocation = BaseLabel(labelType: .large, superView: locationInfoView)
        
        lblUserDetal = BaseLabel(labelType: .large, superView: locationInfoView)
        
        statisticalView = UIView(frame: .zero)
        statisticalView.translatesAutoresizingMaskIntoConstraints = false
        statisticalView.backgroundColor = Color.appPrimaryBG.value
        self.addSubview(statisticalView)
        
        blurView = DynamicBlurView(frame: .zero)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.tintColor = Color.appSecondaryBG.withAlpha(0.1)
        blurView.iterations = 8
        blurView.blurRadius = 8
        blurView.isUserInteractionEnabled = true
        blurView.blendColor = Color.appSecondaryBG.withAlpha(0.1)
        self.addSubview(blurView)
        
        btnUnlock = BaseButton(ibuttonType: .primary, iSuperView: blurView)
        btnUnlock.setTitle("Upgrade to see stats", for: .normal)
        
        segmentView = SegmentControlView(titleArray: ["Details", "Schedule"], iSuperView: self)
        swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDownGesture.direction = .down
        swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUpGesture.direction = .up
        segmentView.addGestureRecognizer(swipeDownGesture)
        segmentView.addGestureRecognizer(swipeUpGesture)
        
        scrollView = BaseScrollView(scrollType: .horizontal, superView: self)
        scrollView.backgroundColor = Color.appPrimaryBG.value
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isScrollEnabled = false
        contantView = scrollView.container
        
        detailsView = DetailsView()
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.scrollView.delegate = self
        contantView .addSubview(detailsView)
        
        scheduleView = ScheduleView(frame: .zero)
        scheduleView.tblSchedule.dataSource = self
        scheduleView.tblSchedule.delegate = self
        contantView .addSubview(scheduleView)
        
        let layout : UICollectionViewFlowLayout! = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.allowsMultipleSelection = false
        collectionView.isPagingEnabled = false
        statisticalView.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(StatasticCell.self, forCellWithReuseIdentifier : CellIdentifire.statasticCell)
        
        btnRateUser = UIButton(frame: .zero)
        btnRateUser.translatesAutoresizingMaskIntoConstraints = false
        btnRateUser.setImage(UIImage(named: "AddIcon"), for: .normal)
        btnRateUser.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btnRateUser.backgroundColor = .clear
        btnRateUser.addTarget(self, action: #selector(self.btnRateUseTapped(sender:)), for: .touchUpInside)
        statisticalView.addSubview(btnRateUser)
        
        
        if let isPlayed : String = AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KisPlayed) as? String, isPlayed == "1" {
            self.blurView.isHidden = true
            self.btnUnlock.isHidden = true
        }
        else {
            self.blurView.isHidden = false
            self.btnUnlock.isHidden = false
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
        
        btnUnlock.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            if let controller : SettingViewController = self!.getViewControllerFromSubView() as? SettingViewController {
                controller.navigationController?.pushViewController(PaymentController(), animated: true)
            }
        }
        
        SwiftEventBus.onMainThread(self, name : NotificationKey.purchaseDone) { [weak self] result in
            if self == nil {
                return
            }
            self!.blurView.isHidden = true
        }
        
        SwiftEventBus.onMainThread(self, name : NotificationKey.profileChange) { [weak self] result in
            if self == nil {
                return
            }
            if let people : People = result.object as? People {
                if people.userId == self!.peopleData.userId {
                    self!.peopleData = people
                    self!.setData()
                }
            }
        }
        
        SwiftEventBus.onMainThread(self, name : NotificationKey.rateUser) { [weak self] result in
            if self == nil {
                return
            }
            if let people : People = result.object as? People {
                
                self!.peopleData.statistics = people.statistics
                self!.peopleData.individualRatings = people.individualRatings
                
                self!.setData()
                self!.collectionView.reloadData()
            }
        }
        
        self.setData()
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["imgProfile" : imgProfile,
                                     "lblUserName" : lblUserName,
                                     "locationInfoView" : locationInfoView,
                                     "lblLocation" : lblLocation,
                                     "lblUserDetal" : lblUserDetal,
                                     "statisticalView" : statisticalView,
                                     "segmentView" : segmentView,
                                     "scrollView" : scrollView,
                                     "contantView" : contantView,
                                     "detailsView" : detailsView,
                                     "scheduleView" : scheduleView,
                                     "collectionView" : collectionView,
                                     "btnRateUser" : btnRateUser,
                                     "blurView" : blurView,
                                     "btnUnlock" : btnUnlock]
        
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryHorizontalPadding : CGFloat = ControlLayout.turneryHorizontalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        var butonSize : CGFloat = 0
        
        switch popUpMenuType.rawValue {
        case PopUpMenuType.loginUser.rawValue :
            btnRateUser.isHidden = true
            butonSize = 0
            break
            
        case PopUpMenuType.otherUser.rawValue :
            btnRateUser.isHidden = false
            butonSize = 40
            break
            
        default : break
        }
        
        baseLayout.metrics = ["horizontalPadding" : horizontalPadding,
                              "virticalPadding" : virticalPadding,
                              "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                              "secondaryVirticalPadding" : secondaryVirticalPadding,
                              "turneryHorizontalPadding" : turneryHorizontalPadding,
                              "turneryVerticalPadding" : turneryVerticalPadding,
                              "butonSize" : butonSize,
                              "collectionHeight" : collectionHeight]
        
        
        //imgProfile
        imgProfile.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        imgProfile.heightAnchor.constraint(equalTo: imgProfile.widthAnchor, multiplier: 1.0).isActive = true
        imgProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        //lblUserName
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[lblUserName]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        //locationInfoView
        locationInfoView.centerXAnchor.constraint(equalTo: lblUserName.centerXAnchor).isActive = true
        locationInfoView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, constant: -16).isActive = true
        
        lblLocation.centerYAnchor.constraint(equalTo: locationInfoView.centerYAnchor).isActive = true
        lblUserDetal.centerYAnchor.constraint(equalTo: locationInfoView.centerYAnchor).isActive = true
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding@750-[lblLocation(10@250)]-turneryHorizontalPadding-[lblUserDetal]-horizontalPadding@750-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        locationInfoView.addConstraints(baseLayout.control_H)
        
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding-[imgProfile]-virticalPadding-[lblUserName]-virticalPadding-[locationInfoView(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        //statisticalView
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[statisticalView]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        statisticalView.topAnchor.constraint(equalTo: locationInfoView.bottomAnchor, constant: virticalPadding).isActive = true
        
        
        //segmentView
        
        segmentTopWithStatasticLayout = segmentView.topAnchor.constraint(equalTo: statisticalView.bottomAnchor, constant: virticalPadding)
        segmentTopWithStatasticLayout.isActive = true
        
        segmentTopWithView = segmentView.topAnchor.constraint(equalTo: self.topAnchor, constant: virticalPadding)
        segmentTopWithView.isActive = false
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[segmentView]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[segmentView][scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        
        //contantView
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[detailsView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        contantView.addConstraints(baseLayout.control_V)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[detailsView][scheduleView]|", options: [.alignAllTop, .alignAllBottom], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        contantView.addConstraints(baseLayout.control_H)
        
        detailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0).isActive = true
        scheduleView.widthAnchor.constraint(equalTo: detailsView.widthAnchor, multiplier: 1.0).isActive = true
        
        btnRateUser.heightAnchor.constraint(equalToConstant: butonSize).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView(collectionHeight)]|", options: [.alignAllCenterY], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        statisticalView.addConstraints(baseLayout.control_V)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView][btnRateUser(butonSize)]|", options: [.alignAllCenterY], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        statisticalView.addConstraints(baseLayout.control_H)
        
        
        //Blure View
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[blurView]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        blurView.topAnchor.constraint(equalTo: locationInfoView.topAnchor, constant: -1).isActive = true
        blurView.bottomAnchor.constraint(equalTo: statisticalView.bottomAnchor, constant: -1).isActive = true
        
        //btnUnlock
        baseLayout.size_Width = NSLayoutConstraint(item: btnUnlock, attribute: .width, relatedBy: .equal, toItem: blurView, attribute: .width, multiplier: 0.46, constant: 0)
        blurView.addConstraint(baseLayout.size_Width)
        
        baseLayout.position_CenterX = NSLayoutConstraint(item: btnUnlock, attribute: .centerX, relatedBy: .equal, toItem: blurView, attribute: .centerX, multiplier: 1.0, constant: 0)
        blurView.addConstraint(baseLayout.position_CenterX)
        
        baseLayout.position_CenterY = NSLayoutConstraint(item: btnUnlock, attribute: .centerY, relatedBy: .equal, toItem: blurView, attribute: .centerY, multiplier: 1.0, constant: 0)
        blurView.addConstraint(baseLayout.position_CenterY)
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    func setData () {
        let leftIconHeight : CGFloat = 20.0
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            self!.imgProfile.displayImageFromURL(self!.peopleData.profilePicUrl)
            
            self!.lblUserName.text = "\(self!.peopleData.firstName) \(self!.peopleData.lastName)"
            
            self!.detailsView.lblEmail.text = self!.peopleData.email
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormate.KFullDate
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            self!.detailsView.lblBirthDate.text = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(self!.peopleData.birthDate)!))
            
            if self!.peopleData.phoneNumber == "" {
                self!.detailsView.lblphone.text = ""
                self!.detailsView.kPhoneHeight.constant = 0
                self!.detailsView.kPhoneTop.constant = 0
            }
            else {
                self!.detailsView.lblphone.text = self!.peopleData.phoneNumber
                self!.detailsView.kPhoneHeight.constant = leftIconHeight
                self!.detailsView.kPhoneTop.constant = ControlLayout.verticalPadding
            }
            
            if self!.peopleData.userHeight == "" {
                self!.detailsView.lblHeight.text = ""
                self!.detailsView.kHeight.constant = 0
                self!.detailsView.kHeightTop.constant = 0
            }
            else {
                self!.detailsView.lblHeight.text = "\(Int(Int(self!.peopleData.userHeight)! / 12)).\(Int(self!.peopleData.userHeight)! % 12) Feet"
                self!.detailsView.kHeight.constant = leftIconHeight
                self!.detailsView.kHeightTop.constant = ControlLayout.verticalPadding
            }
            
            if self!.peopleData.userWeight == "" {
                self!.detailsView.lblWeight.text = ""
                self!.detailsView.kWeightHeight.constant = 0
                self!.detailsView.kWeightTop.constant = 0
            }
            else {
                self!.detailsView.lblWeight.text = "\(self!.peopleData.userWeight) Pounds"
                self!.detailsView.kWeightHeight.constant = leftIconHeight
                self!.detailsView.kWeightTop.constant = ControlLayout.verticalPadding
            }
            
            if self!.peopleData.userVertical == "" {
                self!.detailsView.lblVertical.text = ""
                self!.detailsView.kVerticalHeight.constant = 0
                self!.detailsView.kVerticalTop.constant = 0
            }
            else {
                self!.detailsView.lblVertical.text = "\(self!.peopleData.userVertical) Inches"
                self!.detailsView.kVerticalHeight.constant = leftIconHeight
                self!.detailsView.kVerticalTop.constant = ControlLayout.verticalPadding
            }
            
            if self!.peopleData.userSchool == "" {
                self!.detailsView.lblSchool.text = ""
                self!.detailsView.kSchoolHeight.constant = 0
                self!.detailsView.kSchoolTop.constant = 0
            }
            else {
                self!.detailsView.lblSchool.text = self!.peopleData.userSchool
                self!.detailsView.kSchoolHeight.constant = leftIconHeight
                self!.detailsView.kSchoolTop.constant = ControlLayout.verticalPadding
            }
            
            if self!.peopleData.homeTown == "" {
                self!.detailsView.lblHomeTown.text = ""
                self!.detailsView.kHomeTownHeight.constant = 0
                self!.detailsView.kHomeTownTop.constant = 0
            }
            else {
                self!.detailsView.lblHomeTown.text =  self!.peopleData.homeTown
                self!.detailsView.kHomeTownHeight.constant = leftIconHeight
                self!.detailsView.kHomeTownTop.constant = ControlLayout.verticalPadding
            }
            
            self!.lblLocation.text = self!.peopleData.homeTown
            self!.lblUserDetal.text = "\(String(format: "%.2f", Double(self!.peopleData.statistics.scoreAverage)!)) Score by \(self!.peopleData.statistics.count) \(Int(self!.peopleData.statistics.count)! > 1 ? "Users" : "User")"
            
            
            self!.layoutIfNeeded()
            self!.layoutSubviews()
        }
        
    }
    
    
    func btnRateUseTapped(sender : UIButton) {
        if let controller : SettingViewController = self.getViewControllerFromSubView() as? SettingViewController {
            let temp : IndividualRating = self.peopleData.individualRatings.mutableCopy() as! IndividualRating
            controller.navigationController?.pushViewController(RateUserController(ratting: temp, userId : self.peopleData.userId), animated: true)
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.down:
                self.showStatastic()
                break
                
            case UISwipeGestureRecognizerDirection.up:
                self.hideStatastic()
                break
                
            default:
                break
            }
        }
    }
    
    
    
    
    func hideStatastic() {
        if isStatasticVisible {
            AppUtility.executeTaskInMainQueueWithCompletion({ [weak self] in
                if self == nil {
                    return
                }
                
                UIView.animate(withDuration: 0.7, animations: { [weak self] in
                    if self == nil {
                        return
                    }
                    self!.segmentTopWithStatasticLayout.isActive = false
                    self?.segmentTopWithView.isActive = true
                    self?.layoutIfNeeded()
                    
                    self!.imgProfile.alpha = 0
                    self!.lblUserName.alpha = 0
                    self!.locationInfoView.alpha = 0
                    self!.statisticalView.alpha = 0
                    
                    }, completion: nil)
                self!.isStatasticVisible = !(self?.isStatasticVisible)!
            })
        }
    }
    
    func showStatastic() {
        if !isStatasticVisible {
            
            AppUtility.executeTaskInMainQueueWithCompletion({ [weak self] in
                if self == nil {
                    return
                }
                
                UIView.animate(withDuration: 0.7, animations: { [weak self] in
                    if self == nil {
                        return
                    }
                    self!.segmentTopWithView.isActive = false
                    self?.segmentTopWithStatasticLayout.isActive = true
                    self?.layoutIfNeeded()
                    
                    self!.imgProfile.alpha = 1
                    self!.lblUserName.alpha = 1
                    self!.locationInfoView.alpha = 1
                    self!.statisticalView.alpha = 1
                    
                    }, completion: nil)
                self!.isStatasticVisible = !(self?.isStatasticVisible)!
            })
        }
    }
    
    // MARK: - Server Request -
    
}


//MARK: - UITableViewDatasource
extension SettingView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scheduleView.lblError.isHidden = peopleData.schedules.count == 0 ? false : true
        return self.peopleData.schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : ScheduleTableCell!
        cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.detailCell) as? ScheduleTableCell
        if cell == nil {
            cell = ScheduleTableCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifire.detailCell)
        }
        cell.setData(schedule: self.peopleData.schedules[indexPath.row])
        return cell
    }
}



//MARK: - UITableViewDelegate

extension SettingView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension SettingView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            if scrollView.contentOffset.x == 0 {
                self.segmentView.setSegementSelectedAtIndex(0)
            }
            
            if scrollView.contentOffset.x == scrollView.frame.size.width  {
                self.segmentView.setSegementSelectedAtIndex(1)
            }
        }
        else if scrollView == self.detailsView.scrollView ||  scrollView == self.scheduleView.tblSchedule{
            if scrollView.contentOffset.y > 0 && scrollView.contentSize.height > scrollView.frame.height && isStatasticVisible{
                self.hideStatastic()
            }
            else if scrollView.contentOffset.y < 0 && !isStatasticVisible{
                self.showStatastic()
            }
        }
    }
}


extension SettingView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.peopleData.statistics.skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : StatasticCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifire.statasticCell, for: indexPath as IndexPath) as? StatasticCell
        
        if cell == nil {
            cell = StatasticCell(frame: CGRect.zero)
        }
        
        cell.setData(skill: self.peopleData.statistics.skills[indexPath.row])
        
        return cell
    }
    
}

extension SettingView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

