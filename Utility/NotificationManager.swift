//
//  NotificationManager.swift
//  ViewControllerDemo
//
//  Created by SamSol on 09/08/16.
//  Copyright © 2016 SamSol. All rights reserved.
//

import Foundation
import SystemConfiguration
import UserNotifications

struct PushNotificationType : OptionSet {
    
    let rawValue: Int
    
    static let InvalidNotificationType = PushNotificationType(rawValue: -1)
    static let HomeNotificationType = PushNotificationType(rawValue: 1)
    static let OtherNotificationType = PushNotificationType(rawValue: 2)
    
}

open class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    // MARK: - Attributes -
    
    var KReloadKeyboard:String = "KReloadKeyboard"
    var KSuccessGoogleLogin:String = "KSuccessGoogleLogin"
    var KunSuccessGoogleLogin:String = "KunSuccessGoogleLogin"
    
   // MARK: - Lifecycle -
    
    static let sharedInstance : NotificationManager = {
        
        let instance = NotificationManager()
        return instance
        
    }()
    
    deinit{
        
    }
    
    // MARK: - Public Interface -
    
    open func isNetworkAvailableWithBlock(_ completion: @escaping (_ wasSuccessful: Bool) -> Void) {
  
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            completion(false)
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        completion(isReachable && !needsConnection )
        
    }
    
    
    // MARK: - Internal Helpers -

    open func reloadKeyboard(_ isSet: Bool) {
        
        var userInfo: [String: Bool]? = nil
        
        userInfo = ["user": isSet]
        
        let notification = Notification.init(name: Notification.Name(rawValue: KReloadKeyboard), object: self, userInfo: userInfo)
        NotificationCenter.default.post(notification)
        
    }
    
    open func successfullyGoogleLogin(_ anydata: AnyObject) {
        
        var userInfo: [String: AnyObject]? = nil
        
        userInfo = ["googleUserData": anydata]
        
        let notification = Notification.init(name: Notification.Name(rawValue: KSuccessGoogleLogin), object: self, userInfo: userInfo)
        NotificationCenter.default.post(notification)
        
    }
    open func unSucessGoogleLogin(_ isSet: Bool) {
        
        var userInfo: [String: Bool]? = nil
        
        userInfo = ["user": isSet]
        
        let notification = Notification.init(name: Notification.Name(rawValue: KunSuccessGoogleLogin), object: self, userInfo: userInfo)
        NotificationCenter.default.post(notification)
        
    }
    
    func setPushNotificationEnabled(_ isEnabled: Bool) {
        
        let application = UIApplication.shared
        
        if isEnabled {
            
            if #available(iOS 10, *) {
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    
                    guard error == nil else {
                        //Display Error.. Handle Error.. etc..
                        return
                    }
                    
                    if granted {
                        //Do stuff here..
                    }
                    else {
                        //Handle user denying permissions..
                    }
                }
                
            }
            else {
                let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
                application.registerForRemoteNotifications()
            }
            
            //push notitification connection
            NSLog("Connected.")
        }
        else {
            if application.isRegisteredForRemoteNotifications {
                application.unregisterForRemoteNotifications()
                
            }
            //push notitification connection disconnect Code
            NSLog("Disconnected.")
            
        }
    }
    
    func handlePushNotification(_ userInfo: [AnyHashable: Any]) {
        
    }
    
    func displayControllerFromPushNotificationStatusType(_ iType: PushNotificationType, withDetails details: AnyObject) {
        
    }
    
}
