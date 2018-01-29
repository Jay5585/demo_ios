//
//  FriendFeedCell.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 15/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class FriendFeedCell: UITableViewCell {
    
    // MARK: - Attributes -
    var layout : AppBaseLayout!
    
    var cardView : UIView!
    
    var lblTitleMassage : BaseLabel!
    var lblDate : BaseLabel!
    var lblLocation : BaseLabel!
    var lblHour : BaseLabel!
    var lblTime : BaseLabel!
    
    var imgProfile : BaseImageView!
    var imgDate : BaseImageView!
    var imgLocation : BaseImageView!
    var imgTime : BaseImageView!
    var imgHour : BaseImageView!
    
    var footerView : UIView!
    var lblUserName : BaseLabel!
    var lblFeedDate : BaseLabel!
    
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
        print("FriendFeedCell deinit called")
        
        if lblFeedDate != nil && lblFeedDate.superview != nil {
            lblFeedDate.removeFromSuperview()
            lblFeedDate = nil
        }
        
        if lblUserName != nil && lblUserName.superview != nil {
            lblUserName.removeFromSuperview()
            lblUserName = nil
        }
        
        if footerView != nil && footerView.superview != nil {
            footerView.removeFromSuperview()
            footerView = nil
        }
        
        if imgHour != nil && imgHour.superview != nil {
            imgHour.removeFromSuperview()
            imgHour = nil
        }
        
        if imgTime != nil && imgTime.superview != nil {
            imgTime.removeFromSuperview()
            imgTime = nil
        }
        
        if imgLocation != nil && imgLocation.superview != nil {
            imgLocation.removeFromSuperview()
            imgLocation = nil
        }
        
        if imgDate != nil && imgDate.superview != nil {
            imgDate.removeFromSuperview()
            imgDate = nil
        }
        
        if imgProfile != nil && imgProfile.superview != nil {
            imgProfile.removeFromSuperview()
            imgProfile = nil
        }
        
        if lblTime != nil && lblTime.superview != nil {
            lblTime.removeFromSuperview()
            lblTime = nil
        }
        
        if lblHour != nil && lblHour.superview != nil {
            lblHour.removeFromSuperview()
            lblHour = nil
        }
        
        if lblLocation != nil && lblLocation.superview != nil {
            lblLocation.removeFromSuperview()
            lblLocation = nil
        }
        if lblDate != nil && lblDate.superview != nil {
            lblDate.removeFromSuperview()
            lblDate = nil
        }
        
        if lblTitleMassage != nil && lblTitleMassage.superview != nil {
            lblTitleMassage.removeFromSuperview()
            lblTitleMassage = nil
        }
        
        if cardView != nil && cardView.superview != nil {
            cardView.removeFromSuperview()
            cardView = nil
        }
        
        layout = nil
        
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
        
        lblTitleMassage = BaseLabel(labelType: .large, superView: cardView)
        lblTitleMassage.textAlignment = .left
        lblTitleMassage.numberOfLines = 2
        lblTitleMassage.text = ""
        
        lblDate = BaseLabel(labelType: .medium, superView: cardView)
        lblDate.textAlignment = .left
        lblDate.text = ""
        
        lblLocation = BaseLabel(labelType: .medium, superView: cardView)
        lblLocation.textAlignment = .left
        lblLocation.text = ""
        
        lblTime = BaseLabel(labelType: .medium, superView: cardView)
        lblTime.textAlignment = .left
        lblTime.text = ""
        
        lblHour = BaseLabel(labelType: .medium, superView: cardView)
        lblHour.textAlignment = .left
        lblHour.text = ""
        
        imgProfile = BaseImageView(type: .defaultImg, superView: cardView)
        imgProfile.isUserInteractionEnabled = true
        imgProfile.layer.masksToBounds = true
        imgProfile.clipsToBounds = true
        
        imgProfile.displayImageFromURL("")
        
        imgDate = BaseImageView(type: .defaultImg, superView: cardView)
        imgDate.image = UIImage(named: "Calender")
        
        imgLocation = BaseImageView(type: .defaultImg, superView: cardView)
        imgLocation.image = UIImage(named: "MarkerSmall")
        
        imgTime = BaseImageView(type: .defaultImg, superView: cardView)
        imgTime.image = UIImage(named: "clock")
        
        imgHour = BaseImageView(type: .defaultImg, superView: cardView)
        imgHour.image = UIImage(named: "clock")
        
        footerView = UIView(frame: .zero)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.backgroundColor = Color.headerColor.value
        cardView.addSubview(footerView)
        
        lblUserName = BaseLabel(labelType: .large, superView: footerView)
        lblUserName.textAlignment = .left
        lblUserName.text = ""
        
        lblFeedDate = BaseLabel(labelType: .large, superView: footerView)
        lblFeedDate.textAlignment = .right
        lblFeedDate.text = ""
        
        
        layout.releaseObject()
        self.layoutIfNeeded()
        
    }
    
    func setViewLayout(){
        
        layout.viewDictionary = ["cardView" : cardView,
                                 "lblTitleMassage" : lblTitleMassage,
                                 "lblDate" : lblDate,
                                 "lblLocation" : lblLocation,
                                 "lblHour" : lblHour,
                                 "lblTime" : lblTime,
                                 "imgProfile" : imgProfile,
                                 "imgDate" : imgDate,
                                 "imgLocation" : imgLocation,
                                 "imgTime" : imgTime,
                                 "imgHour" : imgHour,
                                 "footerView" : footerView,
                                 "lblUserName" : lblUserName,
                                 "lblFeedDate" : lblFeedDate]
        
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryHorizontalPadding : CGFloat = ControlLayout.turneryHorizontalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        let iconSize : CGFloat = 15.0
        let logosize : CGFloat = 70.0
        
        layout.metrics = ["horizontalPadding" : horizontalPadding,
                          "virticalPadding" : virticalPadding,
                          "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                          "secondaryVirticalPadding" : secondaryVirticalPadding,
                          "turneryHorizontalPadding" : turneryHorizontalPadding,
                          "turneryVerticalPadding" : turneryVerticalPadding,
                          "imageSize" : iconSize,
                          "logosize" : logosize]
        
        //Inner View
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[cardView]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_H)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-virticalPadding@751-[cardView]-virticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_V)
        
        
        //First row
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgProfile(logosize)]-secondaryHorizontalPadding-[lblTitleMassage]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        cardView.addConstraints(layout.control_H)
        
        
        //middel Row
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[imgDate(imageSize)]-horizontalPadding-[lblDate]-horizontalPadding@250-[imgTime(imageSize)]-horizontalPadding-[lblTime(60)]-horizontalPadding-|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        cardView.addConstraints(layout.control_H)
        
        imgProfile.heightAnchor.constraint(equalToConstant: logosize).isActive = true
        imgProfile.centerYAnchor.constraint(equalTo: cardView.centerYAnchor, constant: -35 / 2).isActive = true
        imgDate.leadingAnchor.constraint(equalTo: lblTitleMassage.leadingAnchor).isActive = true
        imgDate.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        imgTime.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        
        //Last row
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[imgLocation(imageSize)]-horizontalPadding-[lblLocation]-horizontalPadding-[imgHour(imageSize)]-horizontalPadding-[lblHour(60)]-horizontalPadding-|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        cardView.addConstraints(layout.control_H)
        
        imgLocation.leadingAnchor.constraint(equalTo: imgDate.leadingAnchor).isActive = true
        imgLocation.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        imgHour.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-secondaryVirticalPadding-[lblTitleMassage]-virticalPadding-[lblDate]-virticalPadding-[lblLocation]-virticalPadding-[footerView(35)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        cardView.addConstraints(layout.control_V)
        
        
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[footerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        cardView.addConstraints(layout.control_H)
        
        lblUserName.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding@750-[lblUserName(10@250)]-horizontalPadding-[lblFeedDate]-horizontalPadding@750-|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        footerView.addConstraints(layout.control_H)
        
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            self!.imgProfile.layer.cornerRadius = logosize / 2
            self!.cardView.layer.shadowColor = Color.appSecondaryBG.value.cgColor
            self!.cardView.layer.shadowOpacity = 0.8
            self!.cardView.layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
            self!.cardView.layer.shadowRadius = 1.0
            self!.cardView.layer.cornerRadius = 3
        }
        
        
        self.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    func setData(schedule : Schedule) {
        
        lblDate.text = Date().getDateFromTimeStampe(DateFormate.KFullDate, timestampe: schedule.timeFrom)
        lblLocation.text = schedule.homeCourt.address
        lblTime.text = Date().getOnlyTimeofGivenTimestamp(timestampe: Double(schedule.timeFrom)!)
        lblHour.text = Int(Double(schedule.duration)!) / 3600 > 1 ? "\(Int(Double(schedule.duration)!) / 3600) Hours" : "\(Int(Double(schedule.duration)!) / 3600) Hour"
        
        lblFeedDate.text = Date().getDateFromTimeStampe(DateFormate.KFullDate, timestampe: schedule.scheduleDate)
        lblUserName.text = "\(schedule.user.firstName) \(schedule.user.lastName)"
        
        imgProfile.displayImageFromURL(schedule.user.profilePicUrl)
        
        let now : Double = Date().timeIntervalSince1970
        if now >= Double(schedule.timeFrom)! && now <= Double(schedule.timeTo)! {
            lblTitleMassage.text = "\(schedule.user.firstName) \(schedule.user.lastName) is at \(schedule.homeCourt.homeCourtName)"
        }
        else if now > Double(schedule.timeTo)! {
            lblTitleMassage.text = "\(schedule.user.firstName) \(schedule.user.lastName) was at \(schedule.homeCourt.homeCourtName)"
        }
        else {
            lblTitleMassage.text = "\(schedule.user.firstName) \(schedule.user.lastName) will be at \(schedule.homeCourt.homeCourtName)"
        }
        
    }
}
