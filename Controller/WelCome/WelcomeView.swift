//
//  WelcomeView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 01/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import ActiveLabel

class WelcomeView: BaseView {

    // Mark: - Attributes -
    
    var scrollView : BaseScrollView!
    var containerView : UIView!
    var lblWelCome : BaseLabel!
    var lblDiscription : UITextView!
    
    var lblCreateProfile : BaseLabel!
    var btnStart : BaseButton!
    
    var lblSkip : ActiveLabel!
    
    
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
        print("WelcomeView Deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if lblSkip != nil && lblSkip.superview != nil {
            lblSkip.removeFromSuperview()
            lblSkip = nil
        }
        
        if btnStart != nil && btnStart.superview != nil {
            btnStart.removeFromSuperview()
            btnStart = nil
        }
        
        if lblCreateProfile != nil && lblCreateProfile.superview != nil {
            lblCreateProfile.removeFromSuperview()
            lblCreateProfile = nil
        }
        
        if lblDiscription != nil && lblDiscription.superview != nil {
            lblDiscription.removeFromSuperview()
            lblDiscription = nil
        }
        
        if lblWelCome != nil && lblWelCome.superview != nil {
            lblWelCome.removeFromSuperview()
            lblWelCome = nil
        }
        
        if containerView != nil && containerView.superview != nil {
            containerView.removeFromSuperview()
            containerView = nil
        }
        
        if scrollView != nil && scrollView.superview != nil {
            scrollView.removeFromSuperview()
            scrollView = nil
        }
        
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        scrollView = BaseScrollView(scrollType: .vertical, superView: self)
        containerView = scrollView.container
        
        lblWelCome = BaseLabel(labelType: .headerLarge, superView: containerView)
        lblWelCome.text = "Welcome!"
        
        lblDiscription = UITextView(frame: .zero)
        lblDiscription.translatesAutoresizingMaskIntoConstraints = false
        lblDiscription.isEditable = false
        lblDiscription.showsVerticalScrollIndicator = false
        lblDiscription.isSelectable = false
        
        lblDiscription.font = UIFont(name: FontStyle.medium, size: 13.0)
        lblDiscription.textColor = Color.lablePrimary.value
        lblDiscription.textAlignment = .center
        
        
        containerView.addSubview(lblDiscription)
        lblDiscription.text = ""
        
        lblCreateProfile = BaseLabel(labelType: .headerSmall, superView: containerView)
        lblCreateProfile.text = "Create Your Profile?"
        
        btnStart = BaseButton(ibuttonType: .primary, iSuperView: containerView)
        btnStart.setTitle("Start", for: .normal)
        
        lblSkip = ActiveLabel(frame: .zero)
        lblSkip.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lblSkip)
        lblSkip.customize { [weak self] label in
            
            if self == nil {
                return
            }
            
            label.textColor = Color.lablePrimary.value
            label.text = " Skip "
            let customType = ActiveType.custom(pattern: "\\sSkip\\b")
            label.enabledTypes = [customType]
            label.textAlignment = .center
            label.customColor[customType] = Color.lablePrimary.value
            label.customSelectedColor[customType] = Color.lableSecondry.value
            label.font = UIFont(name: FontStyle.bold, size: 14.0)
            
            label.handleCustomTap(for: customType, handler: { [weak self] (str) in
                if self == nil {
                    return
                }
                
                AppUtility.getAppDelegate().displayDashboardViewOnWindow()
            })
        }
        self.getAboutAppRequest()
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["scrollView" : scrollView,
                                     "containerView" : containerView,
                                     "lblWelCome" : lblWelCome,
                                     "lblDiscription" : lblDiscription,
                                     "lblCreateProfile" : lblCreateProfile,
                                     "btnStart" : btnStart,
                                     "lblSkip" : lblSkip]
        
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
        
        // ScrollView
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-64-[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[lblWelCome]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-virticalPadding-[lblWelCome]-virticalPadding-[lblDiscription]-turneryVerticalPadding-[lblCreateProfile]", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_V)
        
        
        //lblCreateProfile
        lblCreateProfile.topAnchor.constraint(equalTo: containerView.centerYAnchor, constant: turneryVerticalPadding).isActive = true
        
        //btnStart
        btnStart.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        btnStart.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[lblCreateProfile]-secondaryVirticalPadding-[btnStart]", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_V)
        
        
        //lblSkip
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[lblSkip]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_H)
        lblSkip.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -secondaryVirticalPadding).isActive = true
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        
        baseLayout.releaseObject()        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    
    fileprivate func getAboutAppRequest() {
        BaseAPICall.shared.postReques(URL: APIConstant.aboutApp, Parameter: NSDictionary(), Type: APITask.AboutApp, completionHandler: { [weak self] (result) in
            if self == nil {
                return
            }
            
            switch result{
            case .Success(let object, _):
                self!.hideProgressHUD()
                
                if let data : NSDictionary = object!["data"] as? NSDictionary {
                    if let massage : String = data["cms"] as? String {
                        self?.lblDiscription.text = massage
                    }
                }
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
