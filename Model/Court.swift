//
//  Court.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 22/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class Court: NSObject {
        
    // MARK: - Attributes -
    var homeCourtId : String = ""
    var homeCourtName : String = ""

    var openTime : String = ""
    var closeTime : String = ""

    var courtType : String = ""
    var numberOfCourts : String = ""
    var lights : String = ""
    var gameType : String = ""
    var membershipStatus : String = ""
    var dayCost : String = ""
    var homeCourtProfilePicUrl : String = ""
    
    var address : String = ""
    var cityId : String = ""
    var latitude : String = ""
    var longitude : String = ""
    
    var color : String = ""
    var numberOfPlayers : String = ""
    
    var schedules : [Schedule] = [Schedule]()
    
    required override init() {
        super.init()
    }
    
    convenience init(responseDictionary : NSDictionary){
        self.init()
        self.setValue(responseDictionary: responseDictionary)
        
    }
    
    // MARK: - Public Interface -
    
    // MARK: - Internal Helpers -
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
    // MARK: - NSCopying Delegate Method -
    
    func copy(with zone: NSZone?) -> Any {
        return type(of: self).init()
    }
}
