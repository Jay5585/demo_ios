//
//  AddHomeCourtView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 18/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Photos
import AVFoundation
import STPopup

class AddHomeCourtView: BaseView {
    // Mark: - Attributes -
    var scrollView : BaseScrollView!
    var contantView : UIView!
    
    var imgProfile : BaseImageView!
    var btnEditImage : UIButton!
    
    var txtCourtName : BaseTextField!
    var txtNoOfCourt : BaseTextField!
    var txtOpenTime : BaseTextField!
    var txtCloseTime : BaseTextField!
    
    var lblCourtType : BaseLabel!
    var rdoIndoor : BaseButton!
    var rdoOutdoor : BaseButton!
    
    var rdoHalf : BaseButton!
    var rdoFull : BaseButton!
    
    var lblLights : BaseLabel!
    var rdoLightsYes : BaseButton!
    var rdoLightsNo : BaseButton!
    
    var lblMembership : BaseLabel!
    var rdoMembershipsYes : BaseButton!
    var rdoMembershipNo : BaseButton!
    
    var imagePicker : UIImagePickerController!
    
    var radioGroupCourtType : [BaseButton] = []
    var btnCourtTypeSelected : BaseButton!
    
    var radioGroupLights : [BaseButton] = []
    var btnLightsSelected : BaseButton!
    
    var radioGroupMember : [BaseButton] = []
    var btnMemberSelected : BaseButton!
    
    var radioGroupFull : [BaseButton] = []
    var btnFullSelected : BaseButton!
    
    var txtDayCost : BaseTextField!
    var txtAddress : BaseTextField!
    var txtSearchLocation : BaseTextField!
    
    var mapView : GMSMapView!
    var btnSubmit : BaseButton!
    
    var kCostTopWithBottom : NSLayoutConstraint!
    var kCostTopWithTop : NSLayoutConstraint!
    
    var locationManager : CLLocationManager!
    
    var datePickerOpenTime : UIDatePicker!
    var datePickerCloseTime : UIDatePicker!
    
    var popUp : STPopupController!
    var alertController : BaseAlertController!
    
    
    var imgMarker : BaseImageView!
    var isDrag = true

    var selectedPlace : LocationAddress? = nil {
        didSet {
            if selectedPlace != nil {
                self.mapView.clear()
                self.txtSearchLocation.text = selectedPlace!.locationName
                txtAddress.text = selectedPlace!.locationAddress
                
                txtSearchLocation.errorMessage = ""
                txtAddress.errorMessage = ""
                
            }
            else {
                if txtSearchLocation == nil {
                    return
                }
                self.txtSearchLocation.text = ""
                txtAddress.text = ""
                self.mapView.clear()
            }
        }
    }
    
    
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
        print("AddHomeCourtView deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        if btnSubmit != nil && btnSubmit.superview != nil {
            btnSubmit.removeFromSuperview()
            btnSubmit = nil
        }
        if mapView != nil && mapView.superview != nil {
            mapView.removeFromSuperview()
            mapView.delegate = nil
            mapView = nil
        }
        if txtSearchLocation != nil && txtSearchLocation.superview != nil {
            txtSearchLocation.removeFromSuperview()
            txtSearchLocation = nil
        }
        
        if txtSearchLocation != nil && txtSearchLocation.superview != nil {
            txtSearchLocation.removeFromSuperview()
            txtSearchLocation = nil
        }
        
        if txtAddress != nil && txtAddress.superview != nil {
            txtAddress.removeFromSuperview()
            txtAddress = nil
        }
        
        if txtDayCost != nil && txtDayCost.superview != nil {
            txtDayCost.removeFromSuperview()
            txtDayCost = nil
        }
        
        if rdoMembershipNo != nil && rdoMembershipNo.superview != nil {
            rdoMembershipNo.removeFromSuperview()
            rdoMembershipNo = nil
        }
        
        if rdoMembershipsYes != nil && rdoMembershipsYes.superview != nil {
            rdoMembershipsYes.removeFromSuperview()
            rdoMembershipsYes = nil
        }
        
        if lblMembership != nil && lblMembership.superview != nil {
            lblMembership.removeFromSuperview()
            lblMembership = nil
        }
        
        if rdoLightsNo != nil && rdoLightsNo.superview != nil {
            rdoLightsNo.removeFromSuperview()
            rdoLightsNo = nil
        }
        
        if rdoLightsYes != nil && rdoLightsYes.superview != nil {
            rdoLightsYes.removeFromSuperview()
            rdoLightsYes = nil
        }
        
        if lblLights != nil && lblLights.superview != nil {
            lblLights.removeFromSuperview()
            lblLights = nil
        }
        
        if rdoHalf != nil && rdoHalf.superview != nil {
            rdoHalf.removeFromSuperview()
            rdoHalf = nil
        }
        
        if rdoFull != nil && rdoFull.superview != nil {
            rdoFull.removeFromSuperview()
            rdoFull = nil
        }
        
        if rdoOutdoor != nil && rdoOutdoor.superview != nil {
            rdoOutdoor.removeFromSuperview()
            rdoOutdoor = nil
        }
        if rdoIndoor != nil && rdoIndoor.superview != nil {
            rdoIndoor.removeFromSuperview()
            rdoIndoor = nil
        }
        if lblCourtType != nil && lblCourtType.superview != nil {
            lblCourtType.removeFromSuperview()
            lblCourtType = nil
        }
        if txtCourtName != nil && txtCourtName.superview != nil {
            txtCourtName.removeFromSuperview()
            txtCourtName = nil
        }
        if txtNoOfCourt != nil && txtNoOfCourt.superview != nil {
            txtNoOfCourt.removeFromSuperview()
            txtNoOfCourt = nil
        }
        if txtOpenTime != nil && txtOpenTime.superview != nil {
            txtOpenTime.removeFromSuperview()
            txtOpenTime = nil
        }
        if txtCloseTime != nil && txtCloseTime.superview != nil {
            txtCloseTime.removeFromSuperview()
            txtCloseTime = nil
        }
        if btnEditImage != nil && btnEditImage.superview != nil {
            btnEditImage.removeFromSuperview()
            btnEditImage = nil
        }
        
