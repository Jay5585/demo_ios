
//
//  CourtDetailController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 22/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit


protocol CourtDetailViewDelegate {
    func setAsHomeCourtdidTapped(_ courtDetail : Court)
    func SeeTheredidTapped(_ courtDetail : Court)
}

class CourtDetailController: BaseViewController {
    
    // Mark: - Attributes -
    
    var courtDetailView : CourtDetailView!
    var delegate: CourtDetailViewDelegate?
    
    // MARK: - Lifecycle -
    
    init(court : Court) {
        courtDetailView = CourtDetailView(court: court)
        super.init(iView: courtDetailView, andNavigationTitle: "")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("CourtDetailController deinit called")
        
        if courtDetailView != nil && courtDetailView.superview != nil {
            courtDetailView.removeFromSuperview()
            courtDetailView = nil
        }
        delegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
        self.contentSizeInPopup = courtDetailView.container.frame.size
        self.contentSizeInPopup.width = self.view.frame.size.width - 30
        self.loadViewIfNeeded()
        
        self.courtDetailView.btnClose.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            self!.popupController?.dismiss()
        }
        
        self.courtDetailView.btnSetAsHomeCourt.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            self!.popupController?.dismiss()
            self!.delegate?.setAsHomeCourtdidTapped(self!.courtDetailView.court)
        }
        
        self.courtDetailView.btnSeeThere.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            self!.popupController?.dismiss()
            self!.delegate?.SeeTheredidTapped(self!.courtDetailView.court)
        }
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
