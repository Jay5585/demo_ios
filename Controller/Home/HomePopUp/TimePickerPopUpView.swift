//
//  TimePickerPopUpView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 05/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class TimePickerPopUpView: BaseView {
    
    // Mark: - Attributes -
    var container : UIView!
    
    var lblTitle : BaseLabel!
    var lblTime : BaseLabel!
    var pickerView : UIDatePicker!
    var btnClose : BaseButton!
    var btnSubmit : BaseButton!
    
    
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
        print("TimePickerPopUpView deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if btnSubmit != nil && btnSubmit.superview != nil {
            btnSubmit.removeFromSuperview()
            btnSubmit = nil
        }
        if btnClose != nil && btnClose.superview != nil {
            btnClose.removeFromSuperview()
            btnClose = nil
        }
        
        if lblTime != nil && lblTime.superview != nil {
            lblTime.removeFromSuperview()
            lblTime = nil
        }
        
        if lblTitle != nil && lblTitle.superview != nil {
            lblTitle.removeFromSuperview()
            lblTitle = nil
        }
        
        if container != nil && container.superview != nil {
            container.removeFromSuperview()
            container = nil
        }
        pickerView = nil
        
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        container = UIView(frame: CGRect.zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
        
        lblTitle = BaseLabel(labelType: .headerSmall, superView: container)
        lblTitle.textColor = Color.lableSecondry.value
        lblTitle.text = "What time will you be there?"
        lblTitle.numberOfLines = 2
        
        lblTime = BaseLabel(labelType: .large, superView: container)
        
        pickerView = UIDatePicker()
        pickerView.datePickerMode = .time
        pickerView.minimumDate = Date()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.addTarget(self, action: #selector(pickerTimeChanged(sender:)), for: UIControlEvents.valueChanged)
        pickerView.setValue(Color.lablePrimary.value, forKey: "textColor")
        container.addSubview(pickerView)
        
        btnClose = BaseButton(ibuttonType: .close, iSuperView: container)
        
        btnSubmit = BaseButton(ibuttonType: .primary, iSuperView: container)
        btnSubmit.setTitle("Ok", for: .normal)
        
        pickerView.setDate(Date(), animated: true)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        lblTime.text = formatter.string(from: pickerView.date)
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["container" : container,
                                     "lblTitle" : lblTitle,
                                     "pickerView" : pickerView,
                                     "lblTime" : lblTime,
                                     "btnSubmit" : btnSubmit]
        
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
        container.heightAnchor.constraint(equalToConstant: 320).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        pickerView.heightAnchor.constraint(lessThanOrEqualTo: pickerView.widthAnchor, multiplier: 1.0).isActive = true
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-turneryVerticalPadding-[pickerView]-turneryVerticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-35-[lblTitle]-35-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_H)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding-[lblTitle]-turneryVerticalPadding-[lblTime][pickerView]-virticalPadding-[btnSubmit]-secondaryVirticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_V)
        
        //Lables
        lblTime.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0).isActive = true
        
        //btnSubmit
        btnSubmit.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.4).isActive = true
        btnSubmit.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        //Close Button
        btnClose.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        btnClose.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    func pickerTimeChanged(sender : UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        lblTime.text = formatter.string(from: sender.date)
    }
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    
}
