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
    private var trendList = [TrendProject]()
    
    
    //MARK: - Getter Methods
    
    /**
     @method : This method ets the project detail
     @parameter:
     @return :
        [String:String] - It will return the project dict
    **/
    func getProjectDetail(index : Int)->[String:String]
    {
        let trend = trendList[index]
        let projectDict = [TREND_PROJECT_KEY.PROJECT_NAME:trend.projectName,
                           TREND_PROJECT_KEY.USER_NAME:trend.userName,
                           TREND_PROJECT_KEY.PROJECT_DETAIL:trend.projectDetail,
                           TREND_PROJECT_KEY.PROJECT_STAR:trend.projectStar,
                           TREND_PROJECT_KEY.PROJECT_FORKS:trend.forks]
        return projectDict
        
    }
    /**
     @method: This method call the webservice API to get the data
     @parameter:
            parentViewController - This is used to show progress hud on the top of the view
     **/
    func getTrendList(parentViewController: UIViewController, completionBlock: @escaping (Bool) -> ())
    {
        self.callTrendProjectList(parentViewController: parentViewController) { (success, response, errorMsg) in
            if success{
                for responseDict in response as! [[String : Any]]
                {
                    let trend = TrendProject(trendprojectDict: responseDict)
                    self.trendList.insert(trend, at: self.trendList.count)
                    
                }
            }
            else
            {
                let errorAlert  = Utility.createAlertWithoutAction(alertIdentifier: "", messageString: NO_TRENDS, title: "Alert")
                parentViewController.present(errorAlert, animated: true, completion: nil)
            }
            completionBlock(success)
        }
    }
    
    
    //MARK: - TableView Methods
    /**
     Method returns the number of sections for table view
     **/
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    /**
     Method returns the number of items for Trends Project table view
     **/
    func numberOfIRowsInTableView() -> Int {
        return trendList.count
    }
    
    /**
     Method setup's the  tableview cell at indexpath
     Parameters: indexPath - indexpath of the cell
     tableView - UITableView reference
     Returns: UITableViewCell object with data populated
     **/
    func setUpTrendListTableViewCell(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TREND_PROJECT_LIST_CELL_ID, for: indexPath) as! TrendProjectListTableViewCell
        let trend = trendList[indexPath.row]
        cell.projectNameLabel.text = trend.projectName
        cell.projectStarLabel.text = trend.projectStar
        cell.projectDetaiLabel.text = trend.projectDetail
        return cell
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
        let trendProjectList = AppConfiguration.TrendURL()
        
        //Call APIManager method to process the request
        APIManager.sharedInstance.apiRequest(url: trendProjectList, method: HTTPMethodType.GET, parameters: nil, headers: headers, parentViewController: parentViewController) { (success, response, errorMsg) in
            if success {
                if let responseValue = response as? [[String:Any]] {
                  completionBlock(true, responseValue, nil)
                }
            } else {
                completionBlock(false, response, errorMsg)
            }
            //completionBlock(success, response, errorMsg)
        }
        
    }

}
