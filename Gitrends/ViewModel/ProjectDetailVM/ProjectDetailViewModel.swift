/*********************************************************************
 Project Name : Gitrends
 
 File Name : ProjectDetailViewModel.swift
 
 Owner of File : 21/08/18
 
 Created Date: 16/08/18
 
 Description of File: This is a view model file is used to get the al detailsrelated to project.
 It read the image from image url
 It get data of read me from weburl
 *********************************************************************/
//
//  ProjectDetailViewModel.swift
//  Gitrends
//
//  Created by JYOTSNA  on 21/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit

class ProjectDetailViewModel: NSObject {
    private var trendProject : TrendProject!
    private var avatar : Avatar!
    private var readMe : ReadMe!
    
    
    //MARK: - Setter method
    /**
     @method : This methods is used to set the project detail object detail
     @parameter :
                Project name, user name, start, forks
    **/
    func setProjectDetail(projectDict:[String:String])
    {
        trendProject = TrendProject(trendprojectDict: projectDict)
    }
    
    //MARK: - Getter Methods
    /**
     @method: This method call the webservice API to get the avatar url
     @parameter:
        parentViewController - This is used to show progress hud on the top of the view
     **/
    func getAvatar(parentViewController: UIViewController, completionBlock: @escaping (Bool) -> ())
    {
        self.callAvatarUrl(parentViewController: parentViewController) { (success, response, errorMsg) in
            if success{
                self.avatar = Avatar(projectDict: response as! [String : Any])
            }
            else
            {
                let errorAlert  = Utility.createAlertWithoutAction(alertIdentifier: "", messageString: NO_TRENDS, title: "Alert")
                parentViewController.present(errorAlert, animated: true, completion: nil)
            }
            completionBlock(success)
        }
    }
    
    /**
     @method: This method call the webservice API to get the Read Me
     @parameter:
        parentViewController - This is used to show progress hud on the top of the view
     **/
    func getReadMe(parentViewController: UIViewController, completionBlock: @escaping (Bool) -> ())
    {
        self.callReadMeUrl(parentViewController: parentViewController) { (success, response, errorMsg) in
            if success{
                self.readMe = ReadMe(readMeDict: response as! [String : Any])
            }
            else
            {
                let errorAlert  = Utility.createAlertWithoutAction(alertIdentifier: "", messageString: NO_TRENDS, title: "Alert")
                parentViewController.present(errorAlert, animated: true, completion: nil)
            }
            completionBlock(success)
        }
    }
    
    //This method get the avatar url
    func getAvatarURL()->String
    {
        return avatar.avatarUrl
    }
    
    //This method get the read me url
    func getReadMeURL()->String
    {
        return readMe.readMeUrl
    }
    
    //MARK: - Webservice Methods
    /**
     @method: This method get called when we request to get the user avatar
     Parameters: nil
        parentViewController - the view controller reference which has called this method
        completionBlock - the completionresult of the api call is send back to the callee
     **/
    func callAvatarUrl(parentViewController: UIViewController, completionBlock:@escaping APIResult)
    {
        //Construct header to pass to api call
        let headers: [String:String] = ["Content-Type":"application/json"]
        
        //Construct Project Detail url
        let avatarLink = AppConfiguration.BaseURL() + "repos/" + trendProject.userName + "/" + trendProject.projectName
        
        
        //Call APIManager method to process the request
        APIManager.sharedInstance.apiRequest(url: avatarLink, method: HTTPMethodType.GET, parameters: nil, headers: headers, parentViewController: parentViewController) { (success, response, errorMsg) in
            if success {
                if let responseValue = response as? [String:Any] {
                    completionBlock(true, responseValue, nil)
                }
            } else {
                completionBlock(false, response, errorMsg)
            }
            //completionBlock(success, response, errorMsg)
        }
        
    }
    
    /**
     @method: This method get called when we request to get the project read me detail
     Parameters: nil
        parentViewController - the view controller reference which has called this method
        completionBlock - the completionresult of the api call is send back to the callee
     **/
    func callReadMeUrl(parentViewController: UIViewController, completionBlock:@escaping APIResult)
    {
        //Construct header to pass to api call
        let headers: [String:String] = ["Content-Type":"application/json"]
        
        //Construct Read Me Detail url
        let readMeLink = AppConfiguration.BaseURL() + "repos/" + trendProject.userName + "/" + trendProject.projectName + "/readme"
        
        
        //Call APIManager method to process the request
        APIManager.sharedInstance.apiRequest(url: readMeLink, method: HTTPMethodType.GET, parameters: nil, headers: headers, parentViewController: parentViewController) { (success, response, errorMsg) in
            if success {
                if let responseValue = response as? [String:Any] {
                    completionBlock(true, responseValue, nil)
                }
            } else {
                completionBlock(false, response, errorMsg)
            }
            //completionBlock(success, response, errorMsg)
        }
        
    }

}
