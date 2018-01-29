//
//  AddHomeCourtController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 18/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

enum NavigationPopType : Int {
    case popOnDashBoard = 0
    case popToRoot = 1
    case popToPrevious = 2
}


class AddHomeCourtController: BaseViewController {

    // Mark: - Attributes -
    var addHomeCourtView : AddHomeCourtView!
    var navigationPopType : NavigationPopType!
    
    // MARK: - Lifecycle -
    
    init(navigationPopType : NavigationPopType) {
        self.navigationPopType = navigationPopType
        addHomeCourtView = AddHomeCourtView(frame: .zero)
        super.init(iView: addHomeCourtView, andNavigationTitle: "Add Home Court")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("AddHomeCourtController deinit called")
        
        if addHomeCourtView != nil && addHomeCourtView.superview != nil {
            addHomeCourtView.removeFromSuperview()
            addHomeCourtView = nil
        }
        navigationPopType = nil
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            InterfaceUtility.setCircleViewWith(Color.appSecondaryBG.value, width: 0.0, ofView: (self?.addHomeCourtView.imgProfile)!)
            InterfaceUtility.setCircleViewWith(Color.appSecondaryBG.value, width: 0.0, ofView: (self?.addHomeCourtView.btnEditImage)!)
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
