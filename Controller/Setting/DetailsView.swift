//
//  DetailsView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 13/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class DetailsView: UIView {

    // Mark: - Attributes -
    var scrollView : BaseScrollView!
    var containerView : UIView!
    
    var cardView : UIView!
    
    var lblEmail : BaseLabel!
    var lblBirthDate : BaseLabel!
    var lblphone : BaseLabel!
    var lblHeight : BaseLabel!
    var lblWeight : BaseLabel!
    var lblVertical : BaseLabel!
    var lblSchool : BaseLabel!
    var lblHomeTown: BaseLabel!
    
    var imgEmail : BaseImageView!
    var imgBirthDate : BaseImageView!
    var imgPhone : BaseImageView!
    var imgHeight : BaseImageView!
    var imgWeight : BaseImageView!
    var imgVertical: BaseImageView!
    var imgSchool : BaseImageView!
    var imgHomeTown : BaseImageView!
    
    var kPhoneHeight : NSLayoutConstraint!
    var kHeight : NSLayoutConstraint!
    var kWeightHeight : NSLayoutConstraint!
    var kVerticalHeight : NSLayoutConstraint!
    var kSchoolHeight : NSLayoutConstraint!
    var kHomeTownHeight : NSLayoutConstraint!
    
    var kPhoneTop : NSLayoutConstraint!
    var kHeightTop : NSLayoutConstraint!
    var kWeightTop : NSLayoutConstraint!
    var kVerticalTop : NSLayoutConstraint!
    var kSchoolTop : NSLayoutConstraint!
    var kHomeTownTop : NSLayoutConstraint!
    
    
    
    // MARK: - Lifecycle -
    override init(frame : CGRect) {
        super.init(frame: .zero)
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("DetailsView deinit called")
        self.releaseObject()
    }
    
    func releaseObject() {
        if imgHomeTown != nil && imgHomeTown.superview != nil {
            imgHomeTown.removeFromSuperview()
            imgHomeTown = nil
        }
        if imgSchool != nil && imgSchool.superview != nil {
            imgSchool.removeFromSuperview()
            imgSchool = nil
        }
        if imgVertical != nil && imgVertical.superview != nil {
            imgVertical.removeFromSuperview()
            imgVertical = nil
        }
        if imgWeight != nil && imgWeight.superview != nil {
            imgWeight.removeFromSuperview()
            imgWeight = nil
        }
        if imgHeight != nil && imgHeight.superview != nil {
            imgHeight.removeFromSuperview()
            imgHeight = nil
        }
        if imgPhone != nil && imgPhone.superview != nil {
            imgPhone.removeFromSuperview()
            imgPhone = nil
        }
        if imgBirthDate != nil && imgBirthDate.superview != nil {
            imgBirthDate.removeFromSuperview()
            imgBirthDate = nil
        }
        if imgEmail != nil && imgEmail.superview != nil {
            imgEmail.removeFromSuperview()
            imgEmail = nil
        }
        
        if lblHomeTown != nil && lblHomeTown.superview != nil {
            lblHomeTown.removeFromSuperview()
            lblHomeTown = nil
        }
        
        if lblSchool != nil && lblSchool.superview != nil {
            lblSchool.removeFromSuperview()
            lblSchool = nil
        }
        
        if lblVertical != nil && lblVertical.superview != nil {
            lblVertical.removeFromSuperview()
            lblVertical = nil
        }
        
        if lblWeight != nil && lblWeight.superview != nil {
            lblWeight.removeFromSuperview()
            lblWeight = nil
        }
        
        if lblHeight != nil && lblHeight.superview != nil {
            lblHeight.removeFromSuperview()
            lblHeight = nil
        }
        
        if lblphone != nil && lblphone.superview != nil {
            lblphone.removeFromSuperview()
            lblphone = nil
        }
        
        if lblBirthDate != nil && lblBirthDate.superview != nil {
            lblBirthDate.removeFromSuperview()
            lblBirthDate = nil
        }
        
        if lblEmail != nil && lblEmail.superview != nil {
            lblEmail.removeFromSuperview()
            lblEmail = nil
        }
        
        if cardView != nil && cardView.superview != nil {
            cardView.removeFromSuperview()
            cardView = nil
        }
        
        if containerView != nil && containerView.superview != nil {
            containerView.removeFromSuperview()
            containerView = nil
        }
        
        if scrollView != nil && scrollView.superview != nil {
            scrollView.removeFromSuperview()
            scrollView = nil
        }
        
        kPhoneHeight = nil
        kHeight = nil
        kWeightHeight = nil
        kVerticalHeight = nil
        kSchoolHeight = nil
        kHomeTownHeight = nil
        
        kPhoneTop = nil
        kHeightTop = nil
        kWeightTop = nil
        kVerticalTop = nil
        kSchoolTop = nil
        kHomeTownTop = nil
    }
    
    
    // MARK: - Layout -
    
    func loadViewControls() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView = BaseScrollView(scrollType: .vertical, superView: self)
        scrollView.alwaysBounceVertical = true
        containerView = scrollView.container
        
        cardView = UIView(frame: .zero)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = Color.appPrimaryBG.value
        containerView.addSubview(cardView)
        
        lblEmail = BaseLabel(labelType: .medium, superView: cardView)
        lblEmail.numberOfLines = 0
        lblEmail.textAlignment = .left
        
        lblBirthDate = BaseLabel(labelType: .medium, superView: cardView)
        lblBirthDate.textAlignment = .left
        
        lblphone = BaseLabel(labelType: .medium, superView: cardView)
        lblphone.textAlignment = .left
        
        lblHeight = BaseLabel(labelType: .medium, superView: cardView)
        lblHeight.textAlignment = .left
        
        lblWeight = BaseLabel(labelType: .medium, superView: cardView)
        lblWeight.textAlignment = .left
        
        lblVertical = BaseLabel(labelType: .medium, superView: cardView)
        lblVertical.textAlignment = .left
        
        lblSchool = BaseLabel(labelType: .medium, superView: cardView)
        lblSchool.numberOfLines = 0
        lblSchool.textAlignment = .left
        
        lblHomeTown = BaseLabel(labelType: .medium, superView: cardView)
        lblHomeTown.numberOfLines = 0
        lblHomeTown.textAlignment = .left
        
        imgEmail = BaseImageView(type: .defaultImg, superView: cardView)
        imgEmail.image = UIImage(named: "Email")
        
        imgBirthDate = BaseImageView(type: .defaultImg, superView: cardView)
        imgBirthDate.image = UIImage(named: "BirthDate")
        
        imgPhone = BaseImageView(type: .defaultImg, superView: cardView)
        imgPhone.image = UIImage(named: "telephone")
        
        imgHeight = BaseImageView(type: .defaultImg, superView: cardView)
        imgHeight.image = UIImage(named: "height")
        
        imgWeight = BaseImageView(type: .defaultImg, superView: cardView)
        imgWeight.image = UIImage(named: "weight")
        
        imgVertical = BaseImageView(type: .defaultImg, superView: cardView)
        imgVertical.image = UIImage(named: "vertical")
        
        imgSchool = BaseImageView(type: .defaultImg, superView: cardView)
        imgSchool.image = UIImage(named: "school")
        
        imgHomeTown = BaseImageView(type: .defaultImg, superView: cardView)
        imgHomeTown.image = UIImage(named: "home")
        
    }
    
    func setViewlayout() {
        let baseLayout : AppBaseLayout = AppBaseLayout()
        baseLayout.viewDictionary = ["scrollView" : scrollView,
                                     "containerView" : containerView,
                                     "cardView" : cardView,
                                     "lblEmail" : lblEmail,
                                     "lblBirthDate" : lblBirthDate,
                                     "lblphone" : lblphone,
                                     "lblHeight" : lblHeight,
                                     "lblWeight" : lblWeight,
                                     "lblVertical" : lblVertical,
                                     "lblSchool" : lblSchool,
                                     "lblHomeTown" : lblHomeTown,
                                     "imgEmail" : imgEmail,
                                     "imgBirthDate" : imgBirthDate,
                                     "imgPhone" : imgPhone,
                                     "imgHeight" : imgHeight,
                                     "imgWeight" : imgWeight,
                                     "imgVertical" : imgVertical,
                                     "imgSchool" : imgSchool,
                                     "imgHomeTown" : imgHomeTown]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryHorizontalPadding : CGFloat = ControlLayout.turneryHorizontalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        let leftIconHeight : CGFloat = 20.0
        
        baseLayout.metrics = ["horizontalPadding" : horizontalPadding,
                              "virticalPadding" : virticalPadding,
                              "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                              "secondaryVirticalPadding" : secondaryVirticalPadding,
                              "turneryHorizontalPadding" : turneryHorizontalPadding,
                              "turneryVerticalPadding" : turneryVerticalPadding,
                              "leftIconHeight" : leftIconHeight]
        
        // ScrollView
        baseLayout.expandView(scrollView, insideView: self)
        
        
        //cardView
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[cardView]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        containerView.addConstraints(baseLayout.control_H)
        
        
        cardView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: virticalPadding).isActive = true
        cardView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -virticalPadding).isActive = true
        
        lblEmail.topAnchor.constraint(equalTo: cardView.topAnchor, constant: secondaryVirticalPadding).isActive = true
        lblBirthDate.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: virticalPadding).isActive = true
        
        kPhoneTop = lblphone.topAnchor.constraint(equalTo: lblBirthDate.bottomAnchor, constant: virticalPadding)
        kPhoneTop.isActive = true
        
        kHeightTop = lblHeight.topAnchor.constraint(equalTo: lblphone.bottomAnchor, constant: virticalPadding)
        kHeightTop.isActive = true
        
        kWeightTop = lblWeight.topAnchor.constraint(equalTo: lblHeight.bottomAnchor, constant: virticalPadding)
        kWeightTop.isActive = true
        
        kVerticalTop = lblVertical.topAnchor.constraint(equalTo: lblWeight.bottomAnchor, constant: virticalPadding)
        kVerticalTop.isActive = true
        
        kSchoolTop = lblSchool.topAnchor.constraint(equalTo: lblVertical.bottomAnchor, constant: virticalPadding)
        kSchoolTop.isActive = true
        
        kHomeTownTop = lblHomeTown.topAnchor.constraint(equalTo: lblSchool.bottomAnchor, constant: virticalPadding)
        kHomeTownTop.isActive = true
        
        lblHomeTown.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -secondaryVirticalPadding).isActive = true
        
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgEmail(leftIconHeight)]-secondaryHorizontalPadding-[lblEmail]-horizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        cardView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgBirthDate(leftIconHeight)]-secondaryHorizontalPadding-[lblBirthDate]-horizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        cardView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgPhone(leftIconHeight)]-secondaryHorizontalPadding-[lblphone]-horizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        cardView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgHeight(leftIconHeight)]-secondaryHorizontalPadding-[lblHeight]-horizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        cardView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgWeight(leftIconHeight)]-secondaryHorizontalPadding-[lblWeight]-horizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        cardView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgVertical(leftIconHeight)]-secondaryHorizontalPadding-[lblVertical]-horizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        cardView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgSchool(leftIconHeight)]-secondaryHorizontalPadding-[lblSchool]-horizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        cardView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgHomeTown(leftIconHeight)]-secondaryHorizontalPadding-[lblHomeTown]-horizontalPadding-|", options: [.alignAllTop], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        cardView.addConstraints(baseLayout.control_H)
        
        lblEmail.heightAnchor.constraint(equalTo: imgEmail.heightAnchor).isActive = true
        lblBirthDate.heightAnchor.constraint(equalTo: imgBirthDate.heightAnchor).isActive = true
        lblphone.heightAnchor.constraint(greaterThanOrEqualTo: imgPhone.heightAnchor).isActive = true
        lblHeight.heightAnchor.constraint(greaterThanOrEqualTo: imgHeight.heightAnchor).isActive = true
        lblWeight.heightAnchor.constraint(greaterThanOrEqualTo: imgWeight.heightAnchor).isActive = true
        lblVertical.heightAnchor.constraint(greaterThanOrEqualTo: imgVertical.heightAnchor).isActive = true
        lblSchool.heightAnchor.constraint(greaterThanOrEqualTo: imgSchool.heightAnchor).isActive = true
        lblHomeTown.heightAnchor.constraint(greaterThanOrEqualTo: imgHomeTown.heightAnchor).isActive = true
        

        
        
        //icon
        imgEmail.heightAnchor.constraint(equalToConstant: leftIconHeight).isActive = true
        imgBirthDate.heightAnchor.constraint(equalToConstant: leftIconHeight).isActive = true
        
        kPhoneHeight = imgPhone.heightAnchor.constraint(equalToConstant: leftIconHeight)
        kPhoneHeight.isActive = true
        
        kHeight = imgHeight.heightAnchor.constraint(equalToConstant: leftIconHeight)
        kHeight.isActive = true
        
        kWeightHeight = imgWeight.heightAnchor.constraint(equalToConstant: leftIconHeight)
        kWeightHeight.isActive = true
        
        kVerticalHeight = imgVertical.heightAnchor.constraint(equalToConstant: leftIconHeight)
        kVerticalHeight.isActive = true
        
        kSchoolHeight = imgSchool.heightAnchor.constraint(equalToConstant: leftIconHeight)
        kSchoolHeight.isActive = true
        
        kHomeTownHeight = imgHomeTown.heightAnchor.constraint(equalToConstant: leftIconHeight)
        kHomeTownHeight.isActive = true
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            self!.cardView.layer.shadowColor = Color.appSecondaryBG.value.cgColor
            self!.cardView.layer.shadowOpacity = 0.8
            self!.cardView.layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
            self!.cardView.layer.shadowRadius = 1.0
            self!.cardView.layer.cornerRadius = 3
            
        }
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
}
