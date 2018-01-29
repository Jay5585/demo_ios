//
//  RateUserView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 15/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import SwiftEventBus


class RateUserView: BaseView {
    // Mark: - Attributes -
    var tableView : UITableView!
    var btnSubmit : BaseButton!
    
    var tempRating : IndividualRating!
    var userId : String! = ""
    
    
    
    // MARK: - Lifecycle -
    
    init(ratting : IndividualRating, userId : String) {
        super.init(frame: .zero)
        
        self.tempRating = ratting
        self.userId = userId
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        
        print("RateUserView denint called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if btnSubmit != nil && btnSubmit.superview != nil {
            btnSubmit.removeFromSuperview()
            btnSubmit = nil
        }
        
        if tableView != nil && tableView.superview != nil {
            tableView.removeFromSuperview()
            tableView = nil
        }
       
        tempRating = nil
        
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        tableView = UITableView(frame: .zero)        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(RateUserCell.self, forCellReuseIdentifier: CellIdentifire.rateUserCell)
        
        self.addSubview(tableView)
        
        btnSubmit = BaseButton(ibuttonType: .primary, iSuperView: self)
        btnSubmit.setTitle("Submit Rating", for: .normal)
        
        btnSubmit.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            self!.rateUserRequest()
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        
        baseLayout.viewDictionary = ["tableView" : tableView,
                                     "btnSubmit" : btnSubmit]
        
       
        
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
        
        // tableView
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]-secondaryVirticalPadding-[btnSubmit]-secondaryVirticalPadding-|", options: [.alignAllCenterX], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        //btnSubmit
        btnSubmit.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    func sliderDragged(sender : UISlider) {
        let indexPath : IndexPath = IndexPath(row: sender.tag, section: 0)
        let cell : RateUserCell = tableView.cellForRow(at: indexPath) as! RateUserCell
        cell.lblCurrentRatting.text = String(Int(floor(sender.value)))
        
        self.tempRating.skills[sender.tag].individualScore = String(Int(floor(sender.value)))
    }
    
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    fileprivate func rateUserRequest() {
        
        self.operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            
            
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(self!.userId, forKey: "profileId")
            
            
            let arrayParameter : NSMutableArray = NSMutableArray()
            
            for (_, skill) in self!.tempRating.skills.enumerated() {
                
                let dictSkill : NSMutableDictionary = NSMutableDictionary()
                
                dictSkill.setValue(skill.individualScore, forKey: "score")
                dictSkill.setValue(skill.skillId, forKey: "id")
               
                arrayParameter.add(dictSkill)
            }
            dictParameter.setValue(arrayParameter, forKey: "scores")
            
            BaseAPICall.shared.postRequestUsingBody(URL: APIConstant.rateUser, Parameter: dictParameter, Type: APITask.RateUser, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                
                switch result{
                case .Success(let object, let error):
                    self!.hideProgressHUD()
                    
                    let user : People = object as! People
                    SwiftEventBus.post(NotificationKey.rateUser, sender: user as AnyObject)

                    self!.makeToast(error!.alertMessage, duration: ToastManager.shared.duration, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tappable) in
                        if self == nil {
                            return
                        }
                        if let conroller : RateUserController = self!.getViewControllerFromSubView() as? RateUserController {
                            _ = conroller.navigationController?.popViewController(animated: true)
                        }
                    })
                    break
                    
                case .Error(let error):
                    self!.hideProgressHUD()
                    self!.makeToast(error!.alertMessage)
                    break
                    
                case .Internet(let isOn):
                    self!.handleNetworkCheck(isAvailable: isOn, insideView: AppUtility.getAppDelegate().window!)
                    break
                }
            })
        }
    }
}
//MARK: - UITableViewDatasource
extension RateUserView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tempRating.skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : RateUserCell!
        cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.rateUserCell) as? RateUserCell
        if cell == nil {
            cell = RateUserCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifire.rateUserCell)
        }
        
        cell.slider.tag = indexPath.row
        cell.slider.addTarget(self, action: #selector(sliderDragged(sender:)), for: .valueChanged)
        cell.setData(skill : self.tempRating.skills[indexPath.row])
        
        return cell
    }
}



//MARK: - UITableViewDelegate

extension RateUserView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}



