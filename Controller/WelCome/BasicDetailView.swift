//
//  BasicDetailView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import ActiveLabel
import Photos
import AVFoundation
import STPopup

class BasicDetailView: BaseView {

    // Mark: - Attributes -
    var scrollView : BaseScrollView!
    var containerView : UIView!
    
    var imgProfile : BaseImageView!
    var btnEditImage : UIButton!
    
    var txtNickName : BaseTextField!
    var txtPhoneNo : BaseTextField!
    var txtHeight : BaseTextField!
    var txtWeight : BaseTextField!
    var txtVertical : BaseTextField!
    var txtSchool : BaseTextField!
    var txtHomeTown : BaseTextField!
    
    var btnSignUp : BaseButton!
    var imagePicker : UIImagePickerController!
    
    var popUp : STPopupController!
    var alertController : BaseAlertController!
    
    
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
        print("BasicDetailView Deinit called")
        self.releaseObject()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    override func releaseObject() {
        super.releaseObject()
        
        
        if btnSignUp != nil && btnSignUp.superview != nil {
            btnSignUp.removeFromSuperview()
            btnSignUp = nil
        }
        
        if txtHomeTown != nil && txtHomeTown.superview != nil {
            txtHomeTown.removeFromSuperview()
            txtHomeTown = nil
        }
        
        if txtSchool != nil && txtSchool.superview != nil {
            txtSchool.removeFromSuperview()
            txtSchool = nil
        }
        
        if txtVertical != nil && txtVertical.superview != nil {
            txtVertical.removeFromSuperview()
            txtVertical = nil
        }
        
        if txtWeight != nil && txtWeight.superview != nil {
            txtWeight.removeFromSuperview()
            txtWeight = nil
        }
        
        if txtHeight != nil && txtHeight.superview != nil {
            txtHeight.removeFromSuperview()
            txtHeight = nil
        }
        
        if txtPhoneNo != nil && txtPhoneNo.superview != nil {
            txtPhoneNo.removeFromSuperview()
            txtPhoneNo = nil
        }
        
        if txtNickName != nil && txtNickName.superview != nil {
            txtNickName.removeFromSuperview()
            txtNickName = nil
        }
        
        if btnEditImage != nil && btnEditImage.superview != nil {
            btnEditImage.removeFromSuperview()
            btnEditImage = nil
        }
        
        if imgProfile != nil && imgProfile.superview != nil {
            imgProfile.removeFromSuperview()
            imgProfile = nil
        }
        
        if containerView != nil && containerView.superview != nil {
            containerView.removeFromSuperview()
            containerView = nil
        }
        
        if scrollView != nil && scrollView.superview != nil {
            scrollView.removeFromSuperview()
            scrollView = nil
        }
        
        imagePicker = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        scrollView = BaseScrollView(scrollType: .vertical, superView: self)
        containerView = scrollView.container
        
        imgProfile = BaseImageView(type: .profile, superView: containerView)
        imgProfile.displayImageFromURL("")
        imgProfile.tag = -1
        
        btnEditImage = UIButton(frame: .zero)
        btnEditImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(btnEditImage)
        btnEditImage.setImage(UIImage(named: "camera")?.maskWithColor(Color.appPrimaryBG.value), for: .normal)
        btnEditImage.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        btnEditImage.backgroundColor = Color.appSecondaryBG.value
        btnEditImage.addTarget(self, action: #selector(btnEditeProfileTapped(sender:)), for: .touchUpInside)
        
        
        txtNickName = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtNickName.autocapitalizationType = .words
        txtNickName.setLeftIcon(icon: UIImage(named: "user"))
        txtNickName.placeholder = "Nick Name"
        txtNickName.errorMessage = ""
        txtNickName.delegate = self
        
        txtPhoneNo = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtPhoneNo.setLeftIcon(icon: UIImage(named: "telephone"))
        txtPhoneNo.placeholder = "Phone Number"
        txtPhoneNo.errorMessage = ""
        txtPhoneNo.keyboardType = .phonePad
        txtPhoneNo.delegate = self
        
        txtHeight = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtHeight.setLeftIcon(icon: UIImage(named: "height"))
        txtHeight.placeholder = "Height (Feet.Inches)"
        txtHeight.keyboardType = .decimalPad
        txtHeight.errorMessage = ""
        txtHeight.delegate = self
        
        txtWeight = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtWeight.setLeftIcon(icon: UIImage(named: "weight"))
        txtWeight.placeholder = "Weight (Pounds)"
        txtWeight.keyboardType = .decimalPad
        txtWeight.errorMessage = ""
        txtWeight.delegate = self
        
        txtVertical = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtVertical.setLeftIcon(icon: UIImage(named: "vertical"))
        txtVertical.placeholder = "Vertical (Inches)"
        txtVertical.keyboardType = .numberPad
        txtVertical.errorMessage = ""
        txtVertical.delegate = self
        
        txtSchool = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtSchool.autocapitalizationType = .sentences
        txtSchool.setLeftIcon(icon: UIImage(named: "school"))
        txtSchool.placeholder = "School"
        txtSchool.errorMessage = ""
        txtSchool.delegate = self
        
        txtHomeTown = BaseTextField(iSuperView: containerView, TextFieldType: .baseNoAutoScrollType)
        txtHomeTown.autocapitalizationType = .sentences
        txtHomeTown.setLeftIcon(icon: UIImage(named: "home"))
        txtHomeTown.placeholder = "Hometown"
        txtHomeTown.errorMessage = ""
        txtHomeTown.delegate = self
        
        btnSignUp = BaseButton(ibuttonType: .primary, iSuperView: self)
        btnSignUp.setTitle("Get Started", for: .normal)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.barTintColor = Color.navigationBG.value
        imagePicker.navigationBar.tintColor = .white
        imagePicker.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white
        ]
        
        btnSignUp.setButtonTouchUpInsideEvent { [weak self] (sender, event) in
            if self == nil {
                return
            }
            
            self?.endEditing(true)
            var isError = false
            
            if let trimmedString : String = self!.txtPhoneNo.text?.trimmed(), trimmedString == "" {
                self!.txtPhoneNo.errorMessage = ""
                self!.txtPhoneNo.text = ""
            }
            else if let mobile : String = self!.txtPhoneNo.text, AppUtility.isValidPhone(mobile) {
                self!.txtPhoneNo.errorMessage = ""
            }
            else {
                self!.txtPhoneNo.errorMessage = "Invalid Phone Number"
                isError = true
            }
            
            
            if let trimmedString : String = self!.txtHeight.text?.trimmed(), trimmedString == "" {
                self!.txtHeight.errorMessage = ""
                self!.txtHeight.text = ""
            }
            else if let height : String = self!.txtHeight.text, AppUtility.isValiedHeight(height) {
                let arr = height.components(separatedBy: ".")
                if arr.count > 1 {
                    if Int(arr[1])! > 11 {
                        self!.txtHeight.errorMessage = "Check the inch and feet values"
                        isError = true
                    }
                    else {
                        self!.txtHeight.errorMessage = ""
                    }
                }
                else {
                    self!.txtHeight.errorMessage = ""
                }
            }
            else {
                self!.txtHeight.errorMessage = "Check the inch and feet values"
                isError = true
            }
            
            if let trimmedString : String = self!.txtVertical.text?.trimmed(), trimmedString == "" {
                self!.txtVertical.errorMessage = ""
                self!.txtVertical.text = ""
            }
            else if let vertical : String = self!.txtVertical.text, AppUtility.isValiedVirtical(vertical) {
                self!.txtVertical.errorMessage = ""
            }
            else {
                self!.txtVertical.errorMessage = "Check the inches values"
                isError = true
            }
            
            
            if let trimmedString : String = self!.txtWeight.text?.trimmed(), trimmedString == "" {
                self!.txtWeight.errorMessage = ""
                self!.txtWeight.text = ""
            }
            else if let weight : String = self!.txtWeight.text, AppUtility.isValiedWeight(weight) {
                self!.txtWeight.errorMessage = ""
            }
            else {
                self!.txtWeight.errorMessage = "Invalid Weight"
                isError = true
            }
            
            
            if !isError {
                self!.addProfileDetail()
            }
            
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["scrollView" : scrollView,
                                     "containerView" : containerView,
                                     "imgProfile" : imgProfile,
                                     "btnEditImage" : btnEditImage,
                                     "txtNickName" : txtNickName,
                                     "txtPhoneNo" : txtPhoneNo,
                                     "txtHeight" : txtHeight,
                                     "txtWeight" : txtWeight,
                                     "txtVertical" : txtVertical,
                                     "txtSchool" : txtSchool,
                                     "txtHomeTown" : txtHomeTown,
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
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: NSLayoutFormatOptions(), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]-secondaryVirticalPadding-[btnSignUp]-secondaryVirticalPadding-|", options: [.alignAllCenterX], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        //btnSignUp
        btnSignUp.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        
        //imgProfile
        imgProfile.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.3).isActive = true
        imgProfile.heightAnchor.constraint(equalTo: imgProfile.widthAnchor, multiplier: 1.0).isActive = true
        imgProfile.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imgProfile.topAnchor.constraint(equalTo: containerView.topAnchor, constant: turneryVerticalPadding).isActive = true
        
        //btnEditImage
        btnEditImage.heightAnchor.constraint(equalTo: imgProfile.heightAnchor, multiplier: 0.4).isActive = true
        btnEditImage.widthAnchor.constraint(equalTo: btnEditImage.heightAnchor, multiplier: 1.0).isActive = true
        btnEditImage.topAnchor.constraint(equalTo: imgProfile.centerYAnchor, constant: 8).isActive = true
        btnEditImage.centerXAnchor.constraint(equalTo: imgProfile.rightAnchor, constant: -8).isActive = true
        
        
        txtNickName.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
        txtNickName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        txtNickName.topAnchor.constraint(equalTo: imgProfile.bottomAnchor, constant: secondaryVirticalPadding).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[txtNickName]-secondaryVirticalPadding-[txtPhoneNo]-secondaryVirticalPadding-[txtHeight]-secondaryVirticalPadding-[txtWeight]-secondaryVirticalPadding-[txtVertical]-secondaryVirticalPadding-[txtSchool]-secondaryVirticalPadding-[txtHomeTown]-secondaryVirticalPadding-|", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_V)
        
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            InterfaceUtility.setCircleViewWith(Color.appSecondaryBG.value, width: 1.0, ofView: self!.imgProfile)
            InterfaceUtility.setCircleViewWith(Color.appSecondaryBG.value, width: 1.0, ofView: self!.btnEditImage)
        }
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    func btnEditeProfileTapped(sender : AnyObject) {
        
        self.endEditing(true)
        
        if let controller : BasicDetailViewController = self.getViewControllerFromSubView() as? BasicDetailViewController {
            var actionSheetController : UIAlertController! = UIAlertController(title: appName, message: "Select profile picture", preferredStyle: .actionSheet)
            var cancelAction : UIAlertAction! = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheetController.addAction(cancelAction)
            
            
            var takePictureAction: UIAlertAction! = UIAlertAction(title: "Take picture", style: .default) { [weak self] action -> Void in
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
            
            var choosePictureAction : UIAlertAction! = UIAlertAction(title: "Choose from camera roll", style: .default) { [weak self] action -> Void in
                
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
            
            actionSheetController = nil
            cancelAction = nil
            takePictureAction = nil
            choosePictureAction = nil
            
        }
        
    }
    
    
    // MARK: - Internal Helpers -
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        self.alertController = nil
        popUp.dismiss()
        popUp = nil
    }
    
    func loadImagePeacker() {
        if let controller : BaseViewController = self.getViewControllerFromSubView() as? BaseViewController {
            self.imagePicker.sourceType = .photoLibrary
            controller.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func loadAlertController(flag : Int) {
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            if let controller : BaseViewController = self!.getViewControllerFromSubView() as? BaseViewController {
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
    fileprivate func addProfileDetail() {
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(self!.txtNickName.text?.trimmed(), forKey: "nickName")
            dictParameter.setValue(self!.txtPhoneNo.text?.trimmed(), forKey: "phoneNumber")
            dictParameter.setValue(self!.txtSchool.text?.trimmed(), forKey: "userSchool")
            dictParameter.setValue(self!.txtHomeTown.text?.trimmed(), forKey: "homeTown")
            dictParameter.setValue(self!.txtVertical.text?.trimmed(), forKey: "userVertical")

            
            if let strHeight : String = self!.txtHeight.text?.trimmed(), strHeight != "" {
                let arr = strHeight.components(separatedBy: ".")
                var height : Int = 0
                for (ind, int) in arr.enumerated() {
                    if ind == 0 {
                        height = Int(int)! * 12
                    }
                    else if ind == 1 {
                        height = height + Int(int)!
                    }
                }
                dictParameter.setValue(height, forKey: "userHeight")
            }
            
            dictParameter.setValue(self!.txtWeight.text?.trimmed(), forKey: "userWeight")
            
            var arrToSend : NSMutableArray! = NSMutableArray()
            
            if self!.imgProfile.tag == 0 {
                var imageData : NSData! = UIImageJPEGRepresentation(self!.imgProfile.image!, 0.4) as NSData!
                var dicInfo : NSMutableDictionary! = NSMutableDictionary()
                dicInfo.setObject(imageData, forKey: "data" as NSCopying)
                dicInfo.setObject("profilePic", forKey: "name" as NSCopying)
                dicInfo.setObject("profilePic", forKey: "fileName" as NSCopying)
                dicInfo.setObject("image/jpeg", forKey: "type" as NSCopying)
                arrToSend.add(dicInfo)
                
                imageData = nil
                dicInfo = nil
            }
            
            BaseAPICall.shared.uploadImage(url: APIConstant.createProfile, Parameter: dictParameter, Images: arrToSend, Type: APITask.CreateProfile, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                arrToSend = nil
                
                switch result{
                case .Success(let object, let error):
                   
                    AppUtility.getAppDelegate().window!.makeToast(error!.alertMessage)
                    let people : People = object as! People
                    AppUtility.setUserDefaultsObject(people.profilePicUrl as AnyObject, forKey: UserDefaultKey.KProfilePic)
                    
                    if let controller : BasicDetailViewController = self!.getViewControllerFromSubView() as? BasicDetailViewController {
                        controller.navigationController?.pushViewController(SelectHomeCourtController(isBackButton: false), animated: true)
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

extension BasicDetailView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if textField == txtNickName || textField == txtHomeTown {
            var oldlength : Int = 0
            
            if textField.text != nil {
                oldlength = (textField.text?.characters.count)! + textField.text!.countEmojiCharacter()
            }
            
            let replaceMentLength : Int = string .characters.count
            let rangeLength : Int = range.length
            let newLength : Int = oldlength - rangeLength + replaceMentLength
            return newLength <= 50 || false
        }
        else if textField == txtSchool {
            var oldlength : Int = 0
            
            if textField.text != nil {
                oldlength = (textField.text?.characters.count)! + textField.text!.countEmojiCharacter()
            }
            
            let replaceMentLength : Int = string .characters.count
            let rangeLength : Int = range.length
            let newLength : Int = oldlength - rangeLength + replaceMentLength
            return newLength <= 150 || false
        }
        else if textField == txtPhoneNo {
            var oldlength : Int = 0
            
            if textField.text != nil {
                oldlength = (textField.text?.characters.count)! + textField.text!.countEmojiCharacter()
            }
            
            let replaceMentLength : Int = string .characters.count
            let rangeLength : Int = range.length
            let newLength : Int = oldlength - rangeLength + replaceMentLength
            return newLength <= 15 || false
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtPhoneNo {
            if let trimmedString : String = self.txtPhoneNo.text?.trimmed(), trimmedString == "" {
                txtPhoneNo.errorMessage = ""
                self.txtPhoneNo.text = ""
            }
            else if let mobile : String = self.txtPhoneNo.text, AppUtility.isValidPhone(mobile) {
                txtPhoneNo.errorMessage = ""
            }
            else {
                txtPhoneNo.errorMessage = "Invalid Phone Number"
            }
        }
        else if textField == txtHeight {
            if let trimmedString : String = self.txtHeight.text?.trimmed(), trimmedString == "" {
                self.txtHeight.errorMessage = ""
                self.txtHeight.text = ""
            }
            else if let height : String = self.txtHeight.text, AppUtility.isValiedHeight(height) {
                let arr = height.components(separatedBy: ".")
                if arr.count > 1 {
                    if Int(arr[1])! > 11 {
                        self.txtHeight.errorMessage = "Check the inch and feet values"
                    }
                    else {
                        self.txtHeight.errorMessage = ""
                    }
                }
                else {
                    self.txtHeight.errorMessage = ""
                }
            }
            else {
                self.txtHeight.errorMessage = "Check the inch and feet values"
            }
        }
        else if textField == txtVertical {
            if let trimmedString : String = self.txtVertical.text?.trimmed(), trimmedString == "" {
                self.txtVertical.errorMessage = ""
                self.txtVertical.text = ""
            }
            else if let vertical : String = self.txtVertical.text, AppUtility.isValiedVirtical(vertical) {
                self.txtVertical.errorMessage = ""
            }
            else {
                self.txtVertical.errorMessage = "Check the inches values"
            }
        }
        else if textField == txtWeight {
            if let trimmedString : String = self.txtWeight.text?.trimmed(), trimmedString == "" {
                self.txtWeight.errorMessage = ""
                self.txtWeight.text = ""
            }
            else if let weight : String = self.txtWeight.text, AppUtility.isValiedWeight(weight) {
                self.txtWeight.errorMessage = ""
            }
            else {
                self.txtWeight.errorMessage = "Invalid Weight"
            }
        }
        return true
    }
    
}



// MARK: - UIImagePickerControllerDelegate delegate
extension BasicDetailView : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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


extension BasicDetailView : BaseAlertViewDelegate {
    func didTappedOkButton(_ alertView: BaseAlertController) {
        if self.alertController != nil {
            self.alertController = nil
            self.popUp = nil
            
            let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString) as! URL
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }
    }
}
