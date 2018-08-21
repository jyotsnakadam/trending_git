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
    static let PROJECT_NAME = "name"
    static let PROJECT_STAR = "stars"
    static let PROJECT_DETAIL = "description"
    static let USER_NAME = "author"
    static let PROJECT_FORKS = "forks"
}

//MARK: - TrendProject Class
class TrendProject{
//Properties
    var projectName : String = ""
    var projectStar : String = ""
    var projectDetail : String = ""
    var userName : String = ""
    var forks : String = ""
    
    init(trendprojectDict: [String:Any]) {
        self.projectName = trendprojectDict[TREND_PROJECT_KEY.PROJECT_NAME] as? String ?? ""
        let star = trendprojectDict[TREND_PROJECT_KEY.PROJECT_STAR] as? Int ?? 0
        self.projectStar = "\(star)"
        self.projectDetail = trendprojectDict[TREND_PROJECT_KEY.PROJECT_DETAIL] as? String ?? ""
        self.userName = trendprojectDict[TREND_PROJECT_KEY.USER_NAME] as? String ?? ""
        let fork = trendprojectDict[TREND_PROJECT_KEY.PROJECT_FORKS] as? Int ?? 0
        self.forks = "\(fork)"
    }
}
