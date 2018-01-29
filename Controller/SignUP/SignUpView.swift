//
//  SignUpView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 02/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import ActiveLabel


class SignUpView: BaseView {
    // Mark: - Attributes -
    var scrollView : BaseScrollView!
    var containerView : UIView!
    
    var txtFirstName : BaseTextField!
    var txtLastName : BaseTextField!
    var txtEmail : BaseTextField!
    var txtBirthDate : BaseTextField!
    var txtPassword : BaseTextField!
    var txtConfirmPasswod : BaseTextField!
    
    var datePicker : UIDatePicker!

    var btnSignUp : BaseButton!
    
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
        print("SignUpView Deinit called")
        self.releaseObject()
    }
    
    
    override func releaseObject() {
        super.releaseObject()
        
        if btnSignUp != nil && btnSignUp.superview != nil {
            btnSignUp.removeFromSuperview()
            btnSignUp = nil
        }
        
        if txtConfirmPasswod != nil && txtConfirmPasswod.superview != nil {
            txtConfirmPasswod.removeFromSuperview()
            txtConfirmPasswod = nil
        }
        
        if txtPassword != nil && txtPassword.superview != nil {
            txtPassword.removeFromSuperview()
            txtPassword = nil
        }
        
        
        if txtEmail != nil && txtEmail.superview != nil {
            txtEmail.removeFromSuperview()
            txtEmail = nil
        }
        
        if txtBirthDate != nil && txtBirthDate.superview != nil {
            txtBirthDate.removeFromSuperview()
            txtBirthDate = nil
        }

        
        if txtLastName != nil && txtLastName.superview != nil {
            txtLastName.removeFromSuperview()
            txtLastName = nil
        }
        
        if txtFirstName != nil && txtFirstName.superview != nil {
            txtFirstName.removeFromSuperview()
            txtFirstName = nil
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
        
        txtFirstName = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtFirstName.setLeftIcon(icon: UIImage(named: "user"))
        txtFirstName.autocapitalizationType = .words
        txtFirstName.placeholder = "First Name * "
        txtFirstName.errorMessage = ""
        txtFirstName.delegate = self
        
        txtLastName = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtLastName.setLeftIcon(icon: UIImage(named: "user"))
        txtLastName.autocapitalizationType = .words
        txtLastName.placeholder = "Last Name"
        txtLastName.errorMessage = ""
        txtLastName.delegate = self
        
        txtEmail = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtEmail.setLeftIcon(icon: UIImage(named: "Email"))
        txtEmail.placeholder = "Email Address * "
        txtEmail.errorMessage = ""
        txtEmail.keyboardType = .emailAddress
        txtEmail.delegate = self
        
        txtBirthDate = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoClearButtonTextFieldType)
        txtBirthDate.setLeftIcon(icon: UIImage(named: "BirthDate"))
        txtBirthDate.placeholder = "Bith Date * "
        txtBirthDate.errorMessage = ""
        txtBirthDate.delegate = self

        
        txtPassword = BaseTextField(iSuperView: containerView, TextFieldType: .baseShowPasswordType)
        txtPassword.setLeftIcon(icon: UIImage(named: "Password"))
        txtPassword.placeholder = "Password * "
        txtPassword.errorMessage = ""
        txtPassword.delegate = self
        
        txtConfirmPasswod = BaseTextField(iSuperView: containerView, TextFieldType: .baseShowPasswordType)
        txtConfirmPasswod.setLeftIcon(icon: UIImage(named: "Password"))
        txtConfirmPasswod.placeholder = "Confirm Password * "
        txtConfirmPasswod.errorMessage = ""
        txtConfirmPasswod.delegate = self
        
        btnSignUp = BaseButton(ibuttonType: .primary, iSuperView: containerView)
        btnSignUp.setTitle("Sign Up", for: .normal)
        
        
        datePicker = UIDatePicker()
        datePicker.tag = 0
        datePicker.datePickerMode = .date
        let earlyDate = NSCalendar.current.date(byAdding: .year, value: -13, to: Date())
        datePicker.date = earlyDate!
        txtBirthDate.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        btnSignUp.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            
            self!.endEditing(true)
            var isError = false
            
            //txtFirstName
            if let trimmedString : String = self!.txtFirstName.text?.trimmed(), trimmedString == "" {
                self!.txtFirstName.errorMessage =  "First name required"
                self!.txtFirstName.text = ""
                isError = true
            }
            else {
                self!.txtFirstName.errorMessage =  ""
            }
            
            //txtEmail
            if let trimmedString : String = self!.txtEmail.text?.trimmed(), trimmedString == "" {
                self!.txtEmail.errorMessage =  "Email required"
                self!.txtEmail.text = ""
                isError = true
            }
            else if let email : String = self!.txtEmail.text?.trimmed(), AppUtility.isValidEmail(email) {
                self!.txtEmail.errorMessage = ""
            }
            else {
                self!.txtEmail.errorMessage =  "Invalid email id"
                isError = true
            }
            
            //txtBirthDate
            let earlyDate : Date = NSCalendar.current.date(byAdding: .year, value: -13, to: Date())!
            if let str : String = self!.txtBirthDate.text?.trimmed(), str == "" {
                self!.txtBirthDate.errorMessage =  "Birth Date required"
                self!.txtBirthDate.text = ""
                isError = true
            }
            else if self!.datePicker.date > earlyDate {
                self!.txtBirthDate.errorMessage = "You need to be of 13 years for registration"
                isError = true
            }
            else {
                self!.txtBirthDate.errorMessage = ""
            }
            

            
            //txtPassword
            if let trimmedString : String = self!.txtPassword.text, trimmedString == "" {
                self!.txtPassword.errorMessage =  "Password required"
                self!.txtPassword.text = ""
                isError = true
            }
            else {
                self!.txtPassword.errorMessage =  ""
            }
            
            
            //txtConfirmPasswod
            if let trimmedString : String = self!.txtConfirmPasswod.text, trimmedString == "" {
                self!.txtConfirmPasswod.errorMessage =  "Confirm Password required"
                self!.txtConfirmPasswod.text = ""
                isError = true
            }
            else if let Confirmpassword : String = self!.txtConfirmPasswod.text , let password : String = self!.txtPassword.text, password != "" && password != Confirmpassword {
                self!.txtConfirmPasswod.errorMessage =  "Password does not match"
                isError = true
            }
            else {
                self!.txtConfirmPasswod.errorMessage =  ""
            }
            
            if !isError {
                self!.signUp()
            }
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["scrollView" : scrollView,
                                     "containerView" : containerView,
                                     "txtFirstName" : txtFirstName,
                                     "txtLastName" : txtLastName,
                                     "txtBirthDate" : txtBirthDate,
                                     "txtEmail" : txtEmail,
                                     "txtPassword" : txtPassword,
                                     "txtConfirmPasswod" : txtConfirmPasswod,
                                     "btnSignUp" : btnSignUp]
        
        
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
        
        txtFirstName.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
        txtFirstName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding-[txtFirstName]-secondaryVirticalPadding-[txtLastName]-secondaryVirticalPadding-[txtEmail]-secondaryVirticalPadding-[txtBirthDate]-secondaryVirticalPadding-[txtPassword]-secondaryVirticalPadding-[txtConfirmPasswod]", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_V)
        
        
        //btnSignUp
        btnSignUp.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[txtConfirmPasswod]-turneryVerticalPadding-[btnSignUp]-secondaryVirticalPadding-|", options: [.alignAllCenterX], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_V)
        
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    func handleDatePicker(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormate.KFullDate
        txtBirthDate.text = formatter.string(from: sender.date)
        
        let earlyDate : Date = NSCalendar.current.date(byAdding: .year, value: -13, to: Date())!
        if sender.date > earlyDate {
            txtBirthDate.errorMessage = "You need to be of 13 years for registration"
        }
        else {
            txtBirthDate.errorMessage = ""
        }
    }

    
    
    // MARK: - Server Request -
    
    fileprivate func signUp() {
        
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            var addr : String = "192.168.1.1"
            if AppUtility.getIFAddresses().count > 0 {
                addr = AppUtility.getIFAddresses().first!
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(self!.txtFirstName.text?.trimmed(), forKey: "firstName")
            dictParameter.setValue(self!.txtLastName.text?.trimmed(), forKey: "lastName")
            dictParameter.setValue(self!.txtEmail.text?.trimmed(), forKey: "emailId")
            dictParameter.setValue(Int(self!.datePicker.date.getUTCTimeStampe()), forKey: "birthDate")
            dictParameter.setValue(self!.txtPassword.text, forKey: "password")
            dictParameter.setValue("iPhone", forKey: "deviceType")
            dictParameter.setValue("iOS", forKey: "os")
            dictParameter.setValue(addr, forKey: "ipAddress")
            
            
            BaseAPICall.shared.postReques(URL: APIConstant.register, Parameter: dictParameter, Type: APITask.Register, completionHandler: { [weak self] (result) in
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
                    
                    AppUtility.getAppDelegate().window!.makeToast(error!.alertMessage)
                    if let controller : SignUpViewController = self!.getViewControllerFromSubView() as? SignUpViewController {
                        controller.navigationController?.pushViewController(WelcomeViewController(), animated: true)
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
}

extension SignUpView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtBirthDate {
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormate.KFullDate
            
            textField.text = ""
            textField.text = formatter.string(from: datePicker.date)
           
            let earlyDate : Date = NSCalendar.current.date(byAdding: .year, value: -13, to: Date())!
            if self.datePicker.date > earlyDate {
                self.txtBirthDate.errorMessage = "You need to be of 13 years for registration"
            }
            else {
                self.txtBirthDate.errorMessage = ""
            }
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
//        if textField.isFirstResponder {
//            if (textField.textInputMode?.primaryLanguage == "emoji") || !((textField.textInputMode?.primaryLanguage) != nil) {
//                return false
//            }
//        }
        
        if textField == txtFirstName || textField == txtLastName {
            var oldlength : Int = 0
            
            if textField.text != nil {
                oldlength = (textField.text?.characters.count)! + textField.text!.countEmojiCharacter()
            }
            
            let replaceMentLength : Int = string .characters.count
            let rangeLength : Int = range.length
            let newLength : Int = oldlength - rangeLength + replaceMentLength
            return newLength <= 50 || false
        }
        else if textField == txtEmail {
            var oldlength : Int = 0
            
            if textField.text != nil {
                oldlength = (textField.text?.characters.count)! + textField.text!.countEmojiCharacter()
            }
            
            let replaceMentLength : Int = string .characters.count
            let rangeLength : Int = range.length
            let newLength : Int = oldlength - rangeLength + replaceMentLength
            return newLength <= 150 || false
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtFirstName {
            if let trimmedString : String = textField.text?.trimmed(), trimmedString == "" {
                txtFirstName.errorMessage =  "First name required"
                self.txtFirstName.text = ""
            }
            else {
                txtFirstName.errorMessage =  ""
            }
        }
        else if textField == txtEmail {
            if let trimmedString : String = textField.text?.trimmed(), trimmedString == "" {
                txtEmail.errorMessage =  "Email required"
                self.txtEmail.text = ""
            }
            else if let email : String = self.txtEmail.text?.trimmed(), AppUtility.isValidEmail(email) {
                txtEmail.errorMessage = ""
            }
            else {
                txtEmail.errorMessage =  "Invalid email id"
            }
        }
            
        else if textField == txtPassword {
            if let trimmedString : String = textField.text, trimmedString == "" {
                txtPassword.errorMessage =  "Password required"
                self.txtPassword.text = ""
            }
            else if let password : String = textField.text , let Confirmpassword : String = txtConfirmPasswod.text, Confirmpassword != "" && password != Confirmpassword {
                txtPassword.errorMessage =  "Password does not match"
            }
            else {
                txtPassword.errorMessage =  ""
            }
        }
        else if textField == txtConfirmPasswod {
            if let trimmedString : String = textField.text, trimmedString == "" {
                txtConfirmPasswod.errorMessage =  "Confirm password required"
                self.txtConfirmPasswod.text = ""
            }
            else if let Confirmpassword : String = textField.text , let password : String = txtPassword.text, password != "" && password != Confirmpassword {
                txtConfirmPasswod.errorMessage =  "Password does not match"
            }
            else {
                txtConfirmPasswod.errorMessage =  ""
            }
        }
        return true
    }
}
