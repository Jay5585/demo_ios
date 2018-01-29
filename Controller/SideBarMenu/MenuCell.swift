//
//  MenuCell.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 05/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    // MARK: - Attributes -
    
    var layout : AppBaseLayout!
    
    var innerView : UIView!
    var imgIcon : BaseImageView!
    var lblMenuText : BaseLabel!
    
    
    fileprivate var selectedView : UIView!
    
    fileprivate var gradientLayer : CAGradientLayer!
    fileprivate var selectedGradientLayer : CAGradientLayer!
    
    fileprivate var emitterLayer : CAEmitterLayer!
    fileprivate var emitterCell : CAEmitterCell!
    
    
    // MARK: - Lifecycle -
    
    deinit {
        print("MenuCell denint called")
        if imgIcon != nil && imgIcon.superview != nil {
            imgIcon.removeFromSuperview()
            imgIcon = nil
        }
        
        if lblMenuText != nil && lblMenuText.superview != nil {
            lblMenuText.removeFromSuperview()
            lblMenuText = nil
        }
        
        if innerView != nil && innerView.superview != nil {
            innerView.removeFromSuperview()
            innerView = nil
        }
        
        layout = nil
        gradientLayer = nil
        selectedGradientLayer = nil
        emitterLayer = nil
        emitterCell = nil
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.loadViewControls()
        self.setViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
    }
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        selectedGradientLayer.frame = self.contentView.bounds
        gradientLayer.frame = self.contentView.bounds
    }
    
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if(highlighted){
            self.contentView.backgroundColor = Color.appSecondaryBG.withAlpha(0.2)
            
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
        
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.selectionStyle = .none
        self.layoutMargins = UIEdgeInsets.zero
        
        //Selected Gradiant Layer Allocation
        selectedGradientLayer = CAGradientLayer()
        selectedGradientLayer.frame = self.contentView.bounds
        selectedGradientLayer.colors = [Color.appIntermidiateBG.withAlpha(0.18),
                                        Color.appIntermidiateBG.withAlpha(0.19),
                                        Color.appIntermidiateBG.withAlpha(0.2),
                                        Color.appIntermidiateBG.withAlpha(0.19),
                                        Color.appIntermidiateBG.withAlpha(0.18)]
        
        // Gradient Layer Allocation
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.contentView.bounds
        gradientLayer.colors = [UIColor(rgbValue: 0x000000, alpha: 0.18).cgColor,
                                UIColor(rgbValue: 0x000000, alpha: 0.19).cgColor,
                                UIColor(rgbValue: 0x000000, alpha: 0.2).cgColor,
                                UIColor(rgbValue: 0x000000, alpha: 0.19).cgColor,
                                UIColor(rgbValue: 0x000000, alpha: 0.18).cgColor]
        
        gradientLayer.isHidden = false
        selectedGradientLayer.isHidden = false
        
        
        innerView = UIView(frame: CGRect.zero)
        innerView.backgroundColor = UIColor.clear
        innerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(innerView)
        
    
        imgIcon = BaseImageView(type: .defaultImg, superView: innerView)
        imgIcon.contentMode = .scaleAspectFit
        
        lblMenuText = BaseLabel(labelType: .large, superView: innerView)
        lblMenuText.textAlignment = .left
        
        // Selected View Allocation
        selectedView = UIView()
        selectedView.backgroundColor = UIColor(rgbValue: 0x000000, alpha: 0.4)
        self.selectedBackgroundView = selectedView
        selectedView.layer.insertSublayer(selectedGradientLayer, at: 0)
        
    }
    
    func setViewLayout(){
        
        layout.viewDictionary = ["innerView" : innerView,
                                 "imgIcon" : imgIcon,
                                 "lblMenuText" : lblMenuText]
        
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
        
        let constantIconHeight : CGFloat = 25
        
       
        
        
        
        //InnerView...
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[innerView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_H)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[innerView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_V)
        
        
        // ImageView...
        innerView.addConstraint(NSLayoutConstraint(item: imgIcon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: constantIconHeight))
        
        innerView.addConstraint(NSLayoutConstraint(item: imgIcon, attribute: .height, relatedBy: .equal, toItem: imgIcon, attribute: .width, multiplier: 1.0, constant: 0))
        
        innerView.addConstraint(NSLayoutConstraint(item: imgIcon, attribute: .leading, relatedBy: .equal, toItem: innerView, attribute: .leading, multiplier: 1.0, constant: turneryHorizontalPadding))
        
        innerView.addConstraint(NSLayoutConstraint(item: imgIcon, attribute: .centerY, relatedBy: .equal, toItem: innerView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        
        //Place Lable
        innerView.addConstraint(NSLayoutConstraint(item: lblMenuText, attribute: .leading, relatedBy: .equal, toItem: imgIcon, attribute: .trailing, multiplier: 1.0, constant: secondaryHorizontalPadding))
        
        innerView.addConstraint(NSLayoutConstraint(item: lblMenuText, attribute: .centerY, relatedBy: .equal, toItem: imgIcon, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        
        layout.releaseObject()
        self.layoutIfNeeded()
        
    }
    
    
    func setViewContentDetail(_ dicDetail : NSDictionary) -> Void {
        self.tag = dicDetail["index"] as! Int
        lblMenuText.text = dicDetail["title"] as? String
        imgIcon.image = UIImage(named: (dicDetail["icon"] as? String)!)?.withRenderingMode(.alwaysTemplate)
        imgIcon.tintColor = Color.appSecondaryBG.value
    }
    
    
    func setSelectedCell(_ isSelected : Bool) -> Void {
        if isSelected {
            self.innerView.layer.insertSublayer(gradientLayer, at: 0)
            if emitterLayer != nil {
                self.contentView.layer.addSublayer(emitterLayer)
            }
            imgIcon.image = imgIcon.image?.withRenderingMode(.alwaysTemplate)
            imgIcon.tintColor = Color.appIntermidiateBG.value
            lblMenuText.textColor = Color.appIntermidiateBG.value
        }
        else {
            imgIcon.image = imgIcon.image?.withRenderingMode(.alwaysTemplate)
            imgIcon.tintColor = Color.appSecondaryBG.value
            lblMenuText.textColor = Color.appSecondaryBG.value
            
            self.contentView.backgroundColor = UIColor.clear
            gradientLayer.removeFromSuperlayer()
            
            if emitterLayer != nil {
                emitterLayer.removeFromSuperlayer()
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