        if imgProfile != nil && imgProfile.superview != nil {
            imgProfile.removeFromSuperview()
            imgProfile = nil
        }
        
        if imgMarker != nil && imgMarker.superview != nil {
            imgMarker.removeFromSuperview()
            imgMarker = nil
        }
        
        if contantView != nil && contantView.superview != nil {
            contantView.removeFromSuperview()
            contantView = nil
        }
        
        if scrollView != nil && scrollView.superview != nil {
            scrollView.removeFromSuperview()
            scrollView = nil
        }
        
        kCostTopWithBottom = nil
        kCostTopWithTop = nil
        locationManager = nil
        datePickerOpenTime = nil
        datePickerCloseTime = nil
        popUp = nil
        selectedPlace = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        scrollView = BaseScrollView(scrollType: .vertical, superView: self)
        contantView = scrollView.container
        
        imgProfile = BaseImageView(type: .defaultImg, superView: contantView)
        imgProfile.displayImageFromURL("")
        imgProfile.tag = -1
        
        
        btnEditImage = UIButton(frame: .zero)
        btnEditImage.translatesAutoresizingMaskIntoConstraints = false
        contantView.addSubview(btnEditImage)
        btnEditImage.setImage(UIImage(named: "camera")?.maskWithColor(Color.appPrimaryBG.value), for: .normal)
        btnEditImage.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        btnEditImage.backgroundColor = Color.appSecondaryBG.value
        btnEditImage.addTarget(self, action: #selector(btnEditeProfileTapped(sender:)), for: .touchUpInside)
        
        txtCourtName = BaseTextField(iSuperView: contantView, TextFieldType: .baseNoAutoScrollType)
        txtCourtName.setLeftIcon(icon: UIImage(named: "home"))
        txtCourtName.placeholder = "Home Court Name"
        txtCourtName.autocapitalizationType = .sentences
        txtCourtName.errorMessage = ""
        txtCourtName.delegate = self
        txtCourtName.tag = 0
        
        txtNoOfCourt = BaseTextField(iSuperView: contantView, TextFieldType: .baseNoAutoScrollType)
        txtNoOfCourt.setLeftIcon(icon: UIImage(named: "Courts"))
        txtNoOfCourt.placeholder = "Number of Courts"
        txtNoOfCourt.errorMessage = ""
        txtNoOfCourt.keyboardType = .numberPad
        txtNoOfCourt.delegate = self
        txtNoOfCourt.tag = 1
        
        
        txtOpenTime = BaseTextField(iSuperView: contantView, TextFieldType: .baseNoClearButtonTextFieldType)
        txtOpenTime.setLeftIcon(icon: UIImage(named: "clock"))
        txtOpenTime.placeholder = "Open time"
        txtOpenTime.errorMessage = ""
        txtOpenTime.delegate = self
        txtOpenTime.tag = 2
        
        
        txtCloseTime = BaseTextField(iSuperView: contantView, TextFieldType: .baseNoClearButtonTextFieldType)
        txtCloseTime.setLeftIcon(icon: UIImage(named: "clock"))
        txtCloseTime.placeholder = "Close time"
        txtCloseTime.errorMessage = ""
        txtCloseTime.delegate = self
        txtCloseTime.tag = 3
        
        
        datePickerOpenTime = UIDatePicker()
        datePickerOpenTime.tag = 0
        datePickerOpenTime.datePickerMode = .time
        txtOpenTime.inputView = datePickerOpenTime
        datePickerOpenTime.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        datePickerCloseTime = UIDatePicker()
        datePickerCloseTime.tag = 1
        datePickerCloseTime.datePickerMode = .time
        datePickerCloseTime.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        txtCloseTime.inputView = datePickerCloseTime
        
        
        lblCourtType = BaseLabel(labelType: .large, superView: contantView)
        lblCourtType.textAlignment = .left
        lblCourtType.text = "Court Type:"
        
        rdoIndoor = BaseButton(ibuttonType: .radio, iSuperView: contantView)
        rdoIndoor.setTitle("Indoor", for: .normal)
        rdoIndoor.isSelected = true
        radioGroupCourtType.append(rdoIndoor)
        btnCourtTypeSelected = rdoIndoor
        
        rdoOutdoor = BaseButton(ibuttonType: .radio, iSuperView: contantView)
        rdoOutdoor.setTitle("Outdoor", for: .normal)
        radioGroupCourtType.append(rdoOutdoor)
        
        rdoHalf = BaseButton(ibuttonType: .radio, iSuperView: contantView)
        rdoHalf.setTitle("Half", for: .normal)
        radioGroupFull.append(rdoHalf)
        
        rdoFull = BaseButton(ibuttonType: .radio, iSuperView: contantView)
        rdoFull.setTitle("Full", for: .normal)
        rdoFull.isSelected = true
        btnFullSelected = rdoFull
        radioGroupFull.append(rdoFull)
        
        lblLights = BaseLabel(labelType: .large, superView: contantView)
        lblLights.textAlignment = .left
        lblLights.text = "Lights:"
        
        rdoLightsYes = BaseButton(ibuttonType: .radio, iSuperView: contantView)
        rdoLightsYes.setTitle("Yes", for: .normal)
        btnLightsSelected = rdoLightsYes
        rdoLightsYes.isSelected = true
        radioGroupLights.append(rdoLightsYes)
        
        rdoLightsNo = BaseButton(ibuttonType: .radio, iSuperView: contantView)
        rdoLightsNo.setTitle("No", for: .normal)
        radioGroupLights.append(rdoLightsNo)
        
        
        lblMembership = BaseLabel(labelType: .large, superView: contantView)
        lblMembership.textAlignment = .left
        lblMembership.numberOfLines = 0
        lblMembership.text = "Membership Required:"
        
        rdoMembershipsYes = BaseButton(ibuttonType: .radio, iSuperView: contantView)
        rdoMembershipsYes.setTitle("Yes", for: .normal)
        radioGroupMember.append(rdoMembershipsYes)
        
        rdoMembershipNo = BaseButton(ibuttonType: .radio, iSuperView: contantView)
        rdoMembershipNo.setTitle("No", for: .normal)
        rdoMembershipNo.isSelected = true
        btnMemberSelected = rdoMembershipNo
        radioGroupMember.append(rdoMembershipNo)
        
        txtDayCost = BaseTextField(iSuperView: contantView, TextFieldType: .baseNoAutoScrollType)
        txtDayCost.setLeftIcon(icon: UIImage(named: "DayOfCost"))
        txtDayCost.keyboardType = .decimalPad
        txtDayCost.placeholder = "Day Cost"
        txtDayCost.errorMessage = ""
        txtDayCost.delegate = self
        txtDayCost.tag = 4
        
        txtAddress = BaseTextField(iSuperView: contantView, TextFieldType: .baseNoAutoScrollType)
        txtAddress.setLeftIcon(icon: UIImage(named: "MarkerSmall"))
        txtAddress.placeholder = "Address"
        txtAddress.errorMessage = ""
        txtAddress.autocapitalizationType = .sentences
        txtAddress.delegate = self
        txtAddress.tag = 6
        
        txtSearchLocation = BaseTextField(iSuperView: contantView, TextFieldType: .baseNoClearButtonTextFieldType)
        txtSearchLocation.setLeftIcon(icon: UIImage(named: "Search"))
        txtSearchLocation.placeholder = "Search Location"
        txtSearchLocation.errorMessage = ""
        txtSearchLocation.delegate = self
        txtSearchLocation.tag = 5
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView = GMSMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        contantView.addSubview(mapView)
        
        imgMarker = BaseImageView(type: .defaultImg, superView: contantView)
        imgMarker.image = UIImage(named: "MarkerNormal")?.withRenderingMode(.alwaysTemplate)
        imgMarker.tintColor = Color.appSecondaryBG.value        
        
        btnSubmit = BaseButton(ibuttonType: .primary, iSuperView: self)
        btnSubmit.setTitle("Submit", for: .normal)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.barTintColor = Color.navigationBG.value
        imagePicker.navigationBar.tintColor = .white
        imagePicker.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white
        ]
        
