/*********************************************************************
 Project Name : Gitrends
 
 File Name : TrendListViewModel.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 16/08/18
 
 Description of File: This is a view model file is used to have communication between Trend Model class & TrendListViewController class. This file hanlde all the input & output operation.
 Here we fetch data from trend model & show it to Trend list view controller
 *********************************************************************/
//
//  TrendListViewModel.swift
//  Gitrends
//
//  Created by JYOTSNA  on 16/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit

class TrendListViewModel: NSObject {
    
    //Object Initialization
    var trendList = [TrendProject]()
    
    /**
     @method: This method call the webservice API to get the data
     @parameter:
            parentViewController - This is used to show progress hud on the top of the view
     **/
    func getTrendList(parentViewController: UIViewController)
    {
        self.callTrendProjectList(parentViewController: parentViewController) { (success, response, errorMsg) in
            if success{
                
            }
            else
            {
                
            }
        }
    }
    
    
    //MARK:- Webservice Methods
    /**
     @method: This method get called when we request for get the list of trneding projects
     Parameters: nil
     parentViewController - the view controller reference which has called this method
     completionBlock - the completionresult of the api call is send back to the callee
     **/
    func callTrendProjectList(parentViewController: UIViewController, completionBlock:@escaping APIResult)
    {
        //Construct header to pass to api call
        let headers: [String:String] = ["Content-Type":"application/json"]
        
        //Construct Trend Project List url
        //let trendProjectList = AppConfiguration.BaseURL() + WebservicesURL.TrendListURL + "?q=language&sort=stars&order=desc"
        let trendProjectList = AppConfiguration.BaseURL() + WebservicesURL.TrendListURL
        
        //Call APIManager method to process the request
        APIManager.sharedInstance.apiRequest(url: trendProjectList, method: HTTPMethodType.GET, parameters: nil, headers: headers, parentViewController: parentViewController) { (success, response, errorMsg) in
            if success {
                var message = ""
                if let responseValue = response as? [[String:Any]] {
                   print(responseValue)
                }
                completionBlock(true, message, nil)
            } else {
                completionBlock(false, response, errorMsg)
            }
            //completionBlock(success, response, errorMsg)
        }
        
    }

}
