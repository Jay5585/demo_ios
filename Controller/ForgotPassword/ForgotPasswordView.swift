//
//  ForgotPasswordView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 01/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class ForgotPasswordView: BaseView {
    // Mark: - Attributes -
    var container : UIView!
    
    var lblTitle : BaseLabel!
    var txtEmail : BaseTextField!
    var btnForgotPassword : BaseButton!
    
    
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
        print("ForgotPasswordView Deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        if btnForgotPassword != nil && btnForgotPassword.superview != nil {
            btnForgotPassword.removeFromSuperview()
            btnForgotPassword = nil
        }
        if txtEmail != nil && txtEmail.superview != nil {
            txtEmail.removeFromSuperview()
            txtEmail = nil
        }
        
        if lblTitle != nil && lblTitle.superview != nil {
            lblTitle.removeFromSuperview()
            lblTitle = nil
        }
        
        if container != nil && container.superview != nil {
            container.removeFromSuperview()
            container = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        container = UIView(frame: CGRect.zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
        
        lblTitle = BaseLabel(labelType: .headerSmall, superView: container)
        lblTitle.textColor = Color.lableSecondry.value
        lblTitle.text = "Forgot Password?"
        
        txtEmail = BaseTextField(iSuperView: container, TextFieldType: .baseNoAutoScrollType)
        txtEmail.placeholder = "Enter Your Email"
        txtEmail.setLeftIcon(icon: UIImage(named: "Email"))
        txtEmail.errorMessage = ""
        txtEmail.keyboardType = .emailAddress
        txtEmail.delegate = self
        
        btnForgotPassword = BaseButton(ibuttonType: .primary, iSuperView: container)
        btnForgotPassword.setTitle("Reset Password", for: UIControlState())
        btnForgotPassword.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            
            if let trimmedString : String = self!.txtEmail.text?.trimmed(), trimmedString == "" {
                self!.txtEmail.errorMessage =  "Email required"
                self!.txtEmail.text = ""
            }
            else if let email : String = self!.txtEmail.text, AppUtility.isValidEmail(email) {
                self!.txtEmail.errorMessage = ""
                self!.forgotPasswordRequest()
            }
            else {
                self!.txtEmail.errorMessage =  "Invalid email id"
            }
            
        }
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        
        baseLayout.viewDictionary = ["container" : container,
                                 "lblTitle" : lblTitle,
                                 "txtEmail" : txtEmail,
                                 "btnForgotPassword" : btnForgotPassword]
        
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
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[lblTitle]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_H)
        
        txtEmail.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        txtEmail.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0).isActive = true
        
        btnForgotPassword.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        btnForgotPassword.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding-[lblTitle]-secondaryVirticalPadding-[txtEmail]-secondaryVirticalPadding-[btnForgotPassword]-secondaryVirticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_V)
        
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        
        baseLayout.releaseObject()
    }
    
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    fileprivate func forgotPasswordRequest() {
        
        let dictParameter : NSMutableDictionary = NSMutableDictionary()
        dictParameter.setValue(txtEmail.text?.trimmed(), forKey: "emailId")
        
        BaseAPICall.shared.postReques(URL: APIConstant.forgotPassword, Parameter: dictParameter, Type: APITask.ForgotPassword, completionHandler: { [weak self] (result) in
            if self == nil {
                return
            }
            
            switch result{
            case .Success(_, let error):
                self!.hideProgressHUD()
                
                self!.makeToast(error!.alertMessage, duration: ToastManager.shared.duration, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tap) in
                    if self == nil {
                        return
                    }
                    if let controller : ForgotPasswordViewController = self!.getViewControllerFromSubView() as? ForgotPasswordViewController {
                        controller.popupController?.dismiss()
                    }
                })
                
                break
                
            case .Error(let error):
                
                self!.hideProgressHUD()
                self!.makeToast(error!.alertMessage)
                
                
                break
            case .Internet(let isOn):
                self!.handleNetworkCheck(isAvailable: isOn, insideView: AppUtility.getAppDelegate().window!)
                break
            }
        })
    }
}

extension ForgotPasswordView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            if let trimmedString : String = textField.text?.trimmed(), trimmedString == "" {
                txtEmail.errorMessage =  "Email required"
                self.txtEmail.text = ""
            }
            else if let email : String = self.txtEmail.text, AppUtility.isValidEmail(email) {
                txtEmail.errorMessage = ""
            }
            else {
                txtEmail.errorMessage =  "Invalid email id"
            }
        }
        
        return true
    }
}


