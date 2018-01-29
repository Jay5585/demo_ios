//
//  BaseTextField.swift
//  ViewControllerDemo
//
//  Created by SamSol on 01/07/16.
//  Copyright © 2016 SamSol. All rights reserved.
//

import UIKit

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}



enum ResponderDirectionType : Int {
    
    case leftResponderDirectionType = 1
    case rightResponderDirectionType = 2
    
}

enum BaseTextFieldType : Int {
    
    case basePrimaryTextFieldType = 0
    case baseNoAutoScrollType
    case baseShowPasswordType
    case baseNoClearButtonTextFieldType
    case basePaddingTextField
}

class BaseTextField: SkyFloatingLabelTextFieldWithIcon, UITextFieldDelegate {
    
    
    // MARK: - Attributes -
    
    var leftArrowButton : BaseBarButtonItem!
    var rightArrowButton : BaseBarButtonItem!
    
    var copyButton : BaseBarButtonItem!
    var pasteButton : BaseBarButtonItem!
    
    var inputAccessory : UIView!
    var layout : AppBaseLayout!
    var charaterLimit : Int = 9999
    
    var baseTextFieldType : BaseTextFieldType = BaseTextFieldType.basePrimaryTextFieldType
    
    var imgLeftIcon : BaseButton!
    fileprivate let leftIconHeight : CGFloat = 30.0
    
    // MARK: - Lifecycle -
    init(iSuperView: UIView?) {
        super.init(frame: CGRect.zero)
        
        self.setCommonProperties()
        self.setLayout()
        
        if(iSuperView != nil){
            iSuperView!.addSubview(self)
        }
    }
    
    init(iSuperView : UIView? , TextFieldType baseType : BaseTextFieldType) {
        super.init(frame : CGRect.zero)
        
        baseTextFieldType = baseType
        
        self.setCommonProperties()
        self.setLayout()
        
        if iSuperView != nil
        {
            iSuperView?.addSubview(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    let padding = UIEdgeInsets(top: 0, left: 43, bottom: 0, right: 28);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var customBounds : CGRect!
        switch baseTextFieldType {
        case .baseShowPasswordType :
            customBounds = CGRect(x: leftIconHeight, y: bounds.origin.y, width: bounds.size.width - 55, height: bounds.size.height)
            break
            
        case .baseNoClearButtonTextFieldType:
            customBounds = CGRect(x: leftIconHeight, y: bounds.origin.y, width : bounds.size.width - 55 ,height: bounds.size.height)
            break
            
        default:
            customBounds = CGRect(x : leftIconHeight, y:  bounds.origin.y, width : bounds.size.width - 55, height: bounds.size.height)
            break
        }
        return customBounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var customBounds : CGRect!
        
        switch baseTextFieldType {
        case .baseShowPasswordType :
            customBounds = CGRect(x: leftIconHeight, y: bounds.origin.y,width:  bounds.size.width - 55, height:  bounds.size.height)
            break
            
        case .baseNoClearButtonTextFieldType:
            customBounds = CGRect(x: leftIconHeight, y: bounds.origin.y,width:  bounds.size.width - 50 , height:  bounds.size.height)
            break
            
        default:
            customBounds = CGRect(x: leftIconHeight, y: bounds.origin.y,width:  bounds.size.width - 55, height:  bounds.size.height)
            break
        }
        return customBounds!
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if baseTextFieldType == BaseTextFieldType.basePaddingTextField {
            return UIEdgeInsetsInsetRect(bounds, padding)
        }
        else if baseTextFieldType == BaseTextFieldType.baseShowPasswordType {
            return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width - 4.8 * ControlLayout.KTextLeftPaddingFromControl , height: bounds.size.height)
        }
        else {
            return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width - 2.8 * ControlLayout.KTextLeftPaddingFromControl, height: bounds.size.height)
        }
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        
        if(self.placeholder!.responds(to: #selector(NSString.draw(at:withAttributes:)))) {
            
            var attributes : [String : AnyObject]! = [NSForegroundColorAttributeName : Color.textFieldPlaceholder.withAlpha(0.45),
                                                      NSFontAttributeName : self.font!]
            
            var boundingRect : CGRect! = self.placeholder!.boundingRect(with: rect.size, options: NSStringDrawingOptions(rawValue: 0), attributes: attributes, context: nil)
            
            switch baseTextFieldType
            {
            case .baseNoClearButtonTextFieldType:
                self.placeholder!.draw(at: CGPoint(x: leftIconHeight, y: (rect.size.height / 2) - boundingRect.size.height / 2), withAttributes: attributes)
                break
            default:
                self.placeholder!.draw(at: CGPoint(x: leftIconHeight, y: (rect.size.height/2) - boundingRect.size.height/2), withAttributes: attributes)
                break
            }
            attributes.removeAll()
            attributes = nil
            boundingRect = nil
        }
    }
    
    override func lineViewRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        let lineHeight : CGFloat = editing ? CGFloat(self.selectedLineHeight) : CGFloat(self.lineHeight)
        return CGRect(x: 0, y: (bounds.size.height - lineHeight) - 6, width: bounds.size.width, height: lineHeight);
    }
    
