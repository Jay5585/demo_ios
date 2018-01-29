//
//  BaseAlertController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 10/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

protocol BaseAlertViewDelegate {
    func didTappedOkButton(_ alertView : BaseAlertController)
}

class BaseAlertController: BaseViewController {

    // Mark: - Attributes -
    var baseAlertView : BaseAlertView!
    var delegate: BaseAlertViewDelegate?
    var index : Int = 0
    
    // MARK: - Lifecycle -
    
    init(iTitle : String, iMassage massage : String, iButtonTitle buttonTitle : String, index ind : Int) {
        baseAlertView = BaseAlertView(iTitle: iTitle, alertMassage: massage, alertButton: buttonTitle)
        super.init(iView: baseAlertView)
        
        self.index = ind
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("BaseAlertController deinit called")
        if baseAlertView != nil && baseAlertView.superview != nil {
            baseAlertView.removeFromSuperview()
            baseAlertView = nil
        }
        delegate = nil
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        baseAlertView.container.layoutIfNeeded()
        baseAlertView.container.layoutSubviews()
        
        self.contentSizeInPopup = baseAlertView.container.frame.size
        self.contentSizeInPopup.width = AppUtility.getAppDelegate().window!.frame.size.width - 30
        self.loadViewIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
        self.contentSizeInPopup = baseAlertView.container.frame.size
        self.contentSizeInPopup.width = self.view.frame.size.width - 30
        self.loadViewIfNeeded()
        
        self.baseAlertView.btnClose.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            self!.popupController?.dismiss()
        }
        
        self.baseAlertView.btnOk.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            self!.dismiss(animated: true, completion: nil)
            self!.delegate?.didTappedOkButton(self!)
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
        baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -

}
