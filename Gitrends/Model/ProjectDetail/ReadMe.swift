/*********************************************************************
 Project Name : Gitrends
 
 File Name : ReadMe.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 21/08/18
 
 Description of File: This model file is created to keep data in one wrapper to access read me detail
 *********************************************************************/
//
//  ReadMe.swift
//  Gitrends
//
//  Created by JYOTSNA  on 21/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit

//MARK:- Trend Project Keys
struct READ_ME_KEY{
    static let README_URL = "download_url"
}

class ReadMe{
    
    //Properties
    var readMeUrl : String = ""
    
    init(readMeDict: [String:Any]) {
        //Read me download URL
        readMeUrl =  readMeDict[READ_ME_KEY.README_URL] as? String ?? ""
    }
    
}
