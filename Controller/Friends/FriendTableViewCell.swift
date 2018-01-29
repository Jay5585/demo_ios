//
//  FriendTableViewCell.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    // MARK: - Attributes -
    var layout : AppBaseLayout!
    
    var cardView : UIView!
    var imgProfile : BaseImageView!
    
    var lableContainer : UIView!
    var lblFullName : BaseLabel!
    var lblNickName : BaseLabel!
    var lblCourtName : BaseLabel!
    
    var imgNickName : BaseImageView!
    var imgCourtName : BaseImageView!
    
    var kAllLableLayout : [NSLayoutConstraint]!
    var KOnlyNameLayout : [NSLayoutConstraint]!
    var kNicknameLayout : [NSLayoutConstraint]!
    var kCourtnameLayout : [NSLayoutConstraint]!
    
    var kImgNicknameHeight : NSLayoutConstraint!
    var kImgCourtnameHeight : NSLayoutConstraint!
    
    let iconSize : CGFloat = 15.0

    
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
        print("FriendTableViewCell deinit called")
        
        
        
        if imgCourtName != nil && imgCourtName.superview != nil {
            imgCourtName.removeFromSuperview()
            imgCourtName = nil
        }
        if imgNickName != nil && imgNickName.superview != nil {
            imgNickName.removeFromSuperview()
            imgNickName = nil
        }
        
        if lblCourtName != nil && lblCourtName.superview != nil {
            lblCourtName.removeFromSuperview()
            lblCourtName = nil
        }
        if lblNickName != nil && lblNickName.superview != nil {
            lblNickName.removeFromSuperview()
            lblNickName = nil
        }
        
        if lblFullName != nil && lblFullName.superview != nil {
            lblFullName.removeFromSuperview()
            lblFullName = nil
        }
        if lableContainer != nil && lableContainer.superview != nil {
            lableContainer.removeFromSuperview()
            lableContainer = nil
        }
        
        if imgProfile != nil && imgProfile.superview != nil {
            imgProfile.removeFromSuperview()
            imgProfile = nil
        }
        if cardView != nil && cardView.superview != nil {
            cardView.removeFromSuperview()
            cardView = nil
        }
        
        layout = nil
        kAllLableLayout = nil
        KOnlyNameLayout = nil
        kNicknameLayout = nil
        kCourtnameLayout = nil
        kImgNicknameHeight = nil
        kImgCourtnameHeight = nil
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
        
        imgProfile = BaseImageView(type: .defaultImg, superView: cardView)
        imgProfile.isUserInteractionEnabled = true
        imgProfile.layer.masksToBounds = true
        imgProfile.clipsToBounds = true
        
        lableContainer = UIView()
        lableContainer.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(lableContainer)
        
        lblFullName = BaseLabel(labelType: .large, superView: lableContainer)
        lblFullName.textAlignment = .left
        
        lblNickName = BaseLabel(labelType: .medium, superView: lableContainer)
        lblNickName.textAlignment = .left
        
        lblCourtName = BaseLabel(labelType: .medium, superView: lableContainer)
        lblCourtName.textAlignment = .left
        
        imgNickName = BaseImageView(type: .defaultImg, superView: lableContainer)
        imgNickName.image = UIImage(named: "user")
        
        imgCourtName = BaseImageView(type: .defaultImg, superView: lableContainer)
        imgCourtName.image = UIImage(named: "Courts")
        
        
    }
    
    func setViewLayout(){
        
        layout.viewDictionary = ["cardView" : cardView,
                                 "imgProfile" : imgProfile,
                                 "lableContainer" : lableContainer,
                                 "lblFullName" : lblFullName,
                                 "lblNickName" : lblNickName,
                                 "lblCourtName" : lblCourtName,
                                 "imgNickName" : imgNickName,
                                 "imgCourtName" : imgCourtName]
        
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
                              "imageSize" : imageSize,
                              "iconSize" : iconSize]
        
        //Inner View
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[cardView]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_H)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-virticalPadding@751-[cardView]-virticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_V)
        
        //Profile Image View
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-secondaryVirticalPadding-[imgProfile(imageSize)]-secondaryVirticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.cardView.addConstraints(layout.control_V)
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgProfile(imageSize)]-secondaryHorizontalPadding-[lableContainer]-virticalPadding-|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        self.cardView.addConstraints(layout.control_H)
        
        //All labels
        
        kAllLableLayout = NSLayoutConstraint.constraints(withVisualFormat: "V:|[lblFullName]-virticalPadding-[lblNickName]-virticalPadding-[lblCourtName]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        lableContainer.addConstraints(kAllLableLayout)
        
        KOnlyNameLayout = NSLayoutConstraint.constraints(withVisualFormat: "V:|[lblFullName]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        
        kNicknameLayout  = NSLayoutConstraint.constraints(withVisualFormat: "V:|[lblFullName]-virticalPadding-[lblNickName]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        
        kCourtnameLayout  = NSLayoutConstraint.constraints(withVisualFormat: "V:|[lblFullName]-virticalPadding-[lblCourtName]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        

        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[lblFullName]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        lableContainer.addConstraints(layout.control_H)
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imgNickName(iconSize)]-virticalPadding-[lblNickName]|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        lableContainer.addConstraints(layout.control_H)
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imgCourtName(iconSize)]-virticalPadding-[lblCourtName]|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        lableContainer.addConstraints(layout.control_H)
        
        
        kImgNicknameHeight = imgNickName.heightAnchor.constraint(equalToConstant: iconSize)
        kImgNicknameHeight.isActive = true
        
        kImgCourtnameHeight = imgCourtName.heightAnchor.constraint(equalToConstant: iconSize)
        kImgCourtnameHeight.isActive = true
        
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            self!.imgProfile.layer.cornerRadius = imageSize / 2
            self!.cardView.layer.shadowColor = Color.appSecondaryBG.value.cgColor
            self!.cardView.layer.shadowOpacity = 0.8
            self!.cardView.layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
            self!.cardView.layer.shadowRadius = 1.0
            self!.cardView.layer.cornerRadius = 3
        }
        
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
    
    func setData(friend : People) {
       
        self.lblFullName.text = "\(friend.firstName) \(friend.lastName)"
        self.imgProfile.displayImageFromURL(friend.profilePicUrl)
        
        if friend.nickName == "" && friend.homeCourt == nil {
            
            self.lableContainer.removeConstraints(kAllLableLayout)
            self.lableContainer.removeConstraints(kNicknameLayout)
            self.lableContainer.removeConstraints(kCourtnameLayout)
            self.lableContainer.addConstraints(KOnlyNameLayout)
            
            kImgNicknameHeight.constant = 0
            kImgCourtnameHeight.constant = 0
            self.lblNickName.text = ""
            self.lblCourtName.text = ""
            
        }
        else if friend.homeCourt == nil {
            self.lableContainer.removeConstraints(kAllLableLayout)
            self.lableContainer.removeConstraints(kCourtnameLayout)
            self.lableContainer.removeConstraints(KOnlyNameLayout)
            self.lableContainer.addConstraints(kNicknameLayout)
            
            kImgNicknameHeight.constant = iconSize
            kImgCourtnameHeight.constant = 0
            
            self.lblNickName.text = friend.nickName
            self.lblCourtName.text = ""
        }
        else if friend.nickName == "" {
            
            self.lableContainer.removeConstraints(kAllLableLayout)
            self.lableContainer.removeConstraints(KOnlyNameLayout)
            self.lableContainer.removeConstraints(kNicknameLayout)
            self.lableContainer.addConstraints(kCourtnameLayout)
            
            kImgNicknameHeight.constant = 0
            kImgCourtnameHeight.constant = iconSize
            
            self.lblNickName.text = ""
            self.lblCourtName.text = friend.homeCourt!.homeCourtName
            
        }
        else {
            self.lableContainer.removeConstraints(KOnlyNameLayout)
            self.lableContainer.removeConstraints(kNicknameLayout)
            self.lableContainer.removeConstraints(kCourtnameLayout)
            self.lableContainer.addConstraints(kAllLableLayout)
            
            kImgNicknameHeight.constant = iconSize
            kImgCourtnameHeight.constant = iconSize
            
            self.lblNickName.text = friend.nickName
            self.lblCourtName.text = friend.homeCourt?.homeCourtName
        }
    }
}
