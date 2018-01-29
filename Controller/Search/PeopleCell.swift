//
//  PeopleCell.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 09/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class PeopleCell: UITableViewCell {
    
    // MARK: - Attributes -
    var layout : AppBaseLayout!
    
    var cardView : UIView!
    var imgProfile : BaseImageView!
    
    var lableContainer : UIView!
    var lblFullName : BaseLabel!
    var lblTime : BaseLabel!
    var lblHour : BaseLabel!
    
    var imgTime : BaseImageView!
    var imgHour : BaseImageView!
    
    var btnAddFriend : UIButton!
    
    var kTimeTopLayout : NSLayoutConstraint!
    var kHourTopLayout : NSLayoutConstraint!
    
    var kImgTimeHeight : NSLayoutConstraint!
    var kImgHourHeight : NSLayoutConstraint!
    
    var kAddFriendHeightLayout : NSLayoutConstraint!
    
    let iconSize : CGFloat = 15.0
    let buttonSize : CGFloat = 35.0
    let virticalPadding : CGFloat = ControlLayout.verticalPadding
    
    // MARK: - Lifecycle -
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.loadViewControls()
        self.setViewLayout()
    }
    
    deinit {
        print("PeopleCell deinit called")
        
        if btnAddFriend != nil && btnAddFriend.superview != nil {
            btnAddFriend.removeFromSuperview()
            btnAddFriend = nil
        }
        
        if imgHour != nil && imgHour.superview != nil {
            imgHour.removeFromSuperview()
            imgHour = nil
        }
        
        if imgTime != nil && imgTime.superview != nil {
            imgTime.removeFromSuperview()
            imgTime = nil
        }
        
        if lblHour != nil && lblHour.superview != nil {
            lblHour.removeFromSuperview()
            lblHour = nil
        }
        
        
        if lblTime != nil && lblTime.superview != nil {
            lblTime.removeFromSuperview()
            lblTime = nil
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
        kTimeTopLayout = nil
        kHourTopLayout = nil
        kImgTimeHeight = nil
        kImgHourHeight = nil
        kAddFriendHeightLayout = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
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
        
        layout = AppBaseLayout()
        
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.clipsToBounds = false
        
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = false
        
        self.selectionStyle = .none
        
        cardView = UIView(frame: CGRect.zero)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor.white
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
        
        lblTime = BaseLabel(labelType: .medium, superView: lableContainer)
        lblTime.textAlignment = .left
        
        lblHour = BaseLabel(labelType: .medium, superView: lableContainer)
        lblHour.textAlignment = .left
        
        imgTime = BaseImageView(type: .defaultImg, superView: lableContainer)
        imgTime.image = UIImage(named: "clock")
        
        imgHour = BaseImageView(type: .defaultImg, superView: lableContainer)
        imgHour.image = UIImage(named: "clock")
        
        btnAddFriend = UIButton(frame: .zero)
        btnAddFriend.setImage(UIImage(named: "AddFriend"), for: .normal)
        btnAddFriend.translatesAutoresizingMaskIntoConstraints = false
        lableContainer.addSubview(btnAddFriend)
        
    }
    
    func setViewLayout(){
        
        layout.viewDictionary = ["cardView" : cardView,
                                 "imgProfile" : imgProfile,
                                 "lableContainer" : lableContainer,
                                 "lblFullName" : lblFullName,
                                 "lblTime" : lblTime,
                                 "lblHour" : lblHour,
                                 "imgTime" : imgTime,
                                 "imgHour" : imgHour,
                                 "btnAddFriend" : btnAddFriend]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
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
                          "iconSize" : iconSize,
                          "buttonSize" : buttonSize]
        
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
        
        lblFullName.topAnchor.constraint(equalTo: lableContainer.topAnchor).isActive = true
        lblHour.bottomAnchor.constraint(equalTo: lableContainer.bottomAnchor).isActive = true
        
        kTimeTopLayout = lblTime.topAnchor.constraint(equalTo: lblFullName.bottomAnchor, constant: virticalPadding)
        kTimeTopLayout.isActive = true
        
        kHourTopLayout = lblHour.topAnchor.constraint(equalTo: lblTime.bottomAnchor, constant: virticalPadding)
        kHourTopLayout.isActive = true
        
        kAddFriendHeightLayout = btnAddFriend.heightAnchor.constraint(equalToConstant: buttonSize)
        kAddFriendHeightLayout.isActive = true
        btnAddFriend.centerYAnchor.constraint(equalTo: lableContainer.centerYAnchor).isActive = true
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[lblFullName]-[btnAddFriend(buttonSize)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        lableContainer.addConstraints(layout.control_H)
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imgTime(iconSize)]-virticalPadding-[lblTime]|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        lableContainer.addConstraints(layout.control_H)
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imgHour(iconSize)]-virticalPadding-[lblHour]|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        lableContainer.addConstraints(layout.control_H)
        
        
        kImgTimeHeight = imgTime.heightAnchor.constraint(equalToConstant: iconSize)
        kImgTimeHeight.isActive = true
        
        kImgHourHeight = imgHour.heightAnchor.constraint(equalToConstant: iconSize)
        kImgHourHeight.isActive = true
        
        
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
    
    
    func setData(people : People) {
        
        self.lblFullName.text = "\(people.firstName) \(people.lastName)"
        self.imgProfile.displayImageFromURL(people.profilePicUrl)
        self.btnAddFriend.isHidden = people.friendStatus == "1" ? true : false
        
        if people.schedules.count != 0 {
            if people.schedules[0].timeFrom == "" && people.schedules[0].duration == "" {
              
                kHourTopLayout.constant = 0
                kTimeTopLayout.constant = 0
                kImgTimeHeight.constant = 0
                kImgHourHeight.constant = 0
                
                self.lblTime.text = ""
                self.lblHour.text = ""
            }
            else if people.schedules[0].timeFrom != "" && people.schedules[0].duration == "" {
                kHourTopLayout.constant = 0
                kTimeTopLayout.constant = virticalPadding
                kImgTimeHeight.constant = iconSize
                kImgHourHeight.constant = 0
                
                self.lblTime.text = Date().getOnlyTimeofGivenTimestamp(timestampe: Double(people.schedules[0].timeFrom)!)
                self.lblHour.text = ""
            }
            else if people.schedules[0].timeFrom == "" && people.schedules[0].duration != "" {
                kHourTopLayout.constant = virticalPadding
                kTimeTopLayout.constant = 0
                kImgTimeHeight.constant = 0
                kImgHourHeight.constant = iconSize
                
                self.lblTime.text = ""
                self.lblHour.text = Int(Double(people.schedules[0].duration)!) / 3600 > 1 ? "\(Int(Double(people.schedules[0].duration)!) / 3600) Hours" : "\(Int(Double(people.schedules[0].duration)!) / 3600) Hour"
            }
            else {
                kHourTopLayout.constant = virticalPadding
                kTimeTopLayout.constant = virticalPadding
                kImgTimeHeight.constant = iconSize
                kImgHourHeight.constant = iconSize

                self.lblTime.text = Date().getOnlyTimeofGivenTimestamp(timestampe: Double(people.schedules[0].timeFrom)!)
                self.lblHour.text = Int(Double(people.schedules[0].duration)!) / 3600 > 1 ? "\(Int(Double(people.schedules[0].duration)!) / 3600) Hours" : "\(Int(Double(people.schedules[0].duration)!) / 3600) Hour"
            }
        }
        else {
            kHourTopLayout.constant = 0
            kTimeTopLayout.constant = 0
            kImgTimeHeight.constant = 0
            kImgHourHeight.constant = 0
            self.lblTime.text = ""
            self.lblHour.text = ""
        }
    }
}
