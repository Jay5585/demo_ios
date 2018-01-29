//
//  LoginView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 01/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import ActiveLabel
import STPopup

class LoginView: BaseView {

    // Mark: - Attributes -
    var scrollView : BaseScrollView!
    var containerView : UIView!
    
    var imgLogo : BaseImageView!
    
    var txtEmail : BaseTextField!
    var txtPassword : BaseTextField!
    
    var btnLogin : BaseButton!
    var lblForgotPassword : ActiveLabel!
    var lblSkip : ActiveLabel!
    
    var lblSignUp : ActiveLabel!
    
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
        print("LoginView Deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if lblSkip != nil && lblSkip.superview != nil {
            lblSkip.removeFromSuperview()
            lblSkip = nil
        }
        
        if imgLogo != nil && imgLogo.superview != nil {
            imgLogo.removeFromSuperview()
            imgLogo = nil
        }
        
        if txtEmail != nil && txtEmail.superview != nil {
            txtEmail.removeFromSuperview()
            txtEmail = nil
        }
        
        if txtPassword != nil && txtPassword.superview != nil {
            txtPassword.removeFromSuperview()
            txtPassword = nil
        }
        
        if btnLogin != nil && btnLogin.superview != nil {
            btnLogin.removeFromSuperview()
            btnLogin = nil
        }
        
        if lblForgotPassword != nil && lblForgotPassword.superview != nil {
            lblForgotPassword.removeFromSuperview()
            lblForgotPassword = nil
        }
        
        if lblSignUp != nil && lblSignUp.superview != nil {
            lblSignUp.removeFromSuperview()
            lblSignUp = nil
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
        
        imgLogo = BaseImageView(type: .defaultImg, superView: containerView)
        imgLogo.image = UIImage(named: "logo")
        
        txtEmail = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtEmail.placeholder = "Email Address"
        txtEmail.setLeftIcon(icon: UIImage(named: "Email"))
        txtEmail.errorMessage = ""
        txtEmail.keyboardType = .emailAddress
        txtEmail.delegate = self
        
        
        txtPassword = BaseTextField(iSuperView: containerView, TextFieldType: .baseShowPasswordType)
        txtPassword.placeholder = "Password"
        txtPassword.setLeftIcon(icon: UIImage(named: "Password"))
        txtPassword.errorMessage = ""
        txtPassword.delegate = self
        
        btnLogin = BaseButton(ibuttonType: .primary, iSuperView: containerView)
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.setButtonTouchUpInsideEvent { [weak self] (object, sender) in
            if self == nil {
                return
            }
            self!.endEditing(true)
            var isError = false
            
            if let trimmedString : String = self!.txtEmail.text?.trimmed(), trimmedString == "" {
                self!.txtEmail.errorMessage =  "Email required"
                self!.txtEmail.text = ""
                isError = true
            }
            else if let email : String = self!.txtEmail.text, AppUtility.isValidEmail(email) {
                self!.txtEmail.errorMessage = ""
            }
            else {
                self!.txtEmail.errorMessage =  "Invalid email id"
                isError = true
            }
            
            if let password : String = self!.txtPassword.text?.trimmed(), password != "" {
                self!.txtPassword.errorMessage = ""
            }
            else {
                self!.txtPassword.errorMessage = "Password required"
                self!.txtPassword.text = ""
                isError = true
            }
            
            if !isError {
                self!.loginRequest()
            }
        }
        
        
        lblForgotPassword = ActiveLabel(frame: .zero)
        lblForgotPassword.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lblForgotPassword)
        
