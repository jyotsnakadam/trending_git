/*********************************************************************
 Project Name : Gitrends
 
 File Name : APIManager.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 16/08/18
 
 Description of File: This is created to manage the API with the help of thirf party Alamofire library.
 From here we do request to the server & get back the respose. It handle all type of request method.
 *********************************************************************/
//
//  APIManager.swift
//  Gitrends
//
//  Created by JYOTSNA  on 16/08/18.
//  Copyright © 2018 JYOTSNA . All rights reserved.
//

import UIKit
import SystemConfiguration
import Alamofire
import MBProgressHUD

typealias APIResult = (Bool,Any?,String?) -> ()

enum HTTPMethodType:Int {
    case GET = 1
    case POST = 2
    case PUT = 3
    case DELETE = 4
}

class APIManager: NSObject {
    
    //MARK: - Properties
    
    static let sharedInstance: APIManager = {
        let instance = APIManager()
        
        // setup code
        
        return instance
    }()
    
    
    //MARK: - Private Methods
    
    /**
     Checks if internet is available or not
     Returns: Bool value based on internet connection availability
     **/
    private func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    //MARK: - Public Methods
    
    /**
     Generic method that makes a webservice call using Alamofire
     Parameters: url - webservice url
     method - HTTPMethodType value (GET/POST)
     parameters - dictionary to pass to the webservice as parameters
     headers - distionary that holds the headers to be passed to the request
     parentViewController - the viewcontroller reference to show the progress view
     completion - the completion block to send the response data back to the callee
     **/
    public func apiRequest(url:String, method: HTTPMethodType, parameters: [String:Any]?, headers:[String:String]?, parentViewController: UIViewController, showProgress: Bool = true, completion:@escaping APIResult) {
        
        //Check if internet is available
        if !self.connectedToNetwork() {
            completion(false, nil, INTERNET_NOT_AVAILABLE)
            return
        }
        //Show progress view
        if showProgress {
            MBProgressHUD.showAdded(to: parentViewController.view, animated: true)
        }
        
        var httpMethodValue: HTTPMethod!
        switch method {
        case HTTPMethodType.GET:
            httpMethodValue = HTTPMethod.get
            break
        case HTTPMethodType.POST:
            httpMethodValue = HTTPMethod.post
            break
        case HTTPMethodType.PUT:
            httpMethodValue = HTTPMethod.put
            break
        case HTTPMethodType.DELETE:
            httpMethodValue = HTTPMethod.delete
            break
        }
        
        print("parameters = \(String(describing: parameters))")
        
        Alamofire.request(url, method: httpMethodValue, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                print("Request = \(String(describing: response.request))")
                print("Response = \(String(describing: String(data: response.data!, encoding: String.Encoding.utf8)))")
                print("API Response = \(response)")
                
                //Hide progress view
                if showProgress {
                    MBProgressHUD.hide(for: parentViewController.view, animated: true)
                }
                
                var message: String!
                
                //Check for the response result and take actions
                switch(response.result) {
                case .success:
                    if let httpStatusCode = response.response?.statusCode {
                        switch(httpStatusCode) {
                        case ResponseCode.RequestOK:                     //200
                            completion(true, response.result.value, nil)
                            return
                        case ResponseCode.RequestSyntactIncorrect:       //400
                            message = String(data: response.data!, encoding: String.Encoding.utf8)
                            break
                        case ResponseCode.UnAuthorized:                 //401
                            message = String(data: response.data!, encoding: String.Encoding.utf8)
                            break
                        case ResponseCode.MethodNotFound:               //405
                            message = String(data: response.data!, encoding: String.Encoding.utf8)
                            break
                        case ResponseCode.InternalServerError:          //500
                            message = String(data: response.data!, encoding: String.Encoding.utf8)
                            break
                        case ResponseCode.UserSessionTimeOut:
                            message = USER_SESSION_TIMEOUT
                            break
                        default:
                            message = String(data: response.data!, encoding: String.Encoding.utf8)
                            break
                        }
                    }
                    completion(false, nil, message)
                    break
                case .failure:
                    message = FETCHING_DATA_ERROR
                    if response.error != nil {
                        let responseString = String(data: response.data!, encoding: String.Encoding.utf8)!
                        if !responseString.isEmpty {
                            message = responseString
                        } else {
                            message = response.error?.localizedDescription
                        }
                    }
                    completion(false, nil, message)
                    return
                }
        }
    }
    
    
    
    public func apiRequestFromArray(url:String, method: HTTPMethodType, parameters: NSArray?, headers:NSMutableDictionary?, parentViewController: UIViewController, completion:@escaping APIResult) {
        
        
        //Check if internet is available
        if !self.connectedToNetwork() {
            completion(false, nil, INTERNET_NOT_AVAILABLE)
            return
        }
        //Show progress view
        MBProgressHUD.showAdded(to: parentViewController.view, animated: true)
        
        var httpMethodValue: HTTPMethod!
        switch method {
        case HTTPMethodType.GET:
            httpMethodValue = HTTPMethod.get
            break
        case HTTPMethodType.POST:
            httpMethodValue = HTTPMethod.post
            break
        case HTTPMethodType.PUT:
            httpMethodValue = HTTPMethod.put
            break
        case HTTPMethodType.DELETE:
            httpMethodValue = HTTPMethod.delete
            break
        }
        
        print("parameters = \(String(describing: parameters))")
        
        guard let endpoint = URL(string: url) else {
            
            print("Error creating endpoint");
            return }
        
        var request = URLRequest(url: endpoint)
        
        request.httpMethod = httpMethodValue.rawValue
        if parameters != nil
        {
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameters!)
        }
        
        let keysArray = headers?.allKeys
        print(keysArray)
        for key in keysArray!
        {
            request.setValue(String(describing: headers!.value(forKey: key as! String)!), forHTTPHeaderField:key as! String)
            
        }
        
        Alamofire.request(request).responseJSON { (response) in
            
            print("Request = \(String(describing: response.request))")
            print("Response = \(String(describing: String(data: response.data!, encoding: String.Encoding.utf8)))")
            print("API Response = \(response)")
            
            //Hide progress view
            MBProgressHUD.hide(for: parentViewController.view, animated: true)
            
            
            var message: String!
            
            //Check for the response result and take actions
            switch(response.result) {
            case .success:
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case ResponseCode.RequestOK:                     //200
                        completion(true, response.result.value, nil)
                        return
                    case ResponseCode.RequestSyntactIncorrect:       //400
                        message = String(data: response.data!, encoding: String.Encoding.utf8)
                        break
                    case ResponseCode.UnAuthorized:                 //401
                        message = String(data: response.data!, encoding: String.Encoding.utf8)
                        break
                    case ResponseCode.MethodNotFound:               //405
                        message = String(data: response.data!, encoding: String.Encoding.utf8)
                        break
                    case ResponseCode.InternalServerError:          //500
                        message = String(data: response.data!, encoding: String.Encoding.utf8)
                        break
                    case ResponseCode.UserSessionTimeOut:
                        message = USER_SESSION_TIMEOUT
                        break
                    default:
                        message = String(data: response.data!, encoding: String.Encoding.utf8)
                        break
                    }
                }
                completion(false, nil, message)
                break
            case .failure:
                message = FETCHING_DATA_ERROR
                if response.error != nil {
                    let responseString = String(data: response.data!, encoding: String.Encoding.utf8)!
                    if !responseString.isEmpty {
                        message = responseString
                    } else {
                        message = response.error?.localizedDescription
                    }
                }
                completion(false, nil, message)
                return
            }
            
        }
    }
    
}




