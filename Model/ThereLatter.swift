//
//  ThereLatter.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 01/06/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit

class ThereLatter: NSObject {
    // MARK: - Attributes -
    
    var isHidden : Bool = false
    
    var headerTime : String = ""
    var schedules : [Schedule] = [Schedule]()
    
    required override init() {
        super.init()
    }
    
    // MARK: - Public Interface -
    
    // MARK: - Internal Helpers -
    // MARK: - NSCopying Delegate Method -
    
    func copy(with zone: NSZone?) -> Any {
        return type(of: self).init()
    }
}
