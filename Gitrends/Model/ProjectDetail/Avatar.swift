/*********************************************************************
 Project Name : Gitrends
 
 File Name : Avatar.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 21/08/18
 
 Description of File: This model file is created to keep data in one wrapper to access Project detail easily
 *********************************************************************/
//
//  Avatar.swift
//  Gitrends
//
//  Created by JYOTSNA  on 21/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit

//MARK:- Trend Project Keys
struct AVATAR_KEY{
    static let OWNER = "owner"
    static let AVATAR_URL = "avatar_url"
}

class Avatar{
    
    //Properties
    var avatarUrl : String = ""
    
    init(projectDict: [String:Any]) {
        let ownerDict =  projectDict[AVATAR_KEY.OWNER] as? [String : Any] ?? nil
        //check if owner dict nil ot not
        guard ownerDict != nil else
        {
            return
        }
        avatarUrl = ownerDict![AVATAR_KEY.AVATAR_URL] as? String ?? ""
    }

}
