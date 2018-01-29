//
//  PaymentView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 30/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import Stripe
import SwiftEventBus

class PaymentView: BaseView {
    // Mark: - Attributes -
    
    var scrollView : BaseScrollView!
    var containerView : UIView!
    
    var lblTitle : BaseLabel!
    
    private var txtNumber : STPPaymentCardTextField!
    
    var btnPay : BaseButton!
    
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
        print("PaymentView deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if lblTitle != nil && lblTitle.superview != nil{
            lblTitle.removeFromSuperview()
            lblTitle = nil
        }
        
        
        
        if txtNumber != nil && txtNumber.superview != nil{
            txtNumber.removeFromSuperview()
            txtNumber = nil
        }
        if btnPay != nil && btnPay.superview != nil{
            btnPay.removeFromSuperview()
            btnPay = nil
        }

        
        if containerView != nil && containerView.superview != nil{
            containerView.removeFromSuperview()
            containerView = nil
        }
        
        if scrollView != nil && scrollView.superview != nil{
            scrollView.removeFromSuperview()
            scrollView = nil
        }
        
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        scrollView = BaseScrollView(scrollType: .vertical, superView: self)
        containerView = scrollView.container
        
        lblTitle = BaseLabel(labelType: .large, superView: containerView)
        lblTitle.numberOfLines = 0
        lblTitle.text = "Stats are available in Baller Pro, which is a one time purchase of $1.99"
        
        txtNumber = STPPaymentCardTextField()
        txtNumber.backgroundColor = Color.textFieldBG.value
        txtNumber.tintColor = Color.textFieldText.value
        txtNumber.textColor = Color.textFieldText.value
        txtNumber.placeholderColor = Color.textFieldPlaceholder.value
        
        txtNumber.font = UIFont(name: FontStyle.medium, size: 13.0)
        
        txtNumber.layer.borderWidth = 0.0
        txtNumber.cornerRadius = 0.0
        
        txtNumber.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(txtNumber)
        
        
        btnPay = BaseButton(ibuttonType: .primary, iSuperView: containerView)
        btnPay.setTitle("Upgrade Now", for: .normal)
        
        btnPay.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            self!.endEditing(true)
            self!.validateAndSaveCard()
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["scrollView" : scrollView,
                                     "containerView" : containerView,
                                     "lblTitle" : lblTitle,
                                     "txtNumber" : txtNumber,
                                     "btnPay" : btnPay]
        
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
        
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[lblTitle]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_H)
        
        txtNumber.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
        
        btnPay.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-turneryVerticalPadding-[lblTitle]-secondaryVirticalPadding-[txtNumber(35)]-turneryVerticalPadding-[btnPay]-turneryVerticalPadding-|", options: [.alignAllCenterX], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_V)
        
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    private func validateAndSaveCard() {
        
        if txtNumber.isValid {
            self.saveCard()
        }
        else {
            self.makeToast("Invalid Card Data")
        }
    }
    
    private func saveCard() {
        let stripeCard : STPCardParams = STPCardParams()
        
        stripeCard.name = txtNumber.cardParams.name
        stripeCard.number = txtNumber.cardNumber
        stripeCard.expMonth = txtNumber.expirationMonth
        stripeCard.expYear = txtNumber.expirationYear
        stripeCard.cvc = txtNumber.cvc
        
        self.showProgressHUD(viewController: AppUtility.getAppDelegate().window!, title: nil, subtitle: "Verify Card...")
        STPAPIClient.shared().createToken(withCard: stripeCard) { [weak self] (token, error) in
            if self == nil{
                return
            }
            
            if error == nil {
                self!.hideProgressHUD()
                self!.addUserCardRequest(token: token!)
            }
            else {
                self!.hideProgressHUD()
                self!.makeToast(error?.localizedDescription != nil ? (error?.localizedDescription)! : "Unable to process")
            }
        }
    }
    
    
    // MARK: - Server Request -
    private func addUserCardRequest(token : STPToken) {
        
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
           
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KEmailId), forKey: "email")
            dictParameter.setValue(token, forKey: "tokenId")

        
            BaseAPICall.shared.postReques(URL: APIConstant.payment, Parameter: dictParameter, Type: APITask.Payment, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(_, let error):
                    self!.hideProgressHUD()
                    AppUtility.setUserDefaultsObject("1" as AnyObject, forKey: UserDefaultKey.KisPlayed)
                    self!.makeToast(error!.alertMessage, duration: ToastManager.shared.duration, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tap) in
                        if self == nil {
                            return
                        }
                        SwiftEventBus.post(NotificationKey.purchaseDone)
                        
                        if let controller : PaymentController = self!.getViewControllerFromSubView() as? PaymentController {
                            _ = controller.navigationController?.popViewController(animated: true)
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
}
