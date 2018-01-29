//
//  BaseAlertView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 10/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class BaseAlertView: BaseView {
    
    // Mark: - Attributes -
    var container : UIView!
    
    var lblTitle : BaseLabel!
    var lblMassage : BaseLabel!
    var btnOk : BaseButton!
    var btnClose : BaseButton!
    
    var title : String!
    var massage : String!
    var buttonTitle : String!
    
    // MARK: - Lifecycle -
    init(iTitle : String, alertMassage iMassage : String, alertButton iButtonTitle : String) {
        super.init(frame: .zero)
        
        title = iTitle
        massage = iMassage
        buttonTitle = iButtonTitle
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("BaseAlertView Deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if btnClose != nil && btnClose.superview != nil {
            btnClose.removeFromSuperview()
            btnClose = nil
        }
        
        if btnOk != nil && btnOk.superview != nil {
            btnOk.removeFromSuperview()
            btnOk = nil
        }
        
        if lblMassage != nil && lblMassage.superview != nil {
            lblMassage.removeFromSuperview()
            lblMassage = nil
        }
        
        if lblTitle != nil && lblTitle.superview != nil {
            lblTitle.removeFromSuperview()
            lblTitle = nil
        }
        
        if container != nil && container.superview != nil {
            container.removeFromSuperview()
            container = nil
        }
        
        title = nil
        massage = nil
        buttonTitle = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        container = UIView(frame: CGRect.zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
        
        lblTitle = BaseLabel(labelType: .headerSmall, superView: container)
        lblTitle.textColor = Color.appIntermidiateBG.value
        lblTitle.text = title
        
        lblMassage = BaseLabel(labelType: .large, superView: container)
        lblMassage.numberOfLines = 0
        lblMassage.text = massage
        
        btnOk = BaseButton(ibuttonType: .primary, iSuperView: container)
        btnOk.setTitle(buttonTitle, for: .normal)
        
        btnClose = BaseButton(ibuttonType: .close, iSuperView: container)
        
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        
        baseLayout.viewDictionary = ["container" : container,
                                     "lblTitle" : lblTitle,
                                     "lblMassage" : lblMassage,
                                     "btnOk" : btnOk,
                                     "btnClose" : btnClose]
        
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
        
        self.addConstraint(NSLayoutConstraint(item: container, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-35-[lblTitle]-35-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.container.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryVirticalPadding-[lblMassage]-secondaryVirticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.container.addConstraints(baseLayout.control_H)
        
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding@751-[lblTitle]-turneryVerticalPadding@751-[lblMassage]-turneryVerticalPadding@751-[btnOk]-secondaryVirticalPadding@751-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_V)
        
        
        //btnOK
        btnOk.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.4).isActive = true
        btnOk.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        //Close Button
        btnClose.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        btnClose.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        
        container.layoutIfNeeded()
        container.layoutSubviews()
        self.layoutIfNeeded()
        self.layoutSubviews()
        
        baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    
}
