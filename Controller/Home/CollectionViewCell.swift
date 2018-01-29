//
//  CollectionViewCell.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 04/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Attributes -
    var layout : AppBaseLayout!
    
    var imgPhoto : BaseImageView!
    var footerView : UIView!
    var lblName : BaseLabel!
    var lblHour : BaseLabel!
    
    
    // MARK: - Life Cycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewControls()
        self.setViewControlsLayout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
    }
    
    deinit {
        print("CollectionViewCell deinit called")
        
        if lblName != nil && lblName.superview != nil {
            lblName.removeFromSuperview()
            lblName = nil
        }
        if imgPhoto != nil && imgPhoto.superview != nil {
            imgPhoto.removeFromSuperview()
            imgPhoto = nil
        }
       
        if lblHour != nil && lblHour.superview != nil {
            lblHour.removeFromSuperview()
            lblHour = nil
        }
        
        if footerView != nil && footerView.superview != nil {
            footerView.removeFromSuperview()
            footerView = nil
        }
        
        layout = nil
    }
    
    func loadViewControls() {
        self.contentView.backgroundColor = .clear
        self.contentView.clipsToBounds = true
        self.backgroundColor = Color.appPrimaryBG.value
        self.clipsToBounds = true
        
        imgPhoto = BaseImageView(type: .defaultImg, superView: self.contentView)
        
        footerView = UIView(frame: .zero)
        footerView.backgroundColor = Color.appSecondaryBG.withAlpha(0.7)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(footerView)
        
        lblName = BaseLabel(labelType: .medium, superView: footerView)
        lblName.textColor = Color.appPrimaryBG.value
        lblName.numberOfLines = 1
        lblName.textAlignment = .left
        
        lblHour = BaseLabel(labelType: .medium, superView: footerView)
        lblHour.numberOfLines = 1
        lblHour.textColor = Color.appPrimaryBG.value
        lblHour.textAlignment = .left
    }
    
    
    func setViewControlsLayout() {
        
        layout = AppBaseLayout()
        
        layout.viewDictionary = ["imgPhoto" : imgPhoto,
                                 "footerView" : footerView,
                                 "lblName" : lblName,
                                 "lblHour" : lblHour]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let verticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVerticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        
        layout.metrics = ["horizontalPadding" : horizontalPadding,
                          "verticalPadding" : verticalPadding,
                          "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                          "secondaryVerticalPadding" : secondaryVerticalPadding]
        //imagPhoto
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imgPhoto]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_H)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[imgPhoto]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_V)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[footerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_V)
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[footerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_H)
        
        
        //lblName
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[lblName]-4-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.footerView.addConstraints(layout.control_H)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[lblName][lblHour]|", options: [.alignAllLeading, .alignAllTrailing], metrics: layout.metrics, views: layout.viewDictionary)
        self.footerView.addConstraints(layout.control_V)
        
        self.layout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
        
        
    }
    
    func setValue(sedule : Schedule) {
        self.imgPhoto.displayImageFromURL(sedule.user.profilePicUrl)
        lblName.text = sedule.user.firstName
        lblHour.text = (Int(Double(sedule.duration)!) / 3600) > 1 ? "\(Int(Double(sedule.duration)!) / 3600) Hours" : "\(Int(Double(sedule.duration)!) / 3600) Hour"
    }
    
}
