//
//  CollectionView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 04/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup


class CollectionView: BaseView {
    // Mark: - Attributes -
    var collection : UICollectionView!
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
        print("CollectionView deinit called")
        self.releaseObject()
        
        if collection != nil && collection.superview != nil {
            collection.removeFromSuperview()
            collection = nil
        }
    }
    
    override func releaseObject() {
        super.releaseObject()
        
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        self.backgroundColor = .clear
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 10, height: 10)
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.alwaysBounceVertical = true
        collection.allowsMultipleSelection = false
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier : CellIdentifire.collectionViewCell)
        self.addSubview(collection)
        
        
        lblError = BaseLabel(labelType: .large, superView: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 7
        let attrString = NSMutableAttributedString(string: "⚠️ No current schedule available \nPull to refresh")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        lblError.attributedText = attrString
        lblError.numberOfLines = 0
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        baseLayout.viewDictionary = ["collection" : collection]
        
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryHorizontalPadding : CGFloat = ControlLayout.turneryHorizontalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        baseLayout.metrics = ["horizontalPadding" : horizontalPadding,
                              "virticalPadding" : virticalPadding,
                              "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                              "secondaryVirticalPadding" : secondaryVirticalPadding,
                              "turneryHorizontalPadding" : turneryHorizontalPadding,
                              "turneryVerticalPadding" : turneryVerticalPadding]
        
        //collection
        baseLayout.expandView(collection, insideView: self)
       
        lblError.leadingAnchor.constraint(equalTo: collection.leadingAnchor, constant: 8).isActive = true
        lblError.trailingAnchor.constraint(equalTo: collection.trailingAnchor, constant: -8).isActive = true
        lblError.centerYAnchor.constraint(equalTo: collection.centerYAnchor).isActive = true
        lblError.centerXAnchor.constraint(equalTo: collection.centerXAnchor).isActive = true
        
        baseLayout.releaseObject()
        
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    
    
    
    // MARK: - Server Request -


}