        lblForgotPassword.customize { [weak self] label in
            if self == nil {
                return
            }
            
            label.textColor = Color.lablePrimary.value
            label.text = " Forgot Password? "
            let customType = ActiveType.custom(pattern: "\\sForgot Password?\\b")
            label.enabledTypes = [customType]
            label.textAlignment = .center
            label.customColor[customType] = Color.lablePrimary.value
            label.customSelectedColor[customType] = Color.lableSecondry.value
            label.font = UIFont(name: FontStyle.bold, size: 14.0)
            
            label.handleCustomTap(for: customType, handler: { [weak self] (str) in
                if self == nil {
                    return
                }
                
                self!.endEditing(true)
                if let controller : LoginViewController = self!.getViewControllerFromSubView() as? LoginViewController {
                    let forgotPassword : ForgotPasswordViewController = ForgotPasswordViewController()
                    
                    controller.popUp = STPopupController.init(rootViewController: forgotPassword)
                    controller.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(controller.closePoup(_:))))                    
                    controller.popUp.navigationBarHidden = true
                    controller.popUp.hidesCloseButton = true
                    controller.popUp.present(in: controller)
                }
            })
        }
        
        lblSignUp = ActiveLabel(frame: .zero)
        lblSignUp.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lblSignUp)
        lblSignUp.customize { [weak self] label in
            if self == nil {
                return
            }
            
            label.textColor = Color.lablePrimary.withAlpha(0.7)
            label.text = "Do not have an account? Sign Up"
            let customType = ActiveType.custom(pattern: "\\sSign Up\\b")
            label.enabledTypes = [customType]
            label.textAlignment = .center
            label.customColor[customType] = Color.lablePrimary.value
            label.customSelectedColor[customType] = Color.lableSecondry.value
            label.font = UIFont(name: FontStyle.bold, size: 14.0)
            
            label.handleCustomTap(for: customType, handler: { [weak self] (str) in
                if self == nil {
                    return
                }
                
                self!.endEditing(true)
                if let controller : LoginViewController = self!.getViewControllerFromSubView() as? LoginViewController {
                    let signUpViewController : SignUpViewController = SignUpViewController()
                    controller.navigationController?.pushViewController(signUpViewController, animated: true)
                }
            })
        }
        
        
        lblSkip = ActiveLabel(frame: .zero)
        lblSkip.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lblSkip)
        lblSkip.customize { [weak self] label in
            if self == nil {
                return
            }
            
            label.textColor = Color.lablePrimary.value
            //label.text = " Skip "
            label.text = ""
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
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["scrollView" : scrollView,
                                     "containerView" : containerView,
                                     "imgLogo" : imgLogo,
                                     "txtEmail" : txtEmail,
                                     "txtPassword" : txtPassword,
                                     "btnLogin" : btnLogin,
                                     "lblForgotPassword" : lblForgotPassword,
                                     "lblSignUp" : lblSignUp,
                                     "lblSkip" : lblSkip]
        
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
        
        // ScrollView
        baseLayout.expandView(scrollView, insideView: self)
        
        //imgLogo
        imgLogo.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imgLogo.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        imgLogo.heightAnchor.constraint(equalTo: imgLogo.widthAnchor, constant: 0).isActive = true
        
        //TextField
        txtEmail.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
        txtPassword.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-secondaryVirticalPadding-[imgLogo]-turneryVerticalPadding-[txtEmail]-secondaryVirticalPadding-[txtPassword]-turneryVerticalPadding-[btnLogin]-secondaryVirticalPadding-[lblForgotPassword]", options: [.alignAllCenterX], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_V)
        
        //btnLogin
        btnLogin.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        
        //lblSignUp
        lblForgotPassword.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8, constant: 0).isActive = true
        
        lblSignUp.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8, constant: 0).isActive = true
        lblSignUp.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        lblSignUp.topAnchor.constraint(greaterThanOrEqualTo: lblForgotPassword.bottomAnchor, constant: virticalPadding).isActive  = true
        
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[lblSignUp]-secondaryVirticalPadding-[lblSkip]-secondaryVirticalPadding-|", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_V)
        
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    
    public func loginRequest() {
        
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            var addr : String = "192.168.1.1"
            if AppUtility.getIFAddresses().count > 0{
                addr = AppUtility.getIFAddresses().first!
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue("iPhone", forKey: "deviceType")
            dictParameter.setValue("iOS", forKey: "os")
            dictParameter.setValue(addr, forKey: "ipAddress")
            dictParameter.setValue(self!.txtEmail.text?.trimmed(), forKey: "emailId")
            dictParameter.setValue(self!.txtPassword.text, forKey: "password")
            
            BaseAPICall.shared.postReques(URL: APIConstant.login, Parameter: dictParameter, Type: APITask.Login, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(let object, let error):
                    self!.hideProgressHUD()
                    
                    let people : People = object as! People
                    
                    AppUtility.setUserDefaultsObject(people.userId as AnyObject, forKey: UserDefaultKey.KUserId)
                    AppUtility.setUserDefaultsObject(people.email as AnyObject, forKey: UserDefaultKey.KEmailId)
                    AppUtility.setUserDefaultsObject(people.token as AnyObject, forKey: UserDefaultKey.KAccessTocken)
                    AppUtility.setUserDefaultsObject("\(people.firstName) \(people.lastName)" as AnyObject, forKey: UserDefaultKey.KFullName)
                    AppUtility.setUserDefaultsObject(people.profilePicUrl as AnyObject, forKey: UserDefaultKey.KProfilePic)
                    AppUtility.setUserDefaultsObject(people.homeCourtId as AnyObject, forKey: UserDefaultKey.KHomeCourtId)
                    AppUtility.setUserDefaultsObject(people.paymentStatus as AnyObject, forKey: UserDefaultKey.KisPlayed)
                    
                    self!.makeToast(error!.alertMessage, duration: ToastManager.shared.duration, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tap) in
                        if self == nil {
                            return
                        }
                        AppUtility.getAppDelegate().displayDashboardViewOnWindow()
                    })
                    break
                    
                case .Error(let error):
                    
                    self!.hideProgressHUD()
                    self?.makeToast(error!.alertMessage)
                    
                    break
                case .Internet(let isOn):
                    self!.handleNetworkCheck(isAvailable: isOn, insideView: self!)
                    break
                }
            })
        }
    }
}

extension LoginView : UITextFieldDelegate {
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
        else if textField == txtPassword {
            if let password : String = self.txtPassword.text?.trimmed(), password != "" {
                txtPassword.errorMessage = ""
            }
            else {
                txtPassword.errorMessage = "Password required"
                txtPassword.text = ""
            }
        }
        
        return true
    }
}