        for aButton in radioGroupCourtType {
            aButton.isUserInteractionEnabled = true
            aButton.addTarget(self, action: #selector(self.radioGroupCourtTypeTapped(sendor:)), for: UIControlEvents.touchUpInside)
        }
        
        for aButton in radioGroupLights {
            aButton.isUserInteractionEnabled = true
            aButton.addTarget(self, action: #selector(self.radioGroupLightsTapped(sendor:)), for: UIControlEvents.touchUpInside)
        }
        
        for aButton in radioGroupMember {
            aButton.isUserInteractionEnabled = true
            aButton.addTarget(self, action: #selector(self.radioGroupMemberTapped(sendor:)), for: UIControlEvents.touchUpInside)
        }
        
        for aButton in radioGroupFull {
            aButton.isUserInteractionEnabled = true
            aButton.addTarget(self, action: #selector(self.radioGroupFullTapped(sendor:)), for: UIControlEvents.touchUpInside)
        }
        
        btnSubmit.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            
            self!.endEditing(true)
            var isError : Int = -1
            
            //txtCourtName
            if let trimmedString : String = self!.txtCourtName.text?.trimmed(), trimmedString == "" {
                self!.txtCourtName.errorMessage =  "Home Court Name is required"
                self!.txtCourtName.text = ""
                isError = self!.txtCourtName.tag
            }
            else {
                self!.txtCourtName.errorMessage =  ""
            }
            
            //txtNoOfCourt
            if let trimmedString : String = self!.txtNoOfCourt.text?.trimmed(), trimmedString == "" {
                self!.txtNoOfCourt.errorMessage =  "Number of Courts is required"
                self!.txtNoOfCourt.text = ""
                isError = (isError == -1 ? self!.txtNoOfCourt.tag : isError)
                
            }
            else if let trimmedString : String = self!.txtNoOfCourt.text?.trimmed(), AppUtility.isOnlyNumber(trimmedString) {
                self!.txtNoOfCourt.errorMessage =  ""
            }
            else {
                self!.txtNoOfCourt.errorMessage =  "Invalid number of courts"
                isError = (isError == -1 ? self!.txtNoOfCourt.tag : isError)
            }
            
            //txtOpenTime
            if let trimmedString : String = self!.txtOpenTime.text?.trimmed(), trimmedString == "" {
                self!.txtOpenTime.errorMessage =  "Open Time is required"
                self!.txtOpenTime.text = ""
                isError = (isError == -1 ? self!.txtOpenTime.tag : isError)
            }
            else if (Date().getTimeStampOfGivenTime(time: self!.txtOpenTime.text!) == nil) {
                self!.txtOpenTime.errorMessage =  "Invalid Open Time"
                self!.txtOpenTime.text = ""
                isError = (isError == -1 ? self!.txtOpenTime.tag : isError)
            }
            else {
                self!.txtOpenTime.errorMessage =  ""
            }
            
            //txtCloseTime
            if let trimmedString : String = self!.txtCloseTime.text?.trimmed(), trimmedString == "" {
                self!.txtCloseTime.errorMessage =  "Close Time is required"
                self!.txtCloseTime.text = ""
                isError = (isError == -1 ? self!.txtCloseTime.tag : isError)
            }
            else if (Date().getTimeStampOfGivenTime(time: self!.txtCloseTime.text!) == nil) {
                self!.txtCloseTime.errorMessage =  "Invalid Close Time"
                self!.txtCloseTime.text = ""
                isError = (isError == -1 ? self!.txtCloseTime.tag : isError)
            }
            else {
                self!.txtCloseTime.errorMessage =  ""
            }
            
            //txtDayCost
            if self!.btnMemberSelected == self!.rdoMembershipsYes {
                if let trimmedString : String = self!.txtDayCost.text?.trimmed(), trimmedString == "" {
                    self!.txtDayCost.errorMessage =  "Enter Day Cost"
                    self!.txtDayCost.text = ""
                    isError = (isError == -1 ? self!.txtDayCost.tag : isError)
                }
                else if let trimmedString : String = self!.txtDayCost.text?.trimmed(), AppUtility.isOnlyDecimal(trimmedString) {
                    self!.txtDayCost.errorMessage =  ""
                }
                else {
                    self!.txtDayCost.errorMessage =  "Invalid Day Cost"
                    self!.txtDayCost.text = ""
                    isError = (isError == -1 ? self!.txtDayCost.tag : isError)
                }
            }
            
            
            //txtSearchLocation
            if let trimmedString : String = self!.txtSearchLocation.text?.trimmed(), trimmedString == "" || self!.selectedPlace == nil {
                self!.txtSearchLocation.errorMessage =  "Location Selection is required"
                self!.txtSearchLocation.text = ""
                isError = (isError == -1 ? self!.txtSearchLocation.tag : isError)
            }
            else {
                self!.txtSearchLocation.errorMessage =  ""
            }
            
            //txtAddress
            if let trimmedString : String = self!.txtAddress.text?.trimmed(), trimmedString == "" {
                self!.txtAddress.errorMessage =  "Address is required"
                self!.txtAddress.text = ""
                isError = (isError == -1 ? self!.txtAddress.tag : isError)
            }
            else {
                self!.txtAddress.errorMessage =  ""
            }
            
            
            
            if isError == -1 {
                self!.addHomeCourtRequest()
            }
            else {

                switch isError {
                case 0 :
                    self!.txtCourtName.becomeFirstResponder()
                    break
                    
                case 1 :
                    self!.txtNoOfCourt.becomeFirstResponder()
                    break
                    
                case 2 :
                    self!.txtOpenTime.becomeFirstResponder()
                    break
                    
                case 3:
                    self!.txtCloseTime.becomeFirstResponder()
                    break
                    
                case 4 :
                    self!.txtDayCost.becomeFirstResponder()
                    break
                    
                case 5 :
                    self!.scrollView.scrollOnError(targetY: self!.txtSearchLocation.frame.origin.y)
                    break
                    
                case 6 :
                    self!.txtAddress.becomeFirstResponder()
                    break
                    
                default :
                    self!.scrollView.scrollOnError(targetY: self!.txtSearchLocation.frame.origin.y)
                    break
                }
            }
        }
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["scrollView" : scrollView,
                                     "contantView" : contantView,
                                     "imgProfile" : imgProfile,
                                     "btnEditImage" : btnEditImage,
                                     "txtCourtName" : txtCourtName,
                                     "txtNoOfCourt" : txtNoOfCourt,
                                     "txtOpenTime" : txtOpenTime,
                                     "txtCloseTime" : txtCloseTime,
                                     "lblCourtType" : lblCourtType,
                                     "rdoIndoor" : rdoIndoor,
                                     "rdoOutdoor" : rdoOutdoor,
                                     "rdoHalf" : rdoHalf,
                                     "rdoFull" : rdoFull,
                                     "lblLights" : lblLights,
                                     "rdoLightsYes" : rdoLightsYes,
                                     "rdoLightsNo" : rdoLightsNo,
                                     "lblMembership" : lblMembership,
                                     "rdoMembershipsYes" : rdoMembershipsYes,
                                     "rdoMembershipNo" : rdoMembershipNo,
                                     "txtDayCost" : txtDayCost,
                                     "txtAddress" : txtAddress,
                                     "txtSearchLocation" : txtSearchLocation,
                                     "mapView" : mapView,
                                     "imgMarker" : imgMarker,
                                     "btnSubmit" : btnSubmit]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryHorizontalPadding : CGFloat = ControlLayout.turneryHorizontalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        let radioWidth : CGFloat = 85.0
        
        baseLayout.metrics = ["horizontalPadding" : horizontalPadding,
                              "virticalPadding" : virticalPadding,
                              "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                              "secondaryVirticalPadding" : secondaryVirticalPadding,
                              "turneryHorizontalPadding" : turneryHorizontalPadding,
                              "turneryVerticalPadding" : turneryVerticalPadding,
                              "radioWidth" : radioWidth]
        
        //scrollView
        // ScrollView
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: NSLayoutFormatOptions(), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]-secondaryVirticalPadding-[btnSubmit]-secondaryVirticalPadding-|", options: [.alignAllCenterX], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        //btnSubmit
        btnSubmit.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        
        
        //imgProfile
        imgProfile.widthAnchor.constraint(equalTo: contantView.widthAnchor, multiplier: 0.3).isActive = true
        imgProfile.heightAnchor.constraint(equalTo: imgProfile.widthAnchor, multiplier: 1.0).isActive = true
        imgProfile.centerXAnchor.constraint(equalTo: contantView.centerXAnchor).isActive = true
        
        //btnEditImage
        btnEditImage.heightAnchor.constraint(equalTo: imgProfile.heightAnchor, multiplier: 0.4).isActive = true
        btnEditImage.widthAnchor.constraint(equalTo: btnEditImage.heightAnchor, multiplier: 1.0).isActive = true
        btnEditImage.topAnchor.constraint(equalTo: imgProfile.centerYAnchor, constant: 8).isActive = true
        btnEditImage.centerXAnchor.constraint(equalTo: imgProfile.rightAnchor, constant: -8).isActive = true
        
        
        txtCourtName.widthAnchor.constraint(equalTo: contantView.widthAnchor, multiplier: 0.8).isActive = true
        txtCourtName.centerXAnchor.constraint(equalTo: contantView.centerXAnchor, constant: 0).isActive = true
        
        txtNoOfCourt.widthAnchor.constraint(equalTo: txtCourtName.widthAnchor, multiplier: 1.0).isActive = true
        txtNoOfCourt.centerXAnchor.constraint(equalTo: txtCourtName.centerXAnchor, constant: 0).isActive = true
        
        txtOpenTime.leadingAnchor.constraint(equalTo: txtNoOfCourt.leadingAnchor).isActive = true
        txtCloseTime.trailingAnchor.constraint(equalTo: txtNoOfCourt.trailingAnchor).isActive = true
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[txtOpenTime]-secondaryHorizontalPadding-[txtCloseTime(==txtOpenTime)]", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.contantView.addConstraints(baseLayout.control_H)
        
        
        rdoOutdoor.trailingAnchor.constraint(equalTo: txtCloseTime.trailingAnchor, constant: 0).isActive = true
        lblCourtType.leadingAnchor.constraint(equalTo: txtOpenTime.leadingAnchor).isActive = true
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[lblCourtType]-horizontalPadding-[rdoIndoor(radioWidth)][rdoOutdoor(==rdoIndoor)]", options: [.alignAllCenterY], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.contantView.addConstraints(baseLayout.control_H)
        
        
        rdoHalf.leadingAnchor.constraint(equalTo: rdoIndoor.leadingAnchor).isActive = true
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[rdoHalf(radioWidth)][rdoFull(==rdoHalf)]", options: [.alignAllCenterY], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.contantView.addConstraints(baseLayout.control_H)
        
        
        rdoLightsNo.trailingAnchor.constraint(equalTo: rdoFull.trailingAnchor, constant: 0).isActive = true
        lblLights.leadingAnchor.constraint(equalTo: lblCourtType.leadingAnchor).isActive = true
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[lblLights]-horizontalPadding-[rdoLightsYes(radioWidth)][rdoLightsNo(==rdoLightsYes)]", options: [.alignAllCenterY], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.contantView.addConstraints(baseLayout.control_H)
        
        
        rdoMembershipNo.trailingAnchor.constraint(equalTo: rdoFull.trailingAnchor, constant: 0).isActive = true
        lblMembership.leadingAnchor.constraint(equalTo: lblCourtType.leadingAnchor).isActive = true
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[lblMembership]-horizontalPadding-[rdoMembershipsYes(radioWidth)][rdoMembershipNo(==rdoMembershipsYes)]", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.contantView.addConstraints(baseLayout.control_H)
        
        txtDayCost.widthAnchor.constraint(equalTo: txtCourtName.widthAnchor, multiplier: 1.0).isActive = true
        txtDayCost.centerXAnchor.constraint(equalTo: txtCourtName.centerXAnchor, constant: 0).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding-[imgProfile]-secondaryVirticalPadding-[txtCourtName]-secondaryVirticalPadding-[txtNoOfCourt]-secondaryVirticalPadding-[txtOpenTime]-secondaryVirticalPadding-[rdoIndoor]-virticalPadding-[rdoHalf]-secondaryVirticalPadding-[rdoLightsYes]-secondaryVirticalPadding-[lblMembership]-secondaryVirticalPadding-[txtDayCost]", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.contantView.addConstraints(baseLayout.control_V)
        
        
        kCostTopWithBottom = txtSearchLocation.topAnchor.constraint(equalTo: txtDayCost.bottomAnchor, constant: secondaryVirticalPadding)
        kCostTopWithTop = txtSearchLocation.topAnchor.constraint(equalTo: txtDayCost.topAnchor, constant: 0)
        
        if rdoMembershipsYes.isSelected {
            kCostTopWithBottom.isActive = true
            txtDayCost.alpha = 1
        }
        else {
            kCostTopWithTop.isActive = true
            txtDayCost.alpha = 0
        }
        
        txtAddress.widthAnchor.constraint(equalTo: txtCourtName.widthAnchor, multiplier: 1.0).isActive = true
        txtAddress.centerXAnchor.constraint(equalTo: txtCourtName.centerXAnchor, constant: 0).isActive = true
        
        txtSearchLocation.widthAnchor.constraint(equalTo: txtCourtName.widthAnchor, multiplier: 1.0).isActive = true
        txtSearchLocation.centerXAnchor.constraint(equalTo: txtCourtName.centerXAnchor, constant: 0).isActive = true
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[mapView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.contantView.addConstraints(baseLayout.control_H)
        mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.7).isActive = true
        
        
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[txtSearchLocation]-secondaryVirticalPadding-[mapView]-secondaryVirticalPadding-[txtAddress]-secondaryVirticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.contantView.addConstraints(baseLayout.control_V)
        
        self.contantView.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40))
        
