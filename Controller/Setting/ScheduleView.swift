//
//  ScheduleView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 13/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class ScheduleView: UIView {
    
    // Mark: - Attributes -
    var tblSchedule : UITableView!
    var lblError : BaseLabel!
    
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("ScheduleView deinit called")
        self.releaseObject()
    }
    
    func releaseObject() {
        if tblSchedule != nil && tblSchedule.superview != nil {
            tblSchedule.removeFromSuperview()
            tblSchedule = nil
        }
    }
    
    
    // MARK: - Layout -
    
    func loadViewControls() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        tblSchedule = UITableView(frame: .zero)
        tblSchedule.translatesAutoresizingMaskIntoConstraints = false
        tblSchedule.backgroundColor = UIColor.clear
        tblSchedule.separatorStyle = UITableViewCellSeparatorStyle.none
        tblSchedule.rowHeight = UITableViewAutomaticDimension
        self.addSubview(tblSchedule)
        tblSchedule.register(ScheduleTableCell.self, forCellReuseIdentifier: CellIdentifire.detailCell)
        
        lblError = BaseLabel(labelType: .large, superView: self)
        lblError.text = "⚠️ no today schedule"
        lblError.numberOfLines = 0
    }
    
    func setViewlayout() {
        let baseLayout : AppBaseLayout = AppBaseLayout()
        baseLayout.expandView(tblSchedule, insideView: self)

        lblError.leadingAnchor.constraint(equalTo: tblSchedule.leadingAnchor, constant: 8).isActive = true
        lblError.trailingAnchor.constraint(equalTo: tblSchedule.trailingAnchor, constant: -8).isActive = true
        lblError.centerYAnchor.constraint(equalTo: tblSchedule.centerYAnchor).isActive = true
        lblError.centerXAnchor.constraint(equalTo: tblSchedule.centerXAnchor).isActive = true
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
}

