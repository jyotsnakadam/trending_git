/*********************************************************************
 Project Name : Gitrends
 
 File Name : CommonExtension.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 21/08/18
 
 Description of File: This is a CommonExtension class which we use to keep common extension written for library classes
 *********************************************************************/
//
//  CommonExtension.swift
//  Gitrends
//
//  Created by JYOTSNA  on 21/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        
        if self.image == nil || urlString.lowercased() == "no image" {
            self.image = PlaceHolderImage
            return
        }
        //Add a progress indicator
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(.gray)
        //Get image
        self.sd_setImage(with: URL(string:urlString), placeholderImage: PlaceHolderImage)
        
    }
    
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage, completion:@escaping (_ success:Bool)->Void) {
        
        if self.image == nil || urlString.lowercased() == "no image" {
            self.image = PlaceHolderImage
            return
        }
        
        //Add a progress indicator
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(.white)
        //Get image
        self.sd_setImage(with: URL(string:urlString), placeholderImage: PlaceHolderImage) { (image, error, cacheType, imageUrl) in
            if error != nil {
                print(error ?? "No Error")
                completion(false)
            } else {
                completion(true)
            }
        }
        
    }
    
    
}