        self.contantView.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 35))
        
        self.contantView.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .centerX, relatedBy: .equal, toItem: mapView, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        self.contantView.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .bottom, relatedBy: .equal, toItem: mapView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    
    // MARK: - User Interaction -
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        self.alertController = nil
        popUp.dismiss()
        popUp = nil
    }
    
    @objc private func radioGroupCourtTypeTapped(sendor : BaseButton){
        if sendor.isSelected == false{
            btnCourtTypeSelected.isSelected = false
            btnCourtTypeSelected = sendor
            btnCourtTypeSelected.isSelected = true
        }
        else{
            return
        }
    }
    
    @objc private func radioGroupLightsTapped(sendor : BaseButton){
        if sendor.isSelected == false{
            btnLightsSelected.isSelected = false
            btnLightsSelected = sendor
            btnLightsSelected.isSelected = true
        }
        else{
            return
        }
    }
    
    @objc private func radioGroupMemberTapped(sendor : BaseButton){
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            if sendor.isSelected == false{
                self!.btnMemberSelected.isSelected = false
                self!.btnMemberSelected = sendor
                self!.btnMemberSelected.isSelected = true
            }
            else{
                return
            }
            
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                if self == nil {
                    return
                }
                
                if self!.rdoMembershipsYes.isSelected {
                    self!.kCostTopWithTop.isActive = false
                    self!.kCostTopWithBottom.isActive = true
                    self!.txtDayCost.alpha = 1
                }
                else {
                    self!.kCostTopWithBottom.isActive = false
                    self!.kCostTopWithTop.isActive = true
                    self!.txtDayCost.alpha = 0
                }
                self?.layoutIfNeeded()
                
                }, completion: nil)
        }
    }
    
    @objc private func radioGroupFullTapped(sendor : BaseButton){
        if sendor.isSelected == false{
            btnFullSelected.isSelected = false
            btnFullSelected = sendor
            btnFullSelected.isSelected = true
        }
        else{
            return
        }
    }
    
    
    
    // MARK: - Internal Helpers -
    
    fileprivate func getPlaceAddress(_ coordinate : CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { [weak self] response , error in
            if self == nil {
                return
            }
            if response != nil {
                if let address = response?.firstResult() {
                    
                    let place = LocationAddress()
                    
                    let lines = address.lines! as [String]
                    place.locationAddress = lines.joined(separator: " ")
                    
                    if address.subLocality != "" && address.subLocality != nil{
                        place.locationName = address.subLocality!
                    }
                    else if address.lines!.count > 0 && address.lines!.first != "" && address.lines!.first != nil{
                        place.locationName = address.lines!.first!
                    }
                    else if address.lines!.count > 1 && address.lines![1] != "" && address.lines?[1] != nil{
                        place.locationName = address.lines?[1]
                    }
                    
                    place.latitude = address.coordinate.latitude
                    place.longitude = address.coordinate.longitude
                    
                    self!.selectedPlace = place
                }
                else {
                    self!.selectedPlace = nil
                }
            }
            else {
                self!.selectedPlace = nil
            }
        }
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        if sender.tag == 0 {
            txtOpenTime.text = formatter.string(from: sender.date)
        }
        else {
            txtCloseTime.text = formatter.string(from: sender.date)
        }
    }
    
    func btnEditeProfileTapped(sender : AnyObject) {
        
        self.endEditing(true)
        
        if let controller : AddHomeCourtController = self.getViewControllerFromSubView() as? AddHomeCourtController {
            let actionSheetController : UIAlertController = UIAlertController(title: appName, message: "Select court picture", preferredStyle: .actionSheet)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheetController.addAction(cancelAction)
            
            
            let takePictureAction: UIAlertAction = UIAlertAction(title: "Take picture", style: .default) { [weak self] action -> Void in
                if self == nil{
                    return
                }
                
                AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { [weak self] (granted :Bool) -> Void in
                    if self == nil {
                        return
                    }
                    
                    if granted == true {
                        // User granted
                        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                            self!.imagePicker.sourceType = .camera
                            controller.present(self!.imagePicker, animated: true, completion: nil)
                        }
                        else {
                            self?.makeToast(ErrorMessage.noCameraAvailable)
                        }
                    }
                    else {
                        // User Rejected
                        self!.loadAlertController(flag: -1)
                    }
                })
            }
            actionSheetController.addAction(takePictureAction)
            
            let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose from camera roll", style: .default) { [weak self] action -> Void in
                
                if self == nil{
                    return
                }
                
                let status = PHPhotoLibrary.authorizationStatus()
                
                if (status == PHAuthorizationStatus.authorized) {
                    // Access has been granted.
                    self!.loadImagePeacker()
                }
                    
                else if (status == PHAuthorizationStatus.denied) {
                    // Access has been denied.
                    self!.loadAlertController(flag: -2)
                }
                    
                else if (status == PHAuthorizationStatus.notDetermined) {
                    
                    // Access has not been determined.
                    PHPhotoLibrary.requestAuthorization({ (newStatus) in
                        
                        if (newStatus == PHAuthorizationStatus.authorized) {
                            self!.loadImagePeacker()
                        }
                        else {
                            self!.loadAlertController(flag: -2)
                        }
                    })
                }
            }
            
            actionSheetController.addAction(choosePictureAction)
            controller.present(actionSheetController, animated: true, completion: nil)
        }
        
    }
    
    func loadImagePeacker() {
        if let controller : AddHomeCourtController = self.getViewControllerFromSubView() as? AddHomeCourtController {
            self.imagePicker.sourceType = .photoLibrary
            controller.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func loadAlertController(flag : Int) {
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            if let controller : AddHomeCourtController = self!.getViewControllerFromSubView() as? AddHomeCourtController {
                //-1 for camera
                //-2 for Gallery
                
                self!.alertController = BaseAlertController(iTitle: flag == -1 ? "Camera permission" : "Photos permission", iMassage: "Turn on \(flag == -1 ? "Camera" : "Photos") access permission to use \(flag == -1 ? "Camera" : "Photos")", iButtonTitle: "Ok", index: flag)
                self!.alertController.delegate = self!
                
                self!.popUp = STPopupController.init(rootViewController: self!.alertController)
                self!.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self!.closePoup(_:))))
                self!.popUp.navigationBarHidden = true
                self!.popUp.hidesCloseButton = true
                self!.popUp.present(in: controller)
            }
        }
    }
    
    // MARK: - Server Request -
    fileprivate func addHomeCourtRequest() {
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
                        let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(self!.selectedPlace!.latitude, forKey: "latitude")
            dictParameter.setValue(self!.selectedPlace!.longitude, forKey: "longitude")
            dictParameter.setValue(self!.txtCourtName.text!.trimmed(), forKey: "homeCourtName")
            dictParameter.setValue(self!.txtNoOfCourt.text!.trimmed(), forKey: "numberOfCourts")
            
            if self!.btnMemberSelected == self!.rdoMembershipsYes {
                dictParameter.setValue(self!.txtDayCost.text?.trimmed(), forKey: "dayCost")
            }
           
            
            dictParameter.setValue(self!.txtAddress.text?.trimmed(), forKey: "address")
            
            dictParameter.setValue(Date().getTimeStampOfGivenTime(time: self!.txtCloseTime.text!), forKey: "closeTime")
            dictParameter.setValue(Date().getTimeStampOfGivenTime(time: self!.txtOpenTime.text!), forKey: "openTime")
            
            dictParameter.setValue(self!.btnFullSelected == self!.rdoFull ? "2" : "1", forKey: "gameType")
            dictParameter.setValue(self!.btnCourtTypeSelected == self!.rdoIndoor ? "1" : "2", forKey: "courtType")
            dictParameter.setValue(self!.btnLightsSelected == self!.rdoLightsYes ? "1" : "0", forKey: "lights")
            dictParameter.setValue(self!.btnMemberSelected == self!.rdoMembershipsYes ? "1" : "0", forKey: "membershipStatus")
            
            
            var arrToSend : NSMutableArray! = NSMutableArray()
            
            if self!.imgProfile.tag == 0 {
                var imageData : NSData! = UIImageJPEGRepresentation(self!.imgProfile.image!, 0.4) as NSData!
                var dicInfo : NSMutableDictionary! = NSMutableDictionary()
                dicInfo.setObject(imageData, forKey: "data" as NSCopying)
                dicInfo.setObject("homeCourtProfilePic", forKey: "name" as NSCopying)
                dicInfo.setObject("homeCourtProfilePic", forKey: "fileName" as NSCopying)
                dicInfo.setObject("image/jpeg", forKey: "type" as NSCopying)
                arrToSend.add(dicInfo)
                
                imageData = nil
                dicInfo = nil
            }
            
            
            
            BaseAPICall.shared.uploadImage(url: APIConstant.addHomeCourt, Parameter: dictParameter, Images: arrToSend, Type: APITask.AddHomeCourt, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                arrToSend = nil
                
                switch result{
                case .Success(_, let error):
                    
                    if let addHomeController : AddHomeCourtController = self!.getViewControllerFromSubView() as? AddHomeCourtController {
                        self!.alertController = BaseAlertController(iTitle: "Add Home Court", iMassage: error!.alertMessage, iButtonTitle: "Ok",index: -3)
                        self!.alertController.delegate = self
                        
                        self!.popUp = STPopupController.init(rootViewController: self!.alertController)
                        self!.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self!, action: #selector(self!.closePoup(_:))))
                        self!.popUp.navigationBarHidden = true
                        self!.popUp.hidesCloseButton = true
                        self!.popUp.present(in: addHomeController)
                        
                    }
                    self!.hideProgressHUD()

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
    
}

// MARK: - UIImagePickerControllerDelegate delegate
extension AddHomeCourtView : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imgProfile.image = pickedImage
            imgProfile.tag = 0
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
// MARK: - UITextFieldDelegate
extension AddHomeCourtView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtSearchLocation {
            textField.endEditing(true)
            textField.resignFirstResponder()
            
            var autocompleteController : GMSAutocompleteViewController! = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            
            let filter = GMSAutocompleteFilter()
            filter.type = .noFilter
            autocompleteController.autocompleteFilter = filter
            self.getViewControllerFromSubView()?.present(autocompleteController, animated: true, completion: nil)
            autocompleteController = nil
        }
        else if textField == txtOpenTime {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            if txtCloseTime.text != "" {
                datePickerOpenTime.maximumDate = NSCalendar.current.date(byAdding: .minute, value: -1, to: datePickerCloseTime.date)
            }
            
            textField.text = ""
            textField.text = formatter.string(from: datePickerOpenTime.date)
        }
        else if textField == txtCloseTime {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            if txtOpenTime.text != "" {
                datePickerCloseTime.minimumDate = NSCalendar.current.date(byAdding: .minute, value: 1, to: datePickerOpenTime.date)
            }
            
            textField.text = ""
            textField.text = formatter.string(from: datePickerCloseTime.date)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == txtSearchLocation {
            self.selectedPlace = nil
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
     
        if textField == txtCourtName {
            if let trimmedString : String = self.txtCourtName.text?.trimmed(), trimmedString == "" {
                self.txtCourtName.errorMessage =  "Home Court Name is required"
            }
            else {
                self.txtCourtName.errorMessage =  ""
            }
        }
        else if textField == txtNoOfCourt {
            if let trimmedString : String = self.txtNoOfCourt.text?.trimmed(), trimmedString == "" {
                self.txtNoOfCourt.errorMessage =  "Number of Courts is required"
            }
            else if let trimmedString : String = self.txtNoOfCourt.text?.trimmed(), AppUtility.isOnlyNumber(trimmedString) {
                self.txtNoOfCourt.errorMessage =  ""
            }
            else {
                self.txtNoOfCourt.errorMessage =  "Invalid Number of Courts"
            }
        }
        else if textField == txtOpenTime {
            if let trimmedString : String = self.txtOpenTime.text?.trimmed(), trimmedString == "" {
                self.txtOpenTime.errorMessage =  "Open Time is required"
            }
            else if (Date().getTimeStampOfGivenTime(time: self.txtOpenTime.text!) == nil) {
                self.txtOpenTime.errorMessage =  "Invalid Open Time"
            }
            else {
                self.txtOpenTime.errorMessage =  ""
            }
        }
        else if textField == txtCloseTime {
            if let trimmedString : String = self.txtCloseTime.text?.trimmed(), trimmedString == "" {
                self.txtCloseTime.errorMessage =  "Close Time is required"
            }
            else if (Date().getTimeStampOfGivenTime(time: self.txtCloseTime.text!) == nil) {
                self.txtCloseTime.errorMessage =  "Invalid Close Time"
            }
            else {
                self.txtCloseTime.errorMessage =  ""
            }
        }
        else if textField == txtAddress {
            if let trimmedString : String = self.txtAddress.text?.trimmed(), trimmedString == "" {
                self.txtAddress.errorMessage =  "Address is required"
            }
            else {
                self.txtAddress.errorMessage =  ""
            }
        }
        else if textField == txtDayCost {
            if let trimmedString : String = self.txtDayCost.text?.trimmed(), trimmedString == "" {
                self.txtDayCost.errorMessage =  "Enter Day Cost"
            }
            else if let trimmedString : String = self.txtDayCost.text?.trimmed(), AppUtility.isOnlyDecimal(trimmedString) {
                self.txtDayCost.errorMessage =  ""
            }
            else {
                self.txtDayCost.errorMessage =  "Invalid Day Cost"
            }
        }
        return true
    }
    
}



// MARK: - CLLocationManagerDelegate
extension AddHomeCourtView : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.isIndoorEnabled = true
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.settings.compassButton = true
            mapView.settings.indoorPicker = true
            
            locationManager.startUpdatingLocation()
        }
        else {
            print("Please Give access to use current Location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 14.0, bearing: 5.5, viewingAngle: 2.2)
            locationManager.stopUpdatingLocation()
        }
    }
}

