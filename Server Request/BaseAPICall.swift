//
//  BaseAPICall.swift
//
//
//  Created by WebMob on 28/09/16.
//
//

import UIKit
import Alamofire

// MARK: - API Task Constant -
enum APITask : String {
    case Login = "Login"
    case Register = "Register"
    case ChangePassword = "change password"
    case Logout = "Logout"
    case ForgotPassword = "ForgotPassword"
    case AddFriend = "Add friend"
    case RemoveFriend = "Remove friend"
    case searchPeople = "searchPeople"
    case LoadFriends = "loadFriends"
    case EditProfile = "EditProfile"
    case CreateProfile = "CreateProfile"
    case FetchHomeCourts = "FetchHomeCourts"
    case FetchUserDetails = "FetchUserDetails"
    case AddHomeCourt = "AddHomeCourt"
    case AddUserHomeCourt = "AddUserHomeCourt"
    case RateUser = "RateUser"
    case AddSchedule = "AddSchedule"
    case FriendsFeed = "FriendsFeed"
    case ThereNow = "ThereNow"
    case ThereLater = "thereLater"
    case CheckWhosThereNow = "CheckWhosThereNow"
    case CheckWhosThereLater = "CheckWhosThereLater"
    case Payment = "Payment"
    case AboutApp = "aboutApp"
}

enum Result {
    case Success(response : AnyObject?,error : BaseError?)
    case Error(error : BaseError?)
    case Internet(isOn : Bool)
}

class BaseAPICall: NSObject {
    
  
    
    class var shared: BaseAPICall {
        struct Static {
            static var instance: BaseAPICall?
        }
        
        let _onceToken = NSUUID().uuidString
        
        
        DispatchQueue.once(token: _onceToken) {
            Static.instance = BaseAPICall()
            
        }

        return Static.instance!
    }
    
    
    func postRequestUsingBody(URL url : String , Parameter param : NSDictionary , Type type : APITask, completionHandler : @escaping (_ result : Result) -> ())
    {
        AppUtility.isNetworkAvailableWithBlock { (isAvailable) in
            if isAvailable == true
            {
                completionHandler(Result.Internet(isOn: true))
              
                var requestURL : String! = APIConstant.baseURL + url
                
                let parameterString : String = self.getURLString(fromDictionary: param)
                
                print("---------------------");
                print("\(type.rawValue) request :- \(param .JSONString())")
                print("Request URL :- \(requestURL)")
                print("---------------------");
                
                var requset : URLRequest = URLRequest(url: URL(string: requestURL)!)
                
                requset.httpMethod = "POST"
                requset.timeoutInterval = 30.0
                requset.httpBody = parameterString .data(using: String.Encoding.utf8)
                requset.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                Alamofire.request(requset).responseJSON(completionHandler: { (response) in
                    switch response.result
                    {
                    case .success(let responseJSON):
                        
                        guard let dicResponse = responseJSON as? NSDictionary else{
                            return
                        }
                        
                        print("Response : \((dicResponse) .JSONString())")
                        
                        var handledResopnse : (BaseError? , AnyObject?)! = self.handleResponse(response: dicResponse, task: type)
                        
                        if handledResopnse.1 != nil{
                            completionHandler(Result.Success(response: handledResopnse.1, error: handledResopnse.0))
                        }
                        else{
                            completionHandler(Result.Error(error: handledResopnse.0))
                        }
                        defer{
                            handledResopnse = nil
                        }
                        break
                    case .failure(let error):
                        completionHandler(Result.Error(error: self.handleFailure(error: error)))
                        break
                    }
                })
                requestURL = nil
            }
            else{
                completionHandler(Result.Internet(isOn: false))
            }
        }
    }
    
