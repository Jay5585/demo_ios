//
//  DetailTableCell.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 15/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class ScheduleTableCell: UITableViewCell {
    
    // MARK: - Attributes -
    var layout : AppBaseLayout!
    
    var cardView : UIView!
    
    var lblCourtName : BaseLabel!
    var lblDate : BaseLabel!
    var lblLocation : BaseLabel!
    var lblHour : BaseLabel!
    var lblTime : BaseLabel!
    
    var imgLogo : BaseImageView!
    var imgDate : BaseImageView!
    var imgLocation : BaseImageView!
    var imgTime : BaseImageView!
    var imgHour : BaseImageView!
    
    
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
        print("ScheduleTableCell deinit called")
        
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
        if imgLogo != nil && imgLogo.superview != nil {
            imgLogo.removeFromSuperview()
            imgLogo = nil
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
        if lblCourtName != nil && lblCourtName.superview != nil {
            lblCourtName.removeFromSuperview()
            lblCourtName = nil
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
        
        lblCourtName = BaseLabel(labelType: .large, superView: cardView)
        lblCourtName.textAlignment = .left
        
        
        lblDate = BaseLabel(labelType: .medium, superView: cardView)
        lblDate.textAlignment = .left
        
        
        lblLocation = BaseLabel(labelType: .medium, superView: cardView)
        lblLocation.textAlignment = .left
       
        
        lblTime = BaseLabel(labelType: .medium, superView: cardView)
        lblTime.textAlignment = .left
        
        
        lblHour = BaseLabel(labelType: .medium, superView: cardView)
        lblHour.textAlignment = .left
        
        
        imgLogo = BaseImageView(type: .defaultImg, superView: cardView)
        imgLogo.image = UIImage(named: "Schedule")
        
        imgDate = BaseImageView(type: .defaultImg, superView: cardView)
        imgDate.image = UIImage(named: "Calender")
        
        imgLocation = BaseImageView(type: .defaultImg, superView: cardView)
        imgLocation.image = UIImage(named: "MarkerSmall")
        
        imgTime = BaseImageView(type: .defaultImg, superView: cardView)
        imgTime.image = UIImage(named: "clock")
        
        imgHour = BaseImageView(type: .defaultImg, superView: cardView)
        imgHour.image = UIImage(named: "clock")
        
    }
    
    func setViewLayout(){
        
        layout.viewDictionary = ["cardView" : cardView,
                                 "lblCourtName" : lblCourtName,
                                 "lblDate" : lblDate,
                                 "lblLocation" : lblLocation,
                                 "lblHour" : lblHour,
                                 "lblTime" : lblTime,
                                 "imgLogo" : imgLogo,
                                 "imgDate" : imgDate,
                                 "imgLocation" : imgLocation,
                                 "imgTime" : imgTime,
                                 "imgHour" : imgHour]
        
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryHorizontalPadding : CGFloat = ControlLayout.turneryHorizontalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        let iconSize : CGFloat = 15.0
        let logosize : CGFloat = 60.0
        
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
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[imgLogo]-horizontalPadding-[lblCourtName]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        cardView.addConstraints(layout.control_H)
        
        
        //middel Row
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imgLogo(logosize)]-horizontalPadding-[imgDate(imageSize)]-horizontalPadding-[lblDate]-horizontalPadding@250-[imgTime(imageSize)]-horizontalPadding-[lblTime(60)]-horizontalPadding-|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        cardView.addConstraints(layout.control_H)
        
        imgLogo.heightAnchor.constraint(equalToConstant: logosize).isActive = true
        imgDate.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        imgTime.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        
        //Last row
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[imgLocation(imageSize)]-horizontalPadding-[lblLocation]-horizontalPadding-[imgHour(imageSize)]-horizontalPadding-[lblHour(60)]-horizontalPadding-|", options: [.alignAllCenterY], metrics: layout.metrics, views: layout.viewDictionary)
        cardView.addConstraints(layout.control_H)
        
        imgLocation.leadingAnchor.constraint(equalTo: imgDate.leadingAnchor).isActive = true
        imgLocation.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        imgHour.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-secondaryVirticalPadding-[lblCourtName]-virticalPadding-[lblDate]-virticalPadding-[lblLocation]-secondaryVirticalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        cardView.addConstraints(layout.control_V)
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
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
    
    func setData(schedule : Schedule) {
        lblCourtName.text = schedule.homeCourt.homeCourtName
        lblDate.text = Date().getDateFromTimeStampe(DateFormate.KFullDate, timestampe: schedule.timeFrom)
        lblLocation.text = schedule.homeCourt.address
        lblTime.text = Date().getOnlyTimeofGivenTimestamp(timestampe: Double(schedule.timeFrom)!)
        lblHour.text = Int(Double(schedule.duration)!) / 3600 > 1 ? "\(Int(Double(schedule.duration)!) / 3600) Hours" : "\(Int(Double(schedule.duration)!) / 3600) Hour"
        
        
        let now : Double = Date().timeIntervalSince1970
        if now >= Double(schedule.timeFrom)! && now <= Double(schedule.timeTo)! {
            self.cardView.backgroundColor = Color.activeCell.value
        }
        else {
            self.cardView.backgroundColor = Color.inActiveCell.value
        }
    }
    
}
