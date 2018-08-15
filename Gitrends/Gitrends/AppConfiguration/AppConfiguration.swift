/*********************************************************************
 Project Name : Gitrends
 
 File Name : AppConfiguration.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 16/08/18
 
 Description of File: Wrapper class used to access the urls based on the environment set. Reads the AppConfiguration.plist.
 *********************************************************************/
//
//  AppConfiguration.swift
//  DunToday
//
//  Created by JYOTSNA on 09/08/17.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import Foundation


//Keys
struct APP_CONFIGURATION_KEY {
    static let CONFIGURATION_ENVIRONMENT = "ConfigurationEnvironment"
    static let CONFIGURATION_FILE_NAME = "AppConfiguration"
    static let CONFIGURATION_FILE_TYPE = "plist"
    
    static let BASE_URL = "BaseURL"
}

class AppConfiguration {
    //MARK: - Properties
    var configuration: String!
    var variables: [String:Any]!
    
    static let sharedConfiguration = AppConfiguration()
    
    //MARK: - Initialization Methods
    
    fileprivate init() {
        //Fetch current configuration from info.plist
        let mainBundle: Bundle = Bundle.main
        self.configuration = mainBundle.infoDictionary?[APP_CONFIGURATION_KEY.CONFIGURATION_ENVIRONMENT] as! String
        print("Current Environment -> \(self.configuration)")
        
        //Load configuration from AppConfiguration.plist file
        let path: String = mainBundle.path(forResource: APP_CONFIGURATION_KEY.CONFIGURATION_FILE_NAME, ofType: APP_CONFIGURATION_KEY.CONFIGURATION_FILE_TYPE)!
        let configurations = NSDictionary(contentsOfFile: path) as! [String:Any]
        
        //Load data in variables based on current configuration
        self.variables = configurations[self.configuration] as! [String:Any]
        
    }
    
    //MARK: - Public static methods to access the AppConfiguration.plist keys
    
    /**
     Method returns the current environment configuration value set in info.plist
     **/
    static func currentConfiguration() -> String {
        return sharedConfiguration.configuration
    }
    
    /**
     Method returns the Base URL fo the server api call.
     **/
    static func BaseURL() -> String {
        if sharedConfiguration.variables != nil {
            return sharedConfiguration.variables[APP_CONFIGURATION_KEY.BASE_URL] as! String
        }
        return ""
    }
}