// MARK: - GMSMapViewDelegate
extension AddHomeCourtView : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if isDrag {
            self.getPlaceAddress(position.target)
            return
        }
        self.isDrag = true
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        return false
        mapView.selectedMarker = marker
        return true
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return false
    }
    
}


// MARK: - GMSAutocompleteViewControllerDelegate

extension AddHomeCourtView: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.getViewControllerFromSubView()?.dismiss(animated: true, completion: {
            viewController.delegate = nil
           
            let tempPlace : LocationAddress = LocationAddress()
            tempPlace.latitude = place.coordinate.latitude
            tempPlace.longitude = place.coordinate.longitude
            tempPlace.locationName = place.name
            tempPlace.locationAddress = place.formattedAddress
            
            self.isDrag = false
            self.mapView.camera = GMSCameraPosition(target: place.coordinate, zoom: 12, bearing: 5.5, viewingAngle: 2.2)
            self.selectedPlace = tempPlace
            self.txtSearchLocation.resignFirstResponder()

        })
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.getViewControllerFromSubView()?.dismiss(animated: true, completion: {
            viewController.delegate = nil
            self.txtSearchLocation.resignFirstResponder()

        })
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
extension AddHomeCourtView : BaseAlertViewDelegate {
    func didTappedOkButton(_ alertView: BaseAlertController) {
        
        if self.alertController != nil {
            self.alertController = nil
            self.popUp = nil
            
            if alertView.index == -3 {
                if let controller : AddHomeCourtController = self.getViewControllerFromSubView() as? AddHomeCourtController {
                    switch controller.navigationPopType.rawValue {
                    case NavigationPopType.popOnDashBoard.rawValue :
                        AppUtility.getAppDelegate().displayDashboardViewOnWindow()
                        break
                        
                    case NavigationPopType.popToRoot.rawValue :
                        _ = controller.navigationController?.popToRootViewController(animated: true)
                        break
                        
                    case NavigationPopType.popToPrevious.rawValue :
                        _ = controller.navigationController?.popViewController(animated: true)
                        break
                        
                    default : break
                    }
                }
            }
            else {
                let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString) as! URL
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
