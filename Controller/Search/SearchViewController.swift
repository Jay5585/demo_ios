//
//  SearchViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup

class SearchViewController: BaseViewController {
    
    // Mark: - Attributes -
    
    var searchView : SearchView!
    var popUp : STPopupController!
    
    // MARK: - Lifecycle -
    
    override init() {
        searchView = SearchView(frame: .zero)
        super.init(iView: searchView, andNavigationTitle: "Search")
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchView.segmentView.setSegementSelectedAtIndex(0)
    }
    
    deinit {
        print("SearchViewController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if searchView != nil && searchView.superview != nil {
            searchView.removeFromSuperview()
            searchView = nil
        }
        popUp = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        self.displayMenuButton()
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
        baseLayout.releaseObject()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    
    // MARK: - Internal Helpers -
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        popUp.dismiss()
        popUp = nil
    }
    
    
    // MARK: - Server Request -
}
