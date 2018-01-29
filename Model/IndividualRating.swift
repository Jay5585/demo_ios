//
//  IndividualRating.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 30/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class IndividualRating: NSObject,NSMutableCopying {
    
    // MARK: - Attributes -
    var score : String = "0"
    var skills : [Skill] = [Skill]()
    
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
                else if value is NSArray && key == "skills" {
                    var tempSKill : [Skill]! = [Skill]()
                    for (_, skill) in (value as! NSArray).enumerated() {
                        tempSKill.append(Skill(responseDictionary: skill as! NSDictionary))
                    }
                    self.skills = tempSKill
                    tempSKill = nil
                }
            }
        }
    }
    
    
    
    // MARK: - NSCopying Delegate Method -
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        return getMutable()
    }
    
    private func getMutable() -> IndividualRating{
        
        let object : IndividualRating = IndividualRating()
        object.score = self.score
        for skill in self.skills{
            object.skills.append(skill.mutableCopy() as! Skill)
        }
        return object
    }
}
