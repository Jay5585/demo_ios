//
//  PlayingHourPopUpController.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 04/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import STPopup

class PlayingHourPopUpController: BaseViewController {
    
    // Mark: - Attributes -
    
    var playingHourPopUpView : PlayingHourPopUpView!
    var playingStartTime : Date!
    
    var popUp : STPopupController!
    var alertController : BaseAlertController!
    
    var scheduleStatus : Int = 0
    
    // MARK: - Lifecycle -
    
    init(playingStartTime : Date) {
        playingHourPopUpView = PlayingHourPopUpView(frame: .zero)
        super.init(iView: playingHourPopUpView, andNavigationTitle: "")
        
        self.playingStartTime = playingStartTime
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("PlayingHourPopUpController Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if playingHourPopUpView != nil && playingHourPopUpView.superview != nil {
            playingHourPopUpView.removeFromSuperview()
            playingHourPopUpView = nil
        }
        popUp = nil
        alertController = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
        self.contentSizeInPopup = playingHourPopUpView.container.frame.size
        self.contentSizeInPopup.width = self.view.frame.size.width - 30
        
        self.playingHourPopUpView.btnClose.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            self!.popupController?.dismiss()
        }
        
        self.playingHourPopUpView.btnSubmit.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            self!.addScheduleRequest()
        }
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        self.alertController = nil
        popUp.dismiss()
    }
    
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    fileprivate func addScheduleRequest() {
        
        self.playingHourPopUpView.operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            let duration : Int = self!.playingHourPopUpView.btnSelected.tag * 3600
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            
            
            dictParameter.setValue(Int(self!.playingStartTime.timeIntervalSince1970), forKey: "scheduleDate")
            dictParameter.setValue(Int(self!.playingStartTime.timeIntervalSince1970), forKey: "timeFrom")
            dictParameter.setValue(duration, forKey: "duration")
            dictParameter.setValue(self!.scheduleStatus, forKey: "updateFlag")
            
            
            BaseAPICall.shared.postReques(URL: APIConstant.addSchedule, Parameter: dictParameter, Type: APITask.AddSchedule, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(_, let error):
                    self!.playingHourPopUpView.hideProgressHUD()
                    
                    self!.playingHourPopUpView.makeToast(error!.alertMessage, duration: ToastManager.shared.duration, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tappable) in
                        if self == nil {
                            return
                        }
                        self!.popupController?.dismiss()
                        
                    })
                    
                    break
                    
                case .Error(let error):
                    self!.playingHourPopUpView.hideProgressHUD()
                    if error!.errorCode == "201" {
                        
                        self!.alertController = BaseAlertController(iTitle: "Edit Schedule", iMassage: error!.alertMessage, iButtonTitle: "Yes", index: -1)
                        self!.alertController.delegate = self!
                        
                        self!.popUp = STPopupController.init(rootViewController: self!.alertController)
                        self!.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self!, action: #selector(self!.closePoup(_:))))
                        self!.popUp.navigationBarHidden = true
                        self!.popUp.hidesCloseButton = true
                        self!.popUp.present(in: self!)
                        
                    }
                    else {
                        self?.playingHourPopUpView.makeToast(error!.alertMessage)
                    }
                    break
                    
                case .Internet(let isOn):
                    self!.playingHourPopUpView.handleNetworkCheck(isAvailable: isOn, insideView: AppUtility.getAppDelegate().window!)
                    break
                }
            })
        }
    }
}


extension PlayingHourPopUpController : BaseAlertViewDelegate {
    func didTappedOkButton(_ alertView: BaseAlertController) {
        if self.alertController != nil {
            self.alertController = nil
            self.popUp = nil
            self.scheduleStatus = 1
            self.addScheduleRequest()
        }
    }
}
