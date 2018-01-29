//
//  StatasticCell.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 29/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class StatasticCell: UICollectionViewCell {
    // Mark: - Attributes -
    var baseLayout : AppBaseLayout!
    var progressCircle : CircleProgressBar!
    var lblTitle : BaseLabel!
    
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
        print("StatasticCell deinit called")
        
        if progressCircle != nil && progressCircle.superview != nil {
            progressCircle.removeFromSuperview()
            progressCircle = nil
        }
        
        if lblTitle != nil && lblTitle.superview != nil {
            lblTitle.removeFromSuperview()
            lblTitle = nil
        }
        
    }
    
    // MARK: - Layout -
    
    func loadViewControls() {
        baseLayout = AppBaseLayout()
        
        progressCircle = CircleProgressBar(frame: .zero)
        progressCircle.hintTextFont = UIFont(name: FontStyle.bold, size: 10.0)
        progressCircle.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(progressCircle)
        
        lblTitle = BaseLabel(labelType: .small, superView: self.contentView)
        lblTitle.numberOfLines = 2
        
    }
    
    func setViewlayout() {

        
        baseLayout.viewDictionary = ["progressCircle" : progressCircle,
                                     "lblTitle" : lblTitle]
        
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
        
        
        progressCircle.widthAnchor.constraint(equalToConstant: 60).isActive = true
        progressCircle.heightAnchor.constraint(equalTo: progressCircle.widthAnchor, multiplier: 1.0).isActive = true
        progressCircle.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[lblTitle]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.contentView.addConstraints(baseLayout.control_H)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[progressCircle]", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.contentView.addConstraints(baseLayout.control_V)
        
        lblTitle.topAnchor.constraint(equalTo: progressCircle.bottomAnchor, constant: -5).isActive = true
        lblTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true

        
        self.layoutIfNeeded()
        
    }
    
    func setData(skill : Skill) {
        lblTitle.text = skill.skillName
        if let average : Double = Double(skill.individualScoreAverage) {
            progressCircle.setProgress(CGFloat(Double(average / 100)), animated: false)
        }
        else {
            progressCircle.setProgress(0, animated: false)
        }
    }
}
