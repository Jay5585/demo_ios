//
//  CourtDetailView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 22/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class CourtDetailView: BaseView {
    
    // Mark: - Attributes -
    var container : UIView!
    
    var lblTitle : BaseLabel!
    var scrollView : BaseScrollView!
    var scrollContantView : UIView!
    var btnSetAsHomeCourt : BaseButton!
    var btnSeeThere : BaseButton!
    var btnClose : BaseButton!
    
    var imgProfileView : BaseImageView!
    
    var lblGameTypeTitle : BaseLabel!
    var lblGameType : BaseLabel!
    
    var lblCourtTypeTitle : BaseLabel!
    var lblCourtType : BaseLabel!
    
    var lblNoOfCourtsTitle : BaseLabel!
    var lblNoOfCourts : BaseLabel!
    
    var lblHoursTitle : BaseLabel!
    var lblHours : BaseLabel!
    
    var lblLightTitle : BaseLabel!
    var lblLight : BaseLabel!
    
    var lblMemberShipTitle : BaseLabel!
    var lblMemberShip : BaseLabel!
    
    var lblDayCostTitle : BaseLabel!
    var lblDayCost : BaseLabel!
    
    var lblAddressTitle : BaseLabel!
    var lblAddress : BaseLabel!
    
    var lblPlayerTitle : BaseLabel!
    var lblPlayer : BaseLabel!
    
    var court : Court!
    
    // MARK: - Lifecycle -
    init(court : Court) {
        super.init(frame: .zero)
       
        self.court = court
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("CourtDetailView deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if lblMemberShipTitle != nil && lblMemberShipTitle.superview != nil {
            lblMemberShipTitle.removeFromSuperview()
            lblMemberShipTitle = nil
        }
        if lblMemberShip != nil && lblMemberShip.superview != nil {
            lblMemberShip.removeFromSuperview()
            lblMemberShip = nil
        }
        if lblDayCostTitle != nil && lblDayCostTitle.superview != nil {
            lblDayCostTitle.removeFromSuperview()
            lblDayCostTitle = nil
        }
        if lblDayCost != nil && lblDayCost.superview != nil {
            lblDayCost.removeFromSuperview()
            lblDayCost = nil
        }
        if lblAddressTitle != nil && lblAddressTitle.superview != nil {
            lblAddressTitle.removeFromSuperview()
            lblAddressTitle = nil
        }
        if lblAddress != nil && lblAddress.superview != nil {
            lblAddress.removeFromSuperview()
            lblAddress = nil
        }
        if lblPlayerTitle != nil && lblPlayerTitle.superview != nil {
            lblPlayerTitle.removeFromSuperview()
            lblPlayerTitle = nil
        }
        if lblPlayer != nil && lblPlayer.superview != nil {
            lblPlayer.removeFromSuperview()
            lblPlayer = nil
        }
        
        if lblGameTypeTitle != nil && lblGameTypeTitle.superview != nil {
            lblGameTypeTitle.removeFromSuperview()
            lblGameTypeTitle = nil
        }
        if lblGameType != nil && lblGameType.superview != nil {
            lblGameType.removeFromSuperview()
            lblGameType = nil
        }
        if lblCourtTypeTitle != nil && lblCourtTypeTitle.superview != nil {
            lblCourtTypeTitle.removeFromSuperview()
            lblCourtTypeTitle = nil
        }
        if lblCourtType != nil && lblCourtType.superview != nil {
            lblCourtType.removeFromSuperview()
            lblCourtType = nil
        }
        if lblNoOfCourtsTitle != nil && lblNoOfCourtsTitle.superview != nil {
            lblNoOfCourtsTitle.removeFromSuperview()
            lblNoOfCourtsTitle = nil
        }
        if lblNoOfCourts != nil && lblNoOfCourts.superview != nil {
            lblNoOfCourts.removeFromSuperview()
            lblNoOfCourts = nil
        }
        if lblHoursTitle != nil && lblHoursTitle.superview != nil {
            lblHoursTitle.removeFromSuperview()
            lblHoursTitle = nil
        }
        if lblHours != nil && lblHours.superview != nil {
            lblHours.removeFromSuperview()
            lblHours = nil
        }
        if lblLightTitle != nil && lblLightTitle.superview != nil {
            lblLightTitle.removeFromSuperview()
            lblLightTitle = nil
        }
        if lblLight != nil && lblLight.superview != nil {
            lblLight.removeFromSuperview()
            lblLight = nil
        }
        
        if imgProfileView != nil && imgProfileView.superview != nil {
            imgProfileView.removeFromSuperview()
            imgProfileView = nil
        }
        if btnClose != nil && btnClose.superview != nil {
            btnClose.removeFromSuperview()
            btnClose = nil
        }
        if btnSeeThere != nil && btnSeeThere.superview != nil {
            btnSeeThere.removeFromSuperview()
            btnSeeThere = nil
        }
        if btnSetAsHomeCourt != nil && btnSetAsHomeCourt.superview != nil {
            btnSetAsHomeCourt.removeFromSuperview()
            btnSetAsHomeCourt = nil
        }
        if scrollContantView != nil && scrollContantView.superview != nil {
            scrollContantView.removeFromSuperview()
            scrollContantView = nil
        }
        if scrollView != nil && scrollView.superview != nil {
            scrollView.removeFromSuperview()
            scrollView = nil
        }
        if lblTitle != nil && lblTitle.superview != nil {
            lblTitle.removeFromSuperview()
            lblTitle = nil
        }
        if container != nil && container.superview != nil {
            container.removeFromSuperview()
            container = nil
        }
        court = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        container = UIView(frame: CGRect.zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
        
        lblTitle = BaseLabel(labelType: .headerSmall, superView: container)
        lblTitle.textColor = Color.lableSecondry.value
        lblTitle.numberOfLines = 2
        
        scrollView = BaseScrollView(scrollType: .vertical, superView: container)
        scrollView.backgroundColor = .white
        
        scrollContantView = scrollView.container
        
        btnSetAsHomeCourt = BaseButton(ibuttonType: .primary, iSuperView: container)
        btnSetAsHomeCourt.setTitle("Set As Home", for: .normal)
        
        btnSeeThere = BaseButton(ibuttonType: .primary, iSuperView: container)
        btnSeeThere.setTitle("See Who's There", for: .normal)
        
        btnClose = BaseButton(ibuttonType: .close, iSuperView: container)
        
        imgProfileView = BaseImageView(type: .defaultImg, superView: scrollContantView)
        
        lblGameTypeTitle = BaseLabel(labelType: .large, superView: scrollContantView)
        lblGameTypeTitle.numberOfLines = 2
        lblGameTypeTitle.textAlignment = .left
        
        lblGameType = BaseLabel(labelType: .large, superView: scrollContantView)
        lblGameType.textAlignment = .left
        
        lblCourtTypeTitle = BaseLabel(labelType: .large, superView: scrollContantView)
        lblCourtTypeTitle.textAlignment = .left
        
        lblCourtType = BaseLabel(labelType: .large, superView: scrollContantView)
        lblCourtType.textAlignment = .left
        
        lblNoOfCourtsTitle = BaseLabel(labelType: .large, superView: scrollContantView)
        lblNoOfCourtsTitle.textAlignment = .left
        lblNoOfCourtsTitle.numberOfLines = 2
        
        lblNoOfCourts = BaseLabel(labelType: .large, superView: scrollContantView)
        lblNoOfCourts.textAlignment = .left
        
        lblHoursTitle = BaseLabel(labelType: .large, superView: scrollContantView)
        lblHoursTitle.textAlignment = .left
        
        lblHours = BaseLabel(labelType: .large, superView: scrollContantView)
        lblHours.textAlignment = .left
        
        lblLightTitle = BaseLabel(labelType: .large, superView: scrollContantView)
        lblLightTitle.textAlignment = .left
        
        lblLight = BaseLabel(labelType: .large, superView: scrollContantView)
        lblLight.textAlignment = .left
        
        lblMemberShipTitle = BaseLabel(labelType: .large, superView: scrollContantView)
        lblMemberShipTitle.textAlignment = .left
        lblMemberShipTitle.numberOfLines = 2
        
        lblMemberShip = BaseLabel(labelType: .large, superView: scrollContantView)
        lblMemberShip.textAlignment = .left
        
        lblDayCostTitle = BaseLabel(labelType: .large, superView: scrollContantView)
        lblDayCostTitle.textAlignment = .left
        
        lblDayCost = BaseLabel(labelType: .large, superView: scrollContantView)
        lblDayCost.textAlignment = .left
        
        lblAddressTitle = BaseLabel(labelType: .large, superView: scrollContantView)
        lblAddressTitle.textAlignment = .left
        
        lblAddress = BaseLabel(labelType: .large, superView: scrollContantView)
        lblAddress.textAlignment = .left
        lblAddress.numberOfLines = 0
        
        lblPlayerTitle = BaseLabel(labelType: .large, superView: scrollContantView)
        lblPlayerTitle.textAlignment = .left
        
        lblPlayer = BaseLabel(labelType: .large, superView: scrollContantView)
        lblPlayer.textAlignment = .left
        
        imgProfileView.displayImageFromURL(court.homeCourtProfilePicUrl)
        lblGameTypeTitle.text = "Indoor/Outdoor:"
        lblCourtTypeTitle.text = "Court Type:"
        lblNoOfCourtsTitle.text = "Number of Courts:"
        lblHoursTitle.text = "Hours:"
        lblLightTitle.text = "Light:"
        lblMemberShipTitle.text = "Membership Required:"
        lblDayCostTitle.text = "Day Cost:"
        lblAddressTitle.text = "Address:"
        lblPlayerTitle.text = "Players:"
        
        lblTitle.text = court.homeCourtName
        lblGameType.text = court.gameType == "1" ? "Indoor" : "Outdoor"
        lblCourtType.text = court.courtType == "1" ? "Half" : "Full"
        lblNoOfCourts.text = court.numberOfCourts
        lblHours.text = "\(Date().getOnlyTimeofGivenTimestamp(timestampe: Double(court.openTime)!)) to \(Date().getOnlyTimeofGivenTimestamp(timestampe: Double(court.closeTime)!))"
        lblLight.text = court.lights == "0" ? "No" : "Yes"
        lblMemberShip.text = court.membershipStatus == "0" ? "No" : "Yes"
        lblDayCost.text = court.membershipStatus == "0" ? "-" : "$" + court.dayCost
        lblAddress.text = court.address
//        lblAddress.text = court.homeCourtName + ", " + court.address
        lblPlayer.text = court.numberOfPlayers
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        
        baseLayout.viewDictionary = ["container" : container,
                                     "lblTitle" : lblTitle,
                                     "scrollView" : scrollView,
                                     "scrollContantView" : scrollContantView,
                                     "btnSetAsHomeCourt" : btnSetAsHomeCourt,
                                     "btnSeeThere" : btnSeeThere,
                                     "imgProfileView" : imgProfileView,
                                     "lblGameTypeTitle" : lblGameTypeTitle,
                                     "lblGameType" : lblGameType,
                                     "lblCourtTypeTitle" : lblCourtTypeTitle,
                                     "lblCourtType" : lblCourtType,
                                     "lblNoOfCourtsTitle" : lblNoOfCourtsTitle,
                                     "lblNoOfCourts" : lblNoOfCourts,
                                     "lblHoursTitle" : lblHoursTitle,
                                     "lblHours" : lblHours,
                                     "lblLightTitle" : lblLightTitle,
                                     "lblLight" : lblLight,
                                     "lblMemberShipTitle" : lblMemberShipTitle,
                                     "lblMemberShip" : lblMemberShip,
                                     "lblDayCostTitle" : lblDayCostTitle,
                                     "lblDayCost" : lblDayCost,
                                     "lblAddressTitle" : lblAddressTitle,
                                     "lblAddress" : lblAddress,
                                     "lblPlayerTitle" : lblPlayerTitle,
                                     "lblPlayer" : lblPlayer]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        
        baseLayout.metrics = ["horizontalPadding" : horizontalPadding,
                              "virticalPadding" : virticalPadding,
                              "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                              "secondaryVirticalPadding" : secondaryVirticalPadding,
                              "turneryVerticalPadding" : turneryVerticalPadding]
        
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[container]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[container]", options: NSLayoutFormatOptions(rawValue : 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        self.addConstraint(NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: container, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: ((AppUtility.getAppDelegate().window?.frame.height)! - 94)))
        
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-35-[lblTitle]-35-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_H)
        
        
        //buttons
        btnSetAsHomeCourt.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        btnSeeThere.widthAnchor.constraint(equalTo: btnSetAsHomeCourt.widthAnchor, multiplier: 1.0).isActive = true
        
        baseLayout.position_CenterX = NSLayoutConstraint(item: btnSetAsHomeCourt, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.5, constant: 0)
        self.addConstraint(baseLayout.position_CenterX)
        
        baseLayout.position_CenterX = NSLayoutConstraint(item: btnSeeThere, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.5, constant: 0)
        self.addConstraint(baseLayout.position_CenterX)
        
        btnSeeThere.topAnchor.constraint(equalTo: btnSetAsHomeCourt.topAnchor).isActive = true
        
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding@1000-[lblTitle]-virticalPadding@751-[scrollView]-virticalPadding@250-[btnSetAsHomeCourt]-secondaryVirticalPadding@250-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_V)
        
        
        //Close Button
        btnClose.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        btnClose.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        
        
        //imgProfileView
        imgProfileView.widthAnchor.constraint(equalTo: scrollContantView.widthAnchor, multiplier: 0.3).isActive = true
        imgProfileView.heightAnchor.constraint(equalTo: imgProfileView.widthAnchor, multiplier: 1.0).isActive = true
        imgProfileView.centerXAnchor.constraint(equalTo: scrollContantView.centerXAnchor).isActive = true
        imgProfileView.topAnchor.constraint(equalTo: scrollContantView.topAnchor, constant: turneryVerticalPadding).isActive = true
        
        lblGameTypeTitle.widthAnchor.constraint(equalTo: scrollContantView.widthAnchor, multiplier: 0.3).isActive = true
        lblCourtTypeTitle.widthAnchor.constraint(equalTo: scrollContantView.widthAnchor, multiplier: 0.3).isActive = true
        lblNoOfCourtsTitle.widthAnchor.constraint(equalTo: scrollContantView.widthAnchor, multiplier: 0.3).isActive = true
        lblHoursTitle.widthAnchor.constraint(equalTo: scrollContantView.widthAnchor, multiplier: 0.3).isActive = true
        lblLightTitle.widthAnchor.constraint(equalTo: scrollContantView.widthAnchor, multiplier: 0.3).isActive = true
        lblMemberShipTitle.widthAnchor.constraint(equalTo: scrollContantView.widthAnchor, multiplier: 0.3).isActive = true
        lblDayCostTitle.widthAnchor.constraint(equalTo: scrollContantView.widthAnchor, multiplier: 0.3).isActive = true
        lblAddressTitle.widthAnchor.constraint(equalTo: scrollContantView.widthAnchor, multiplier: 0.3).isActive = true
        lblPlayerTitle.widthAnchor.constraint(equalTo: scrollContantView.widthAnchor, multiplier: 0.3).isActive = true
        
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[lblGameTypeTitle]-secondaryHorizontalPadding-[lblGameType]-secondaryHorizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        scrollContantView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[lblCourtTypeTitle]-secondaryHorizontalPadding-[lblCourtType]-secondaryHorizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        scrollContantView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[lblNoOfCourtsTitle]-secondaryHorizontalPadding-[lblNoOfCourts]-secondaryHorizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        scrollContantView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[lblHoursTitle]-secondaryHorizontalPadding-[lblHours]-secondaryHorizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        scrollContantView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[lblLightTitle]-secondaryHorizontalPadding-[lblLight]-secondaryHorizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        scrollContantView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[lblMemberShipTitle]-secondaryHorizontalPadding-[lblMemberShip]-secondaryHorizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        scrollContantView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[lblDayCostTitle]-secondaryHorizontalPadding-[lblDayCost]-secondaryHorizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        scrollContantView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[lblAddressTitle]-secondaryHorizontalPadding-[lblAddress]-secondaryHorizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        scrollContantView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[lblPlayerTitle]-secondaryHorizontalPadding-[lblPlayer]-secondaryHorizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        scrollContantView.addConstraints(baseLayout.control_H)
        
        
        if self.court.membershipStatus == "0" {
            self.lblDayCostTitle.isHidden = true
            self.lblDayCost.isHidden = true
            
            baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding@251-[imgProfileView]-secondaryVirticalPadding@251-[lblGameTypeTitle]-virticalPadding@251-[lblCourtTypeTitle]-virticalPadding@251-[lblNoOfCourtsTitle]-virticalPadding@251-[lblHoursTitle]-virticalPadding@251-[lblLightTitle]-virticalPadding@251-[lblMemberShipTitle]-virticalPadding@251-[lblAddress]-virticalPadding@251-[lblPlayerTitle]-virticalPadding@251-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
            scrollContantView.addConstraints(baseLayout.control_V)
        }
        else {
            self.lblDayCost.isHidden = false
            self.lblDayCostTitle.isHidden = false
            
            baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding@251-[imgProfileView]-secondaryVirticalPadding@251-[lblGameTypeTitle]-virticalPadding@251-[lblCourtTypeTitle]-virticalPadding@251-[lblNoOfCourtsTitle]-virticalPadding@251-[lblHoursTitle]-virticalPadding@251-[lblLightTitle]-virticalPadding@251-[lblMemberShipTitle]-virticalPadding@251-[lblDayCostTitle]-virticalPadding@251-[lblAddress]-virticalPadding@251-[lblPlayerTitle]-virticalPadding@251-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
            scrollContantView.addConstraints(baseLayout.control_V)
        }
        
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            InterfaceUtility.setCircleViewWith(Color.appSecondaryBG.value, width: 1.0, ofView: self!.imgProfileView)
        }
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    
}
