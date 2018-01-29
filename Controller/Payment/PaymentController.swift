//
//  PaymentController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 30/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class PaymentController: BaseViewController {
    // Mark: - Attributes -
    var paymentView : PaymentView!
    
    // MARK: - Lifecycle -
    
    override init() {
        paymentView = PaymentView(frame: .zero)
        super.init(iView: paymentView, andNavigationTitle: "Payment")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        
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
        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    
}
