/*********************************************************************
 Project Name : Gitrends
 
 File Name : Utility.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 17/08/18
 
 Description of File: This is a Utility class keeps functions which we can reuse in project.
 *********************************************************************/
//
//  Utility.swift
//  Gitrends
//
//  Created by JYOTSNA  on 17/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    static func createAlertWithoutAction(alertIdentifier : String, messageString : String, title : String)->UIAlertController
    {
        let alert = UIAlertController(title: title, message: messageString, preferredStyle:.alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        alert.addAction(okAction)
        return alert
    }

}
