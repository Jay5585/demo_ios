//
//  PlaceView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 09/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import GoogleMaps
import STPopup

class PlaceView: BaseView {
    
    // Mark: - Attributes -
    var mapView : GMSMapView!
    var lblOr : BaseLabel!
    var btnAddCourt : BaseButton!
    
    var imgMarker : BaseImageView!
    
    var forceToLoginPopUp : BaseAlertController!
    var popUp : STPopupController!
    
    var locationManager : CLLocationManager!
    
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
        print("PlaceView Deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if btnAddCourt != nil && btnAddCourt.superview != nil {
            btnAddCourt.removeFromSuperview()
            btnAddCourt = nil
        }
        
        if lblOr != nil && lblOr.superview != nil {
            lblOr.removeFromSuperview()
            lblOr = nil
        }
        
        if imgMarker != nil && imgMarker.superview != nil {
            imgMarker.removeFromSuperview()
            imgMarker = nil
        }
        
        if mapView != nil && mapView.superview != nil {
            mapView.removeFromSuperview()
            mapView = nil
        }
        forceToLoginPopUp = nil
        popUp = nil
        locationManager = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        mapView = GMSMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mapView)
        
        imgMarker = BaseImageView(type: .defaultImg, superView: self)
        imgMarker.image = UIImage(named: "MarkerNormal")?.withRenderingMode(.alwaysTemplate)
        imgMarker.tintColor = Color.appSecondaryBG.value        
        imgMarker.isHidden = true
        
        
        lblOr = BaseLabel(labelType: .headerSmall, superView: self)
        lblOr.text = "OR"
        
        btnAddCourt = BaseButton(ibuttonType: .primary, iSuperView: self)
        btnAddCourt.setTitle("Add New Home Court", for: .normal)
        btnAddCourt.isExclusiveTouch = true
        
        locationManager = CLLocationManager()
        
        locationManager.requestWhenInUseAuthorization()
        
        
        btnAddCourt.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            
            AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
                if self == nil {
                    return
                }
                
                if let controller : SearchViewController = self?.getViewControllerFromSubView() as? SearchViewController {
                    
                    if AppUtility.isUserLogin() {
                        controller.navigationController?.pushViewController(AddHomeCourtController(navigationPopType: NavigationPopType.popToRoot), animated: true)
                    }
                    else {
                        self!.forceToLoginPopUp = BaseAlertController(iTitle: "Login Required", iMassage: "You must login to add New Home Court", iButtonTitle: "Login", index: -1)
                        self!.forceToLoginPopUp.delegate = self
                        self!.popUp = STPopupController.init(rootViewController: self!.forceToLoginPopUp)
                        self!.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self!, action: #selector(self!.closePoup(_:))))
                        self!.popUp.navigationBarHidden = true
                        self!.popUp.hidesCloseButton = true
                        self!.popUp.present(in: controller)
                        
                    }
                }
                
            }
        }
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["mapView" : mapView,
                                     "lblOr" : lblOr,
                                     "imgMarker" : imgMarker,
                                     "btnAddCourt" : btnAddCourt]
        
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
        
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[mapView]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[mapView]-virticalPadding-[lblOr]-virticalPadding-[btnAddCourt]-secondaryVirticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        self.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40))
        
        self.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 35))
        
        self.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .centerX, relatedBy: .equal, toItem: mapView, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .bottom, relatedBy: .equal, toItem: mapView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        btnAddCourt.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        btnAddCourt.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        lblOr.widthAnchor.constraint(equalTo: btnAddCourt.widthAnchor).isActive = true
        lblOr.centerXAnchor.constraint(equalTo: btnAddCourt.centerXAnchor).isActive = true
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        popUp.dismiss()
    }
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    
}
extension PlaceView : BaseAlertViewDelegate {
    
    func didTappedOkButton(_ alertView: BaseAlertController) {
        if self.forceToLoginPopUp != nil && self.forceToLoginPopUp == alertView {
            self.forceToLoginPopUp = nil
            AppUtility.getAppDelegate().displayLoginViewOnWindow()
        }
    }
}

