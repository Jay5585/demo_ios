//
//  MoreMenuViewController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 11/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

enum PopUpMenuType : Int {
    case loginUser = 0
    case otherUser = 1
}

class MoreMenuViewController: UITableViewController {

    init(iPopUpMenuType : PopUpMenuType) {
        super.init(style: .plain)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.bounces = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
