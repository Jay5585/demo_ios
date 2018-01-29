//
//  Constants.swift
//  ViewControllerDemo
//
//  Created by SamSol on 27/06/16.
//  Copyright © 2016 SamSol. All rights reserved.
//

import Foundation
import UIKit

//  MARK: - System Oriented Constants -

let appName : String = "Baller App"

struct SystemConstants {
    
    static let showLayoutArea = true
    static let hideLayoutArea = false
    static let showVersionNumber = 1
    
    static let IS_IPAD = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
    static let IS_DEBUG = false
}

struct General{
    static let textFieldColorAlpha : CGFloat = 0.5
    static let kCircleRadios : Double = 10.0
}

//  MARK: - Thired Party Constants -
struct ThiredPartyKey {
    static let googleMapKey = "AIzaSyASJCKSToEOlBQvFwTu1njXb1kUK7tmXKY"
    static let StripePublishableKey = "pk_test_uam6yNEbGTyUWMfoukMi14Tr"
}


//  MARK: - Server Constants -
struct APIConstant {
    
    //  Main Domain
    static let baseURL = "http://baller.cloudapp.net/api/"

    
    //  API - Sub Domain
    static let login = "login"
    static let logout = "logout"
    static let register = "register"
    static let changePassword = "changePassword"
    static let forgotPassword = "forgotPassword"
    static let addFriend = "addFriend"
    static let removeFriend = "removeFriend"
    static let searchPeople = "searchUser"
    static let loadFriends = "loadFriends" 
    static let editProfile = "editProfile"
    static let createProfile = "createProfile"
    static let fetchHomeCourts = "fetchHomeCourts"
    static let fetchUserDetails = "fetchUserDetails"
    static let addHomeCourt = "addHomeCourt"
    static let addUserHomeCourt = "addUserHomeCourt"
    static let rateUser = "rateUser"
    static let addSchedule = "addSchedule"
    static let friendsFeed = "friendsFeed"
    static let thereNow = "thereNow"
    static let thereLater = "thereLater"

    static let checkWhosThereNow = "checkWhosThereNow"
    static let checkWhosThereLater = "checkWhosThereLater"
    static let payment = "payment"
    static let aboutApp = "aboutApp"
}


//  MARK: - layoutTime Constants -
struct ControlLayout {
    
    static let name : String = "controlName"
    static let borderRadius : CGFloat = 3.0
    
    static let horizontalPadding : CGFloat = 8.0
    static let verticalPadding : CGFloat = 8.0
    static let secondaryHorizontalPadding : CGFloat = 15.0
    static let secondaryVerticalPadding : CGFloat = 15.0
    static let turneryHorizontalPadding : CGFloat = 22.0
    static let turneryVerticalPadding : CGFloat = 22.0
    
    static let txtBorderWidth : CGFloat = 1.5
    static let txtBorderRadius : CGFloat = 2.5
    static let textFieldHeight : CGFloat = 50.0
    static let textLeftPadding : CGFloat = 10.0
    
    static let KTextLeftPaddingFromControl : CGFloat = 10.0
}


//  MARK: - Cell Identifier Constants -
struct CellIdentifire {
    static let collectionViewCell  = "collectionViewCell"
    static let menuCell = "menuCell"
    static let friendsCell = "FriendsCell"
    static let peopleCell = "peopleCell"
    static let detailCell = "detailCell"
    static let friendFeedCell = "friendFeedCell"
    static let statasticCell = "statasticCell"
    static let rateUserCell = "rateUserCell"
    static let thereNowTableCell = "thereNowTableCell"
}

//  MARK: - Notification key -
struct NotificationKey {
    static let profileChange = "profileChange"
    static let friendRemove = "friendRemove"
    static let addFriend = "addFriend" 
    static let purchaseDone = "purchaseDone"
    static let rateUser = "rateUser"
}


//  MARK: - Info / Error Message Constants -
struct ErrorMessage {
    static let noInternet = "⚠️ Internet connection is not available."
    static let noCurrentLocation = "⚠️ Unable to find current location."
    static let noCameraAvailable = "⚠️ Camera is not available in device."
}

struct  DateFormate {
    static let KFullDate = "dd MMMM, yyyy"
}

struct UserDefaultKey {
    static let KUserId = "KUserId"
    static let KAccessTocken = "KAccessTocken"
    static let KEmailId = "KEmailId"
    static let KFullName = "FullName"
    static let KProfilePic = "ProfilePic"
    
    static let KHomeCourtId = "HomeCourtId"
    static let KisPlayed = "KisPlayed" 
    
}

// MARK: - Device Compatibility
struct currentDevice {
    static let isIphone = (UIDevice.current.model as NSString).isEqual(to: "iPhone") ? true : false
    static let isIpad = (UIDevice.current.model as NSString).isEqual(to: "iPad") ? true : false
    static let isIPod = (UIDevice.current.model as NSString).isEqual(to: "iPod touch") ? true : false
}

