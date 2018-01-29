//
//  RateUserCell.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 30/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class RateUserCell: UITableViewCell {
    
    // MARK: - Attributes -
    var layout : AppBaseLayout!
    
    var cardView : UIView!
    var slider : UISlider!
    var lblTitle : BaseLabel!
    var lblCurrentRatting : BaseLabel!
    var lblMinRatting : BaseLabel!
    var lblMaxRatting : BaseLabel!
    
    
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
        print("RateUserCell deinit called")
        
        
        if lblMaxRatting != nil && lblMaxRatting.superview != nil {
            lblMaxRatting.removeFromSuperview()
            lblMaxRatting = nil
        }
        if lblMinRatting != nil && lblMinRatting.superview != nil {
            lblMinRatting.removeFromSuperview()
            lblMinRatting = nil
        }
        
        if lblCurrentRatting != nil && lblCurrentRatting.superview != nil {
            lblCurrentRatting.removeFromSuperview()
            lblCurrentRatting = nil
        }
        if lblTitle != nil && lblTitle.superview != nil {
            lblTitle.removeFromSuperview()
            lblTitle = nil
        }
        if slider != nil && slider.superview != nil {
            slider.removeFromSuperview()
            slider = nil
        }
        if cardView != nil && cardView.superview != nil {
            cardView.removeFromSuperview()
            cardView = nil
        }
        
        layout = nil
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
        
        layout = AppBaseLayout()
        
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.clipsToBounds = false
        
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = false
        
        self.selectionStyle = .none
        
        cardView = UIView(frame: CGRect.zero)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = Color.appPrimaryBG.value
        self.contentView.addSubview(cardView)
        
        slider = UISlider(frame: .zero)
        slider.setCommonProperty()
        cardView.addSubview(slider)
        
        lblTitle = BaseLabel(labelType: .large, superView: cardView)
        lblTitle.textAlignment = .left
        
        lblCurrentRatting = BaseLabel(labelType: .large, superView: cardView)
        lblCurrentRatting.textAlignment = .right
        
        lblMaxRatting = BaseLabel(labelType: .medium, superView: cardView)
        lblMaxRatting.textAlignment = .right
        lblMaxRatting.text = "100"
        
        lblMinRatting = BaseLabel(labelType: .medium, superView: cardView)
        lblMinRatting.textAlignment = .left
        lblMinRatting.text = "0"
        
    }
    
    func setViewLayout(){
        
        layout.viewDictionary = ["cardView" : cardView,
                                 "slider" : slider,
                                 "lblTitle" : lblTitle,
                                 "lblCurrentRatting" : lblCurrentRatting,
                                 "lblMinRatting" : lblMinRatting,
                                 "lblMaxRatting" : lblMaxRatting]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryHorizontalPadding : CGFloat = ControlLayout.turneryHorizontalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        let imageSize : CGFloat = 70.0
        
        layout.metrics = ["horizontalPadding" : horizontalPadding,
                          "virticalPadding" : virticalPadding,
                          "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                          "secondaryVirticalPadding" : secondaryVirticalPadding,
                          "turneryHorizontalPadding" : turneryHorizontalPadding,
                          "turneryVerticalPadding" : turneryVerticalPadding,
                          "imageSize" : imageSize]
        
        //Inner View
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[cardView]-secondaryHorizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_H)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-secondaryVirticalPadding@751-[cardView]-secondaryVirticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_V)
        
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[lblTitle]-horizontalPadding-[lblCurrentRatting]|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        self.cardView.addConstraints(layout.control_H)
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[slider]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.cardView.addConstraints(layout.control_H)
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[lblMinRatting]-horizontalPadding-[lblMaxRatting]|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        self.cardView.addConstraints(layout.control_H)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[lblTitle]-virticalPadding-[slider][lblMinRatting]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.cardView.addConstraints(layout.control_V)
        
        layout.releaseObject()
        self.layoutSubviews()
        self.layoutIfNeeded()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setData(skill : Skill) {
        self.lblTitle.text = skill.skillName
        self.slider.value = Float(skill.individualScore)!
        self.lblCurrentRatting.text = String(Int(floor(slider.value)))
    }
    
}
