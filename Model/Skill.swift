//
//  Skill.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 30/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class Skill: NSObject,NSMutableCopying
{
    
    // MARK: - Attributes -
    var skillId : String = ""
    var skillName : String = ""
    
    var individualScore : String = "0"
    var individualScoreAverage : String = ""
    
    required override init() {
        super.init()
    }
    
    convenience init(responseDictionary : NSDictionary){
        self.init()
        self.setValueFromDictionary(responseDictionary)
        
    }
    
    // MARK: - Public Interface -
    
    // MARK: - Internal Helpers -
    
    
    // MARK: - NSCopying Delegate Method -
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        return self.getMutable()
    }
    
    
    private func getMutable() -> Skill{
        
        let object : Skill = Skill()
        object.individualScore = self.individualScore
        object.individualScoreAverage = self.individualScoreAverage
        object.skillId = self.skillId
        object.skillName = self.skillName
        return object
    }
}