    func postReques(URL url : String , Parameter param : NSDictionary , Type type : APITask, completionHandler : @escaping (_ result : Result) -> ()){
        AppUtility.isNetworkAvailableWithBlock { (isAvailable) in
            if isAvailable == true{
                completionHandler(Result.Internet(isOn: true))
                
                var requestURL : String! = APIConstant.baseURL + url
                let headers = [
                    "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                    "Accept": "application/json"
                    
                ]
                
                print("---------------------")
                if type != .Payment
                {
                    print("\(type.rawValue) request :- \(param .JSONString())")
                }
                
                print("Request URL :- \(requestURL)")
                print("---------------------")
                
                Alamofire.request(requestURL, method:.post, parameters: param as? Parameters, encoding: URLEncoding(destination: .httpBody), headers: headers).responseJSON(completionHandler: { (response) in
                    
                                        
                    switch response.result
                    {
                    case .success(let responseJSON):
                        
                        guard let dicResponse = responseJSON as? NSDictionary else{
                            return
                        }
                        
                        print("Response : \((dicResponse) .JSONString())")
                        
                        var handledResopnse : (BaseError? , AnyObject?)! = self.handleResponse(response: dicResponse, task: type)
                        
                        if handledResopnse.1 != nil{
                            completionHandler(Result.Success(response: handledResopnse.1, error: handledResopnse.0))
                        }
                        else{
                            completionHandler(Result.Error(error: handledResopnse.0))
                        }
                        defer{
                            handledResopnse = nil
                        }
                        break
                    case .failure(let error):
                        completionHandler(Result.Error(error: self.handleFailure(error: error)))
                        break
                    }
                })
                
                requestURL = nil
                
            }
            else{
                completionHandler(Result.Internet(isOn: false))
            }
        }
    }
    
    
    func getRequest(URL url : String , Parameter param : NSDictionary , Task type : APITask, completionHandler : @escaping (_ result : Result) -> ()) -> Void
    {
        
        AppUtility.isNetworkAvailableWithBlock { (isAvailable) in
            if isAvailable == true{
                completionHandler(Result.Internet(isOn: true))
                var requestURL : String! = APIConstant.baseURL + url
                
                print("---------------------")
                print("\(type.rawValue) request :- \(param .JSONString())")
                print("Request URL :- \(requestURL)")
                print("---------------------")
                
                Alamofire.request(requestURL, method:.get, parameters: param as? Parameters, encoding: URLEncoding(destination: .httpBody), headers: [:]).responseJSON(completionHandler: { (response) in
                    switch response.result
                    {
                    case .success(let responseJSON):
                        
                        guard let dicResponse = responseJSON as? NSDictionary else{
                            return
                        }
                        
                        print("Response : \((dicResponse) .JSONString())")
                        
                        var handledResopnse : (BaseError? , AnyObject?)! = self.handleResponse(response: dicResponse, task: type)
                        if handledResopnse.1 != nil
                        {
                            completionHandler(Result.Success(response: handledResopnse.1, error: handledResopnse.0))
                        }
                        else
                        {
                            completionHandler(Result.Error(error: handledResopnse.0))
                        }
                        
                        defer{
                            handledResopnse = nil
                        }
                        
                        break
                    case .failure(let error):
                        completionHandler(Result.Error(error: self.handleFailure(error: error)))
                        break
                    }
                })
            }
            else{
                completionHandler(Result.Internet(isOn: false))
            }
        }
    }
    
