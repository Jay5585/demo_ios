//
//  Schedule.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 30/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class Schedule: NSObject {
    
    // MARK: - Attributes -
    
    var timeFrom : String = ""
    var timeTo : String = ""
    var scheduleDate : String = ""
    var scheduleId : String = ""
    var duration : String = ""
    var scheduleStatus : String = "0"
    var homeCourt : Court = Court()
    var user = People()
    
    required override init() {
        super.init()
    }
    
    convenience init(responseDictionary : NSDictionary){
        self.init()
        self.setValue(responseDictionary: responseDictionary)
    }
    
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
                        self.homeCourt = Court(responseDictionary: value as! NSDictionary)
                    }
                    else if key == "user" {
                        self.user = People(responseDictionary: value as! NSDictionary)
                    }
                }
            }
        }
    }
   
}
