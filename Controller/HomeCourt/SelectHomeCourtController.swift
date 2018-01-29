//
//  SelectHomeCourtController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 22/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup

class SelectHomeCourtController: BaseViewController {
   
   
    // Mark: - Attributes -
    var selectHomeCourtView : SelectHomeCourtView!
    var popUp : STPopupController!
    
    var isBackButton : Bool = false
    
    // MARK: - Lifecycle -
    
    init(isBackButton : Bool) {
        selectHomeCourtView = SelectHomeCourtView(isBackButton: isBackButton)
        super.init(iView: selectHomeCourtView, andNavigationTitle: "Home Court")
        
        self.isBackButton = isBackButton
        self.loadViewControls()
        self.setViewlayout()
    }
    
    override init() {
        selectHomeCourtView = SelectHomeCourtView(isBackButton: true)
        super.init(iView: selectHomeCourtView, andNavigationTitle: "Home")
        
        self.loadViewControls()
        self.displayMenuButton()
        self.setViewlayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(!isBackButton, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("SelectHomeCourtController denint called")
        if selectHomeCourtView != nil && selectHomeCourtView.superview != nil {
           selectHomeCourtView.removeFromSuperview()
           selectHomeCourtView = nil
        }
        popUp = nil
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
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        popUp.dismiss()
    }
    
    
    // MARK: - Server Request -
}