    func uploadImage (url: String, Parameter param : NSDictionary, Images arrImage: NSArray, Type type : APITask , completionHandler : @escaping (_ result : Result) -> ()) -> Void
    {
        
        AppUtility.isNetworkAvailableWithBlock { (isAvailable) in
            
            if isAvailable == true{
                completionHandler(Result.Internet(isOn: true))
                var requestURL : String! = APIConstant.baseURL + url
                let headers = [
                    "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                    "Accept": "application/json"
                ]
                
                print("---------------------")
                print("\(type.rawValue) request :- \(param .JSONString())")
                print("Request URL :- \(requestURL)")
                print("---------------------")
                
                
                Alamofire.upload(multipartFormData: { (data) in
                    
                    for (key, value) in param {
                        let strValue : String = String(describing: value)
                        data.append((strValue).data(using: .utf8)!, withName: key as! String)
                    }
                    
                    for imageInfo in arrImage
                    {
                        var dicInfo : NSDictionary! = imageInfo as! NSDictionary
                        data.append(dicInfo["data"] as! Data, withName: dicInfo["name"] as! String, fileName: dicInfo["fileName"] as! String, mimeType: dicInfo["type"] as! String)
                        dicInfo = nil
                    }
                    
                }, to: requestURL, method: .post , headers:headers, encodingCompletion: { (encodeResult) in
                    switch encodeResult {
                    case .success(let upload, _, _):
                        
                        upload.responseJSON(completionHandler: { (response) in
                            
                            switch response.result
                            {
                            case .success(let responseJSON):
                                guard let dicResponse = responseJSON as? NSDictionary else{
                                    return
                                }
                                
                                print("Response : \((dicResponse) .JSONString())")
                                
                                var handledResopnse : (BaseError? , AnyObject?)! = self.handleResponse(response: dicResponse, task: type)
                                
                                if handledResopnse.1 != nil{
                                    completionHandler(Result.Success(response: handledResopnse.1, error: handledResopnse.0))
                                }
                                else{
                                    completionHandler(Result.Error(error: handledResopnse.0))
                                }
                                
                                defer{
                                    handledResopnse = nil
                                }
                                
                            case .failure(let error):
                                
                                print(error)
                                completionHandler(Result.Error(error: self.handleFailure(error: error)))
                                break
                            }
                        })
                    case .failure(let error):
                        completionHandler(Result.Error(error: self.handleFailure(error: error)))
                        break
                    }
                })
            }
            else{
                completionHandler(Result.Internet(isOn: false))
            }
        }
    }
    
    private func handleResponse(response : AnyObject,task : APITask) -> (BaseError? , AnyObject?){
        
        if let metaData : NSDictionary = response["meta"] as? NSDictionary {
            var baseError : BaseError! = BaseError.getError(responseObject: metaData, task: task)
            
            if baseError.errorCode == "200" { // 1 is success code, here we need to set success code as per project and api backend. its may 1 or 200, depend on API
                var modelResponse : AnyObject! = MainResponse().getModelFromResponse(response: response , task: task)
                defer{
                    modelResponse = nil
                    baseError = nil
                }
                return (baseError,modelResponse)
            }
            else{
                defer{
                    baseError = nil
                }
                return (baseError, nil)
            }
        }
        else {
            return(nil, nil)
        }
    }
    
    private func handleFailure(error : Error) -> BaseError{
        
        print("Error : \(error.localizedDescription)")
        
        var baseError : BaseError! = BaseError()
        
        switch error._code {
        case NSURLErrorTimedOut:
            baseError.errorCode = String(error._code)
            baseError.alertMessage = "Server is not responding please try again after some time."
            baseError.serverMessage = "Server is not responding please try again after some time."
            break
        case NSURLErrorNetworkConnectionLost:
            baseError.errorCode = String(error._code)
            baseError.alertMessage = "Network connection lost try again."
            baseError.serverMessage = "Network connection lost try again."
            break
        default:
            baseError.errorCode = String(-1)
            baseError.alertMessage = "Something went wrong please try again later!"
            baseError.serverMessage = "Something went wrong please try again later!"
            break
        }
        
        defer{
            baseError = nil
        }
        return baseError
    }
    
    private func getURLString(fromDictionary dictionary: NSDictionary) -> String {
        var urlStringWithDetailsArray = [Any]()
        
        for (key,value) in dictionary{
            
            if value is NSNumber{
                urlStringWithDetailsArray.append("\(key)=\(String(value as! Int).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)")
            }
            else if value is NSArray {
                urlStringWithDetailsArray.append("\(key)=\((value as! NSArray).JSONString())")
            }
            else{
                urlStringWithDetailsArray.append("\(key)=\((value as! String).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)")
            }
        }
        
        return (urlStringWithDetailsArray as NSArray).componentsJoined(by: "&")
    }
    
    
}