    override var text: String?{
        didSet{
            self.displayClearButton()
        }
    }
    
    deinit{
        
        leftArrowButton = nil
        rightArrowButton = nil
        
        copyButton = nil
        pasteButton = nil
        
        layout = nil
    }
    
    // MARK: - Layout -
    
    func setCommonProperties()
    {
        switch baseTextFieldType
        {
        case .baseNoAutoScrollType:
            self.setShowToolbar(false)
            self.clearButtonMode = .whileEditing
            self.textAlignment = .left
            self.delegate = self
            
            break
        case .basePrimaryTextFieldType:
            self.clearButtonMode = .whileEditing
            self.returnKeyType = .default
            self.setShowToolbar(true)
            self.delegate = self
            self.textAlignment = .left
            break
        case .baseShowPasswordType :
            self.isSecureTextEntry = true
            self.returnKeyType = .default
            self.clearButtonMode = .never
            self.setShowToolbar(false)
            self.delegate = self
            self.textAlignment = .left
            break
        case .baseNoClearButtonTextFieldType :
            self.clearButtonMode = .never
            self.setShowToolbar(false)
            self.delegate = self
            self.textAlignment = .left
            break
            
        case .basePaddingTextField :
            self.setShowToolbar(false)
            self.textAlignment = .left
            self.clearButtonMode = .never
            self.delegate = self
            break
            
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.keyboardAppearance = .dark
        
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        
        
        self.backgroundColor = Color.textFieldBG.value
        self.tintColor = Color.textFieldText.value
        self.textColor = Color.textFieldText.value
        self.placeholderColor = Color.textFieldPlaceholder.value
        
        self.titleColor = Color.textFieldBorder.value
        self.selectedTitleColor = Color.textFieldSelectedBorder.value
        
        self.lineColor = Color.textFieldBorder.value
        self.selectedLineColor = Color.textFieldSelectedBorder.value
        
        
        self.errorColor = Color.textFieldErrorBorder.value
        
        self.font = UIFont(name: FontStyle.medium, size: 13.0)
        
        //Left icon
        
        imgLeftIcon = BaseButton(ibuttonType: .transparent, iSuperView: self)
        imgLeftIcon.isUserInteractionEnabled = false
        imgLeftIcon.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        imgLeftIcon.backgroundColor = .clear
        
        self.leftViewMode = .always
        self.leftView = imgLeftIcon
        
    }
    
    func setLayout(){
        
        layout = AppBaseLayout()
        layout.viewDictionary = ["textField" : self]
        
        let textFieldHeight : CGFloat =  ControlLayout.textFieldHeight
        let textFieldWidth : CGFloat = 50.0
        
        layout.metrics = ["textFieldHeight" : textFieldHeight , "textFieldWidth" : textFieldWidth]
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[textField(textFieldHeight)]", options:NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        
        self.addConstraints(layout.control_V)
        
        imgLeftIcon.heightAnchor.constraint(equalToConstant: leftIconHeight).isActive = true
        imgLeftIcon.widthAnchor.constraint(equalTo: imgLeftIcon.heightAnchor).isActive = true
        
        
        switch baseTextFieldType
        {
        case .baseShowPasswordType:
            
            var btnShowPassword : UIButton! = UIButton(type: UIButtonType.custom)
            btnShowPassword.translatesAutoresizingMaskIntoConstraints = false
            btnShowPassword.backgroundColor = .clear
            btnShowPassword .setImage(UIImage(named: "showPassword"), for: UIControlState.normal)
            btnShowPassword .setImage(UIImage(named: "HidePassword"), for: UIControlState.selected)
            btnShowPassword.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            
            btnShowPassword .addTarget(self, action: #selector(self.btnShowPassword(_:)), for: .touchUpInside)
            btnShowPassword .isSelected = true
            self.addSubview(btnShowPassword)
            
            btnShowPassword.heightAnchor.constraint(equalToConstant: leftIconHeight).isActive = true
            btnShowPassword.widthAnchor.constraint(equalTo: btnShowPassword.heightAnchor).isActive = true
            self.rightViewMode = .always
            self.rightView = btnShowPassword
            
            btnShowPassword = nil
            
            break
            
        default:
            break
        }
    }
    
    // MARK: - Public Interface -
    
    func setErrorBorder(){
        self.setBorder(Color.textFieldErrorBorder.withAlpha(0.6), width: ControlLayout.txtBorderWidth, radius: ControlLayout.txtBorderRadius)
    }
    func clearErrorBorder(){
        self.setBorder(Color.textFieldErrorBorder.withAlpha(0.6), width: ControlLayout.txtBorderWidth, radius: ControlLayout.txtBorderRadius)
    }
    func resetScrollView(){
        
        AppUtility.executeTaskInGlobalQueueWithCompletion{ [weak self] in
            
            if self == nil{
                return
            }
            
            var scrollView : UIScrollView? = self!.getScrollViewFromView(self)
            
            if(scrollView != nil){
                
                AppUtility.executeTaskInMainQueueWithCompletion{ [weak self] in
                    if self == nil{
                        return
                    }
                    
                    scrollView?.setContentOffset(CGPoint.zero, animated: true)
                    
                    self!.displayClearButton()
                    scrollView = nil
                }
            }
        }
    }
    
    func setShowToolbar(_ visible : Bool){
        
        if(visible){
            
            let fixedSpace : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixedSpace.width = 5.0
            
            leftArrowButton = BaseBarButtonItem(itemType: .left)
            leftArrowButton.setTarget(self, action: #selector(leftArrowButtonAction))
            
            rightArrowButton = BaseBarButtonItem(itemType: .right)
            rightArrowButton.setTarget(self, action: #selector(rightArrowButtonAction))
            
            /*
             copyButton = BaseBarButtonItem(itemType: .BaseBarCopyButtonItemType)
             copyButton.setTarget(self, action: #selector(copyButtonAction))
             
             pasteButton = BaseBarButtonItem(itemType: .BaseBarPasteButtonItemType)
             pasteButton.setTarget(self, action: #selector(pasteButtonAction))
             
             self.addTarget(self, action: #selector(setCopyPasteEnabled), forControlEvents: .EditingChanged)
             */
            
            let doneButton : BaseBarButtonItem = BaseBarButtonItem(itemType: .done)
            doneButton.setTarget(self, action: #selector(doneButtonAction))
            
            let flexibleSpace : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            leftArrowButton.isEnabled = false
            rightArrowButton.isEnabled = false
            
            setCopyPasteEnabled()
            
            let numberToolbar : UIToolbar = UIToolbar()
            numberToolbar.barStyle = .black
            numberToolbar.isTranslucent = false
            
            numberToolbar.barTintColor = Color.appPrimaryBG.value
            numberToolbar.tintAdjustmentMode = .normal
            numberToolbar.items = [leftArrowButton, fixedSpace, rightArrowButton, flexibleSpace, doneButton]
            
            numberToolbar.sizeToFit()
            self.inputAccessoryView = numberToolbar
            
            numberToolbar.setTopBorder(Color.textFieldBorder.withAlpha(General.textFieldColorAlpha), width: 1.0)
            numberToolbar.setBottomBorder(Color.textFieldBorder.withAlpha(General.textFieldColorAlpha), width: 1.0)
            
        }else{
            self.inputAccessoryView = nil
        }
        
    }
    
    func setDoneToolbar(_ visible : Bool){
        
        if(visible){
            
            let flexibleSpace : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            let doneButton : BaseBarButtonItem = BaseBarButtonItem(itemType: .done)
            doneButton.setTarget(self, action: #selector(doneButtonAction))
            
            leftArrowButton.isEnabled = false
            rightArrowButton.isEnabled = false
            
            let numberToolbar : UIToolbar = UIToolbar()
            
            numberToolbar.barStyle = .black
            numberToolbar.isTranslucent = false
            
            numberToolbar.barTintColor = Color.appPrimaryBG.value
            
            numberToolbar.tintAdjustmentMode = .normal
            numberToolbar.items = [flexibleSpace, doneButton]
            
            numberToolbar.sizeToFit()
            self.inputAccessoryView = numberToolbar
            
            numberToolbar.setTopBorder(Color.textFieldBorder.withAlpha(General.textFieldColorAlpha), width: 1.0)
            
            numberToolbar.setBottomBorder(Color.textFieldBorder.withAlpha(General.textFieldColorAlpha), width: 1.0)
            
        }else{
            self.inputAccessoryView = nil
            
        }
        
    }
    
    // MARK: - User Interaction -
    
    func setLeftIcon(icon : UIImage?) {
        self.imgLeftIcon.setImage(icon, for: .normal)
    }
    
    func leftArrowButtonAction(){
        self.setResponderToTextControl(.leftResponderDirectionType)
    }
    
    func rightArrowButtonAction(){
        self.setResponderToTextControl(.rightResponderDirectionType)
    }
    
    func copyButtonAction(){
        
        if(self.hasText){
            UIPasteboard.general.string = self.text
        }
    }
    
    func pasteButtonAction(){
        if let string = UIPasteboard.general.string {
            self.insertText(string)
        }
    }
    
    func doneButtonAction(){
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            self!.resignFirstResponder()
        }
        
        self.resetScrollView()
    }
    
    // MARK: - Internal Helpers -
    /**
     Method for Show and Hide the Password Of TextField
     */
    func btnShowPassword(_ sender : UIButton) -> Void
    {
        self.isSecureTextEntry = !self.isSecureTextEntry
        self.text = self.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        let button : UIButton = sender
        button.isSelected = self.isSecureTextEntry
    }
    
    func setCopyPasteEnabled(){
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            
            if(self!.pasteButton != nil){
                self!.pasteButton.isEnabled = (UIPasteboard.general.string?.characters.count > 0)
            }
            
        }
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            
            if(self!.copyButton != nil){
                self!.copyButton.isEnabled = self!.hasText
            }
        }
    }
    
    func setScrollViewContentOffsetForView(_ view : UIView){
        
        AppUtility.executeTaskInGlobalQueueWithCompletion{ [weak self] in
            
            if self == nil{
                return
            }
            
            var scrollView : UIScrollView? = self!.getScrollViewFromView(self)
            
            if(scrollView != nil){
                
                AppUtility.executeTaskInMainQueueWithCompletion{ [weak self] in
                    
                    if self == nil{
                        return
                    }
                    
                    scrollView?.setContentOffset(CGPoint(x: 0.0, y: view.frame.origin.y-20), animated: true)
                    self!.displayClearButton()
                    scrollView = nil
                }
            }
        }
    }
    
    func getScrollViewFromView(_ view : UIView?) -> UIScrollView?{
        
        var scrollView : UIScrollView? = nil
        var view : UIView? = view!.superview!
        
        while (view != nil) {
            
            if(view!.isKind(of: UIScrollView.self)){
                scrollView = view as? UIScrollView
                break
            }
            
            if(view!.superview != nil){
                view = view!.superview!
                
            }else{
                view = nil
            }
        }
        return scrollView
    }
    
    func setResponderToTextControl(_ iDirectionType : ResponderDirectionType){
        if(self.superview != nil && self.isEnabled){
            AppUtility.executeTaskInGlobalQueueWithCompletion{ [weak self] in
                
                if self == nil{
                    return
                }
                
                var subViewArray : Array = (self!.superview?.subviews)!
                let subViewArrayCount : Int = subViewArray.count
                
                var isNextTextControlAvailable : Bool = false
                let currentTextFieldIndex : Int = subViewArray.index(of: self!)!
                
                var textField : UITextField?
                var textView : UITextView?
                
                var view : UIView?
                
                let operatorSign = (iDirectionType == .leftResponderDirectionType) ? -1 : 1
                var i = currentTextFieldIndex + operatorSign
                
                while(i >= 0 && i < subViewArrayCount){
                    
                    view = subViewArray[i]
                    isNextTextControlAvailable = view!.isKind(of: UITextField.self) || view!.isKind(of: UITextView.self)
                    
                    if(isNextTextControlAvailable){
                        
                        if(view!.isKind(of: UITextField.self)){
                            
                            textField = view as? UITextField
                            if(textField!.isEnabled && textField!.delegate != nil){
                                
                                AppUtility.executeTaskInMainQueueWithCompletion({ [weak self] in
                                    
                                    if self == nil{
                                        return
                                    }
                                    
                                    textField?.becomeFirstResponder()
                                })
                                
                                break
                            }else{
                                isNextTextControlAvailable = false
                            }
                            
                        }else if(view!.isKind(of: UITextView.self)){
                            
                            textView = view as? UITextView
                            if(textView!.isEditable && textView!.delegate != nil){
                                
                                AppUtility.executeTaskInMainQueueWithCompletion({ [weak self] in
                                    
                                    if self == nil{
                                        return
                                    }
                                    
                                    textView?.becomeFirstResponder()
                                })
                                
                                break
                                
                            }else{
                                isNextTextControlAvailable = false
                            }
                        }
                        
                    }
                    
                    i = i + operatorSign
                }
                
                if(isNextTextControlAvailable && view != nil){
                    self!.setScrollViewContentOffsetForView(view!)
                }
            }
        }
    }
    
    func displayClearButton(){
        AppUtility.executeTaskInMainQueueWithCompletion{ [weak self] in
            
            if self == nil{
                return
            }
            
            if self!.baseTextFieldType != BaseTextFieldType.baseShowPasswordType && self!.baseTextFieldType != .baseNoClearButtonTextFieldType && self!.baseTextFieldType != .basePaddingTextField
            {
                if self!.hasText{
                    self!.clearButtonMode = .always
                }else{
                    self!.clearButtonMode = .whileEditing
                }
            }
        }
    }
    
    // MARK: - UITextField Delegate Methods -
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        
        self.setCopyPasteEnabled()
        
        //self.setScrollViewContentOffsetForView(self)
        AppUtility.executeTaskInGlobalQueueWithCompletion { [weak self] in
            
            if self == nil{
                return
            }
            
            var scrollView : UIScrollView? = self!.getScrollViewFromView(self)
            
            if(scrollView != nil){
                
                AppUtility.executeTaskInMainQueueWithCompletion{ [weak self] in
                    
                    if self == nil{
                        return
                    }
                    scrollView?.isScrollEnabled = false
                    scrollView = nil
                }
            }
            
            self!.displayClearButton()
            
            if(self!.superview != nil){
                
                if(self!.leftArrowButton != nil){
                    
                    AppUtility.executeTaskInMainQueueWithCompletion{ [weak self] in
                        
                        if self == nil{
                            return
                        }
                        
                        let isEnabled : Bool = !BaseView.isFirstTextControlInSuperview(self!.superview, textControl: self!)
                        self!.leftArrowButton.isEnabled = isEnabled
                    }
                }
                
                if(self!.rightArrowButton != nil){
                    
                    AppUtility.executeTaskInMainQueueWithCompletion{ [weak self] in
                        
                        if self == nil{
                            return
                        }
                        
                        let isEnabled : Bool = !BaseView.isLastTextControlInSuperview(self!.superview, textControl: self!)
                        self!.rightArrowButton.isEnabled = isEnabled
                    }
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
        self.setCopyPasteEnabled()
        
        AppUtility.executeTaskInGlobalQueueWithCompletion { [weak self] in
            
            if self == nil{
                return
            }
            
            var scrollView : UIScrollView? = self!.getScrollViewFromView(self!)
            
            if(scrollView != nil){
                
                AppUtility.executeTaskInMainQueueWithCompletion({ [weak self] in
                    
                    if self == nil{
                        return
                    }
                    
                    scrollView!.isScrollEnabled = true
                    scrollView = nil
                })
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            
            if self == nil{
                return
            }
            textField.resignFirstResponder()
            //self.resetScrollView()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
       
        var oldlength : Int = 0
        if textField.text != nil {
            oldlength = (textField.text?.characters.count)! + textField.text!.countEmojiCharacter()
        }
        
        let replaceMentLength : Int = string .characters.count
        let rangeLength : Int = range.length
        
        let newLength : Int = oldlength - rangeLength + replaceMentLength
        
        return newLength <= charaterLimit || false
    }
    
}

