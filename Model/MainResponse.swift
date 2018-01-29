//
//  MainResponse.swift
//
//
//  Created by WebMob on 28/09/16.
//
//

import UIKit

class MainResponse: NSObject
{
    
    // MARK: - Attributes -
    
    var contactListArray:NSMutableArray!
    
    // MARK: - Lifecycle -
    required override init() {
        super.init()
    }
    
    // MARK: - Public Interface -
    func getModelFromResponse(response : AnyObject , task : APITask) -> AnyObject {
        var returnModel : AnyObject = response
        
        switch task {
        case .Login, .Register, .CreateProfile, .FetchUserDetails, .EditProfile, .RateUser:
            if let Data : NSDictionary = response["data"] as? NSDictionary {
                if let user : NSDictionary = Data["user"] as? NSDictionary {
                    return People(responseDictionary: user)
                }
            }
            break
            
        case .searchPeople, .LoadFriends :
            if let Data : NSDictionary = response["data"] as? NSDictionary {
                if let searchList : NSArray = Data["users"] as? NSArray {
                    var peopleArr : [People] = [People]()
                    
                    for (_, people) in searchList.enumerated() {
                        peopleArr.append(People(responseDictionary: people as! NSDictionary))
                    }
                    
                    returnModel = peopleArr as AnyObject
                }
                else {
                    returnModel = [People]() as AnyObject
                }
            }
            else {
                returnModel = [People]() as AnyObject
            }
            break

        case .FetchHomeCourts :
        if let Data : NSDictionary = response["data"] as? NSDictionary {
            if let homeCourt : NSArray = Data["homeCourts"] as? NSArray {
                var court : [Court] = [Court]()
                
                for (_, courtDetails) in homeCourt.enumerated() {
                    court.append(Court(responseDictionary: courtDetails as! NSDictionary))
                }
                
                returnModel = court as AnyObject
            }
            else {
                returnModel = [Court]() as AnyObject
            }
        }
        else {
            returnModel = [Court]() as AnyObject
        }
        break
            
        case .FriendsFeed :
            if let Data : NSDictionary = response["data"] as? NSDictionary {
                if let schedules : NSArray = Data["schedules"] as? NSArray {
                    var arrSchedul : [Schedule] = [Schedule]()
                    for (_, schedule) in schedules.enumerated() {
                        arrSchedul.append(Schedule(responseDictionary: schedule as! NSDictionary))
                    }
                    returnModel = arrSchedul as AnyObject
                }
            }
        break
            
        case .ThereNow, .ThereLater, .CheckWhosThereNow, .CheckWhosThereLater :
            if let Data : NSDictionary = response["data"] as? NSDictionary {
                if let court : NSDictionary = Data["homeCourt"] as? NSDictionary {
                    returnModel = Court(responseDictionary: court)
                }
            }
            break
            
        default:
            break
        }
        
        return returnModel
    }
    
    // MARK: - Internal Helpers -
    
    func getImageDictionary(response : AnyObject) -> NSMutableArray {
       
        let arrType : NSMutableArray = NSMutableArray()
        
        if let vehicleType = (response as! NSDictionary).object(forKey: "image_list") as? NSArray {
           
            for type in vehicleType {
                let vehicleType : NSString = ((type as! NSDictionary).object(forKey: "image_path") as? NSString)!
                arrType .add(vehicleType)
            }
        }
        
        return arrType
    }
    
}
