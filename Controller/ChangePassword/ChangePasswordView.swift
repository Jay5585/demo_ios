//
//  ChangePasswordView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 10/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class ChangePasswordView: BaseView {
    
    // Mark: - Attributes -
    var container : UIView!
    
    var lblTitle : BaseLabel!
    
    var txtCurrentPassword : BaseTextField!
    var txtNewPassword : BaseTextField!
    var txtConfirmPassword : BaseTextField!
    
    var btnChange : BaseButton!
    
    var btnClose : BaseButton!
    
    
    
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
        print("ChangePasswordView denint called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if container != nil && container.superview != nil {
            container.removeFromSuperview()
            container = nil
        }
        if lblTitle != nil && lblTitle.superview != nil {
            lblTitle.removeFromSuperview()
            lblTitle = nil
        }
        if txtCurrentPassword != nil && txtCurrentPassword.superview != nil {
            txtCurrentPassword.removeFromSuperview()
            txtCurrentPassword = nil
        }
        if txtNewPassword != nil && txtNewPassword.superview != nil {
            txtNewPassword.removeFromSuperview()
            txtNewPassword = nil
        }
        if txtConfirmPassword != nil && txtConfirmPassword.superview != nil {
            txtConfirmPassword.removeFromSuperview()
            txtConfirmPassword = nil
        }
        if btnChange != nil && btnChange.superview != nil {
            btnChange.removeFromSuperview()
            btnChange = nil
        }
        if btnClose != nil && btnClose.superview != nil {
            btnClose.removeFromSuperview()
            btnClose = nil
        }
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        container = UIView(frame: CGRect.zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
        
        lblTitle = BaseLabel(labelType: .headerSmall, superView: container)
        lblTitle.textColor = Color.appIntermidiateBG.value
        lblTitle.text = "Change Password?"
        
        txtCurrentPassword = BaseTextField(iSuperView: container, TextFieldType: .baseShowPasswordType)
        txtCurrentPassword.placeholder = "Current Password"
        txtCurrentPassword.setLeftIcon(icon: UIImage(named: "Password"))
        txtCurrentPassword.errorMessage = ""
        txtCurrentPassword.delegate = self
        
        txtNewPassword = BaseTextField(iSuperView: container, TextFieldType: .baseShowPasswordType)
        txtNewPassword.placeholder = "New Password"
        txtNewPassword.setLeftIcon(icon: UIImage(named: "Password"))
        txtNewPassword.errorMessage = ""
        txtNewPassword.delegate = self
        
        txtConfirmPassword = BaseTextField(iSuperView: container, TextFieldType: .baseShowPasswordType)
        txtConfirmPassword.placeholder = "Confirm Password"
        txtConfirmPassword.setLeftIcon(icon: UIImage(named: "Password"))
        txtConfirmPassword.errorMessage = ""
        txtConfirmPassword.delegate = self
        
        btnChange = BaseButton(ibuttonType: .primary, iSuperView: container)
        btnChange.setTitle("Change", for: .normal)
        
        btnClose = BaseButton(ibuttonType: .close, iSuperView: container)
        
        
        btnChange.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            self!.endEditing(true)
            var isError = false
            
            //txtCurrentPassword
            if let trimmedString : String = self!.txtCurrentPassword.text?.trimmed(), trimmedString == "" {
                self!.txtCurrentPassword.errorMessage =  "Enter your current password"
                self!.txtCurrentPassword.text = ""
                isError = true
            }
            else {
                self!.txtNewPassword.errorMessage =  ""
            }
            
            //txtNewPassword
            if let trimmedString : String = self!.txtNewPassword.text?.trimmed(), trimmedString == "" {
                self!.txtNewPassword.errorMessage =  "New Password is required"
                self!.txtNewPassword.text = ""
                isError = true
            }
            else {
                self!.txtNewPassword.errorMessage =  ""
            }
            
            
            //txtConfirmPasswod
            if let trimmedString : String = self!.txtConfirmPassword.text?.trimmed(), trimmedString == "" {
                self!.txtConfirmPassword.errorMessage =  "Confirm Password is required"
                self!.txtConfirmPassword.text = ""
                isError = true
            }
            else if let Confirmpassword : String = self!.txtConfirmPassword.text , let password : String = self!.txtNewPassword.text, password != "" && password != Confirmpassword {
                self!.txtConfirmPassword.errorMessage =  "Password does not match"
                isError = true
            }
            else {
                self!.txtConfirmPassword.errorMessage =  ""
            }
            
            if !isError {
                self!.changePasswordRequest()
            }
            
        }
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        
        baseLayout.viewDictionary = ["container" : container,
                                     "lblTitle" : lblTitle,
                                     "txtCurrentPassword" : txtCurrentPassword,
                                     "txtNewPassword" : txtNewPassword,
                                     "txtConfirmPassword" : txtConfirmPassword,
                                     "btnChange" : btnChange,
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
        
        
        txtCurrentPassword.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        txtCurrentPassword.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding-[lblTitle]-secondaryVirticalPadding-[txtCurrentPassword]-secondaryVirticalPadding-[txtNewPassword]-secondaryVirticalPadding-[txtConfirmPassword]", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_V)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[txtConfirmPassword]-turneryVerticalPadding-[btnChange]-secondaryVirticalPadding-|", options: [.alignAllCenterX], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        container.addConstraints(baseLayout.control_V)
        
        btnChange.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        
        
        //Close Button
        btnClose.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        btnClose.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    func changePasswordRequest() {
        
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KEmailId), forKey: "emailId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(self!.txtCurrentPassword.text, forKey: "currentPassword")
            dictParameter.setValue(self!.txtNewPassword.text, forKey: "newPassword")
            
            
            BaseAPICall.shared.postReques(URL: APIConstant.changePassword, Parameter: dictParameter, Type: APITask.ChangePassword, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(_, let error):
                    
                    self!.makeToast(error!.alertMessage, duration: ToastManager.shared.duration, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tap) in
                        if self == nil {
                            return
                        }
                        
                        if let controller : ChangePasswordController = self!.getViewControllerFromSubView() as? ChangePasswordController {
                            controller.popupController?.dismiss()
                        }
                    })
                    
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

extension ChangePasswordView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtCurrentPassword {
            if let trimmedString : String = textField.text?.trimmed(), trimmedString == "" {
                txtCurrentPassword.errorMessage =  "Enter your current password"
                txtCurrentPassword.text = ""
            }
            else {
                txtCurrentPassword.errorMessage = ""
            }
        }
        else if textField == txtNewPassword {
            if let trimmedString : String = textField.text?.trimmed(), trimmedString == "" {
                txtNewPassword.errorMessage =  "New Password is required"
                txtNewPassword.text = ""
            }
            else if let password : String = textField.text , let Confirmpassword : String = txtConfirmPassword.text, Confirmpassword != "" && password != Confirmpassword {
                txtNewPassword.errorMessage =  "Password does not match"
            }
            else {
                txtNewPassword.errorMessage =  ""
            }
        }
        else if textField == txtConfirmPassword {
            if let trimmedString : String = textField.text?.trimmed(), trimmedString == "" {
                txtConfirmPassword.errorMessage =  "Confirm Password is required"
                txtConfirmPassword.text = ""
            }
            else if let Confirmpassword : String = textField.text , let password : String = txtNewPassword.text, password != "" && password != Confirmpassword {
                txtConfirmPassword.errorMessage =  "Password does not match"
            }
            else {
                txtConfirmPassword.errorMessage =  ""
            }
        }
        
        return true
    }
}
