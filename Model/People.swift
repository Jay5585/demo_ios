//
//  People.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 16/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class People: NSObject,NSMutableCopying {
    
    // MARK: - Attributes -
    var userId : String = ""
    var firstName : String = ""
    var lastName : String = ""
    var nickName : String = ""
    var email : String = ""
    var phoneNumber : String = ""
    var userWeight : String = ""
    var userVertical : String = ""
    var userHeight : String = ""
    var userSchool : String = ""
    var homeTown : String = ""
    var profilePicUrl : String = ""
    var friendStatus : String = ""
    var homeCourtId : String = ""
    var homeCourt : Court? = nil
    
    var token : String = ""
    var paymentStatus : String = ""
    var birthDate : String = ""
    
    var statistics : Statistics = Statistics()
    var individualRatings : IndividualRating = IndividualRating()
    var schedules : [Schedule] = [Schedule]()
    
    required override init() {
        super.init()
    }
    
    convenience init(responseDictionary : NSDictionary){
        self.init()
        self.setValue(responseDictionary: responseDictionary)
    }
    
    // MARK: - Public Interface -
    func setValue(responseDictionary : NSDictionary) {
        
        let mirror = Mirror(reflecting: self)
        let allKey : [String] = mirror.proparty()
        
        for key in allKey {
            if let value = responseDictionary.value(forKey: key), !(value is NSNull) {
                if value is Int {
                    self.setValue(String(describing: value), forKey: key)
                }
                else if value is String {
                    self.setValue(value, forKey: key)
                }
                else if value is NSDictionary {
                    if key == "homeCourt" {
                        homeCourt = Court(responseDictionary: value as! NSDictionary)
                    }
                    else if key == "statistics" {
                        self.statistics = Statistics(responseDictionary: value as! NSDictionary)
                        
                    }
                    else if key == "individualRatings" {
                        self.individualRatings = IndividualRating(responseDictionary: value as! NSDictionary)
                        
                    }
                }
                else if value is NSArray && key == "schedules" {
                    var tempSchedule : [Schedule]! = [Schedule]()
                    for (_, schedule) in (value as! NSArray).enumerated() {
                        tempSchedule.append(Schedule(responseDictionary: schedule as! NSDictionary))
                    }
                    self.schedules = tempSchedule
                    tempSchedule = nil
                }
            }
        }
    }
    
    
    // MARK: - Internal Helpers -
    
    // MARK: - NSCopying Delegate Method -
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        return getMutable()
    }
    
    private func getMutable() -> People{
        
        let object : People = People()
        
        object.userId = self.userId
        object.firstName = self.firstName
        object.lastName = self.lastName
        object.nickName = self.nickName
        object.email = self.email
        object.phoneNumber = self.phoneNumber
        object.userWeight = self.userWeight
        object.userVertical = self.userVertical
        object.userHeight = self.userHeight
        object.userSchool = self.userSchool
        object.homeTown = self.homeTown
        object.profilePicUrl = self.profilePicUrl
        object.friendStatus = self.friendStatus
        object.homeCourtId = self.homeCourtId
        object.homeCourt = self.homeCourt
        object.token = self.token
        object.birthDate = self.birthDate
        object.paymentStatus = self.paymentStatus
        object.statistics = self.statistics.mutableCopy() as! Statistics
        object.individualRatings = self.individualRatings.mutableCopy() as! IndividualRating
        object.schedules = self.schedules
        
        return object
    }

}
