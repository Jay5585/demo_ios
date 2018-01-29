//
//  ThereNowTableCell.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 01/06/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class ThereNowTableCell: UITableViewCell {
    
    // MARK: - Attributes -
    var collectionView : UICollectionView!
    
    var thereLatter : ThereLatter!  = ThereLatter()
    
    // MARK: - Lifecycle -
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.loadViewControls()
        self.setViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
    }
    
    deinit {
        print("ThereNowTableCell deinit called")
        if collectionView != nil && collectionView.superview != nil {
            collectionView.removeFromSuperview()
            collectionView = nil
        }
        thereLatter = nil
        
        
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if(highlighted){
            self.contentView.backgroundColor = UIColor.clear
            
        }else{
            self.contentView.backgroundColor = UIColor.clear
        }
    }
    
    
    
    // MARK: - Layout -
    
    func loadViewControls(){
        
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.clipsToBounds = false
        self.backgroundColor = Color.appPrimaryBG.value
        self.clipsToBounds = false
        
        self.selectionStyle = .none
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 10, height: 10)
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier : CellIdentifire.collectionViewCell)
        self.contentView.addSubview(collectionView)
        
    }
    
    func setViewLayout(){
        
        let layout : AppBaseLayout = AppBaseLayout()
        
        layout.viewDictionary = ["collectionView" : collectionView]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryHorizontalPadding : CGFloat = ControlLayout.turneryHorizontalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        layout.metrics = ["horizontalPadding" : horizontalPadding,
                          "virticalPadding" : virticalPadding,
                          "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                          "secondaryVirticalPadding" : secondaryVirticalPadding,
                          "turneryHorizontalPadding" : turneryHorizontalPadding,
                          "turneryVerticalPadding" : turneryVerticalPadding]
        
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_H)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_V)
        
        
        self.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(thereLatter : ThereLatter, sectionNo : Int) {
        self.thereLatter = thereLatter
        self.collectionView.tag = sectionNo
        self.collectionView.reloadData()
    }
}


extension ThereNowTableCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.thereLatter.schedules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : CollectionViewCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifire.collectionViewCell, for: indexPath as IndexPath) as? CollectionViewCell
        
        if cell == nil {
            cell = CollectionViewCell(frame: CGRect.zero)
        }
        
        cell.setValue(sedule: self.thereLatter.schedules[indexPath.row])
        
        return cell
    }
}


