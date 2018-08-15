/*********************************************************************
 Project Name : Gitrends
 
 File Name : TrendProject.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 16/08/18
 
 Description of File: This model file is created to keep data in one wrapper to access easily
 *********************************************************************/
//
//  TrendProject.swift
//  Gitrends
//
//  Created by JYOTSNA  on 16/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit

//MARK:- Trend Project Keys
struct TREND_PROJECT_KEY{
    static let PROJECT_NAME = "projectname"
    static let PROJECT_STAR = "projectstar"
    static let PRJECT_DETAIL = "projectdetail"
}

//MARK: - TrendProject Class
class TrendProject{
//Properties
    var projectName : String = ""
    var projectStart : String = ""
    var prjectDetail : String = ""
    
    init(trendprojectDict: [String:Any]) {
        
        
    }
}
