//
//  RateUserController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 15/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class RateUserController: BaseViewController {
    // Mark: - Attributes -
    var rateUserView : RateUserView!
    
    // MARK: - Lifecycle -
    
    init(ratting : IndividualRating, userId : String) {
        rateUserView = RateUserView(ratting: ratting, userId : userId)
        super.init(iView: rateUserView, andNavigationTitle: "Rate User")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("RateUserController deinit called")
        if rateUserView != nil && rateUserView.superview != nil {
           rateUserView.removeFromSuperview()
            rateUserView = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
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
