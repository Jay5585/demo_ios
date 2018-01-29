//
//  AppDelegate.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 27/04/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import Stripe
import Fabric
import Crashlytics
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import SDWebImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : BaseNavigationController!
    var frostedController : REFrostedViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        //Stripe
        STPPaymentConfiguration.shared().publishableKey = ThiredPartyKey.StripePublishableKey
        
        // Fabric
        Crashlytics().debugMode = true
        Fabric.with([Crashlytics.self])
        
        //Google Map and place
        GMSServices.provideAPIKey(ThiredPartyKey.googleMapKey)
        GMSPlacesClient.provideAPIKey(ThiredPartyKey.googleMapKey)
        
        
        // Keyboard manager
        IQKeyboardManager.sharedManager().enable = true
        
        //Change Status bar color
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.black
        
        self.loadUI()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }

    
    // MARK: Public Method
    open func loadUI() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        AppUtility.isUserLogin() ? self.displayDashboardViewOnWindow() : self.displayLoginViewOnWindow()
        window?.makeKeyAndVisible()
    }
    
    func displayLoginViewOnWindow() {
        self.loadLoginView()
        self.window!.rootViewController = self.navigationController!
    }
    
    func displayDashboardViewOnWindow() {
        self.loadDashboardView()
        self.window!.rootViewController = frostedController
    }
    
    fileprivate func loadDashboardView() {
        self.navigationController = nil
        self.frostedController = nil        
        
        if let homeCourtId : String = AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KHomeCourtId) as? String, homeCourtId != "" {
            navigationController = BaseNavigationController(rootViewController: HomeViewController())
        }
        else {
            navigationController = BaseNavigationController(rootViewController: SelectHomeCourtController())
        }
        
        frostedController = REFrostedViewController(contentViewController: navigationController, menuViewController: SideMenuViewController())
        frostedController.direction = .left
        frostedController.panGestureEnabled = true
    }
    
    fileprivate func loadLoginView() {
        navigationController = nil
        frostedController = nil
        navigationController = BaseNavigationController(rootViewController: LoginViewController())
    }
    
}

