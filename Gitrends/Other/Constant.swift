/*********************************************************************
 Project Name : Gitrends
 
 File Name : Constant.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 16/08/18
 
 Description of File: This is a constant file created to keep all constant values, messages, api, structure at one place.
 *********************************************************************/
//
//  Constant.swift
//  Gitrends
//
//  Created by JYOTSNA  on 16/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit
import Foundation

//List of webservices
struct WebservicesURL{
    //Common
    static let TrendListURL = "repositories?language=javascript&since=today"
}

//Title Name
let GIT_HUB_TITLE = "Github Trends"

//TableView Cell ID
let TREND_PROJECT_LIST_CELL_ID = "TrendProjectListCellID"

//Error Messages
let INTERNET_NOT_AVAILABLE = "Please check your internet connection!"
let USER_SESSION_TIMEOUT = "User session timeout!"
let FETCHING_DATA_ERROR = "There was some error fetching data!"
let NO_TRENDS = "There is no trending data available"


//URL Constants
struct ResponseCode{
    static let RequestOK                = 200
    static let RequestSyntactIncorrect  = 400
    static let UnAuthorized             = 401
    static let MethodNotFound           = 405
    static let InternalServerError      = 500
    static let PreConditionFailed       = 412
    static let UserSessionTimeOut       = 418
}



