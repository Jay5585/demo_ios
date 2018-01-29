//
//  TimePickerPopUpController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 05/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

protocol TimePickerDelegate {
    func didTappedOkButton(_ selected : Date)
}

class TimePickerPopUpController: BaseViewController {
    
    // Mark: - Attributes -
    var timePickerPopUpView : TimePickerPopUpView!
    var delegate: TimePickerDelegate?

    
    // MARK: - Lifecycle -
    
    override init() {
        timePickerPopUpView = TimePickerPopUpView(frame: .zero)
        super.init(iView: timePickerPopUpView, andNavigationTitle: "")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("TimePickerPopUpController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if timePickerPopUpView != nil && timePickerPopUpView.superview != nil {
            timePickerPopUpView.removeFromSuperview()
            timePickerPopUpView = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
        self.contentSizeInPopup = timePickerPopUpView.container.frame.size
        self.contentSizeInPopup.width = self.view.frame.size.width - 30
        
        self.timePickerPopUpView.btnClose.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            
            self!.popupController?.dismiss()
        }
        
        self.timePickerPopUpView.btnSubmit.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            
            self!.delegate?.didTappedOkButton(self!.timePickerPopUpView.pickerView.date)
            self!.popupController?.dismiss()
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
        self.baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    
    
}
