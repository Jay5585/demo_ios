//
//  PlayingHourPopUpView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 04/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class PlayingHourPopUpView: BaseView {
    
    // Mark: - Attributes -
    var container : UIView!
    
    var lblTitle : BaseLabel!
    var btnClose : BaseButton!
    
    var scrollView : BaseScrollView!
    var scrollContantView : UIView!
    var btnSubmit : BaseButton!
    
    var rdoHour1 : BaseButton!
    var rdoHour2 : BaseButton!
    var rdoHour3 : BaseButton!
    var rdoHour4 : BaseButton!
    var rdoHour5 : BaseButton!
    var rdoHour6 : BaseButton!
    var rdoHour7 : BaseButton!
    var rdoHour8 : BaseButton!
    var rdoHour9 : BaseButton!
    var rdoHour10 : BaseButton!
    var rdoHour11 : BaseButton!
    var rdoHour12 : BaseButton!
    
    var arrRadioButton : [BaseButton] = []
    var btnSelected : BaseButton!
    
    
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
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        container = UIView(frame: CGRect.zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
        
        lblTitle = BaseLabel(labelType: .headerSmall, superView: container)
        lblTitle.textColor = Color.lableSecondry.value
        lblTitle.text = "How long are you playing?"
        lblTitle.numberOfLines = 2
        
        scrollView = BaseScrollView(scrollType: .vertical, superView: container)
        scrollContantView = scrollView.container
        
        btnClose = BaseButton(ibuttonType: .close, iSuperView: container)
        
        btnSubmit = BaseButton(ibuttonType: .primary, iSuperView: container)
        btnSubmit.setTitle("Ok", for: .normal)
        
        
        rdoHour1 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour1.tag = 1
        rdoHour1.setTitle("1 Hour", for: .normal)
        rdoHour1.isSelected = true
        btnSelected = rdoHour1
        arrRadioButton.append(rdoHour1)
        
        rdoHour2 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour2.tag = 2
        rdoHour2.setTitle("2 Hours", for: .normal)
        arrRadioButton.append(rdoHour2)
        
        
        rdoHour3 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour3.tag = 3
        rdoHour3.setTitle("3 Hours", for: .normal)
        arrRadioButton.append(rdoHour3)
        
        
        rdoHour4 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour4.tag = 4
        rdoHour4.setTitle("4 Hours", for: .normal)
        arrRadioButton.append(rdoHour4)
        
        
        rdoHour5 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour5.tag = 5
        rdoHour5.setTitle("5 Hours", for: .normal)
        arrRadioButton.append(rdoHour5)
        
        
        rdoHour6 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour6.tag = 6
        rdoHour6.setTitle("6 Hours", for: .normal)
        arrRadioButton.append(rdoHour6)
        
        
        rdoHour7 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour7.tag = 7
        rdoHour7.setTitle("7 Hours", for: .normal)
        arrRadioButton.append(rdoHour7)
        
        
        rdoHour8 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour8.tag = 8
        rdoHour8.setTitle("8 Hours", for: .normal)
        arrRadioButton.append(rdoHour8)
        
        
        rdoHour9 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour9.tag = 9
        rdoHour9.setTitle("9 Hours", for: .normal)
        arrRadioButton.append(rdoHour9)
        
        
        rdoHour10 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour10.tag = 10
        rdoHour10.setTitle("10 Hours", for: .normal)
        arrRadioButton.append(rdoHour10)
        
        
        rdoHour11 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour11.tag = 11
        rdoHour11.setTitle("11 Hours", for: .normal)
        arrRadioButton.append(rdoHour11)
        
        
        rdoHour12 = BaseButton(ibuttonType: .radio, iSuperView: scrollContantView)
        rdoHour12.tag = 12
        rdoHour12.setTitle("12 Hours", for: .normal)
        arrRadioButton.append(rdoHour12)
        
    
        for aButton in arrRadioButton {
            aButton.isUserInteractionEnabled = true
            aButton.addTarget(self, action: #selector(self.btnRadioPressed(sendor:)), for: UIControlEvents.touchUpInside)
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["container" : container,
                                     "lblTitle" : lblTitle,
                                     "scrollView" : scrollView,
                                     "btnSubmit" : btnSubmit,
                                     "rdoHour1" : rdoHour1,
                                     "rdoHour2" : rdoHour2,
                                     "rdoHour3" : rdoHour3,
                                     "rdoHour4" : rdoHour4,
                                     "rdoHour5" : rdoHour5,
                                     "rdoHour6" : rdoHour6,
                                     "rdoHour7" : rdoHour7,
                                     "rdoHour8" : rdoHour8,
                                     "rdoHour9" : rdoHour9,
                                     "rdoHour10" : rdoHour10,
                                     "rdoHour11" : rdoHour11,
                                     "rdoHour12" : rdoHour12]
        
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
        container.heightAnchor.constraint(equalToConstant: 350).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-35-[lblTitle]-35-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_H)
        
        //ScrollView
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_H)
        
        //btnSubmit
        btnSubmit.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.4).isActive = true
        btnSubmit.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding-[lblTitle]-secondaryVirticalPadding-[scrollView]-turneryVerticalPadding-[btnSubmit]-secondaryVirticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_V)
        
        //Close Button
        btnClose.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        btnClose.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        
        //Under Scroll View
        
        rdoHour1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        rdoHour1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-virticalPadding-[rdoHour1]-secondaryVirticalPadding-[rdoHour2]-secondaryVirticalPadding-[rdoHour3]-secondaryVirticalPadding-[rdoHour4]-secondaryVirticalPadding-[rdoHour5]-secondaryVirticalPadding-[rdoHour6]-secondaryVirticalPadding-[rdoHour7]-secondaryVirticalPadding-[rdoHour8]-secondaryVirticalPadding-[rdoHour9]-secondaryVirticalPadding-[rdoHour10]-secondaryVirticalPadding-[rdoHour11]-secondaryVirticalPadding-[rdoHour12]-virticalPadding-|", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        scrollContantView.addConstraints(baseLayout.control_V)
        
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    @objc private func btnRadioPressed(sendor : BaseButton){
        if sendor.isSelected == false{
            btnSelected.isSelected = false
            btnSelected = sendor
            btnSelected.isSelected = true
        }
        else{
            return
        }
    }
    
    // MARK: - Server Request -
    
}
