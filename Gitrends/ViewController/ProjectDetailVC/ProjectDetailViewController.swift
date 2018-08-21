/*********************************************************************
 Project Name : Gitrends
 
 File Name : ProjectDetailViewController.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 21/08/18
 
 Description of File: This model file is to display the detail of the project
 *********************************************************************/

//  ProjectDetailViewController.swift
//  Gitrends
//
//  Created by JYOTSNA  on 21/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit
import WebKit

class ProjectDetailViewController: UIViewController {
    //Outlet parameter
    @IBOutlet weak var avatarImageView : UIImageView!
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var starsLabel : UILabel!
    @IBOutlet weak var forkLabel : UILabel!
    @IBOutlet weak var mdView : WKWebView!
    
    //Object for Project Detail View Model
    let projectDetailViewModel = ProjectDetailViewModel()
    var projectDict : [String:String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Private Methods
    private func setUpMethod()
    {
        //Here we set project detail data form dictionry to View model
        self.projectDetailViewModel.setProjectDetail(projectDict: projectDict)
        //Set all project detail data to outlet variable
        self.title = projectDict[TREND_PROJECT_KEY.PROJECT_NAME]
        self.userNameLabel.text = projectDict[TREND_PROJECT_KEY.USER_NAME]
        self.descriptionLabel.text = projectDict[TREND_PROJECT_KEY.PROJECT_DETAIL]
        let stars = projectDict[TREND_PROJECT_KEY.PROJECT_STAR]
        self.starsLabel.text = "\(String(describing: stars!)) Stars"
        let forks = projectDict[TREND_PROJECT_KEY.PROJECT_FORKS]
        self.forkLabel.text = "\(String(describing: forks!)) Forks"
        //Image crop in circle
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 50
        //call webAPI
        self.callAvatarData()
        self.callReadmeData()
    }
    
    //MARK: - Public Methods
    //This method send call to view model class to get avatar detail
    func callAvatarData()
    {
        self.projectDetailViewModel.getAvatar(parentViewController: self){ success in
            
            if success{
                let url = self.projectDetailViewModel.getAvatarURL()
                self.avatarImageView.imageFromServerURL(urlString: url, PlaceHolderImage: #imageLiteral(resourceName: "placeholder"))
            }
            
        }
    }
    
    //This method send call to view model class to get read me detail
    func callReadmeData()
    {
        self.projectDetailViewModel.getReadMe(parentViewController: self){ success in
            
            if success{
                let url = self.projectDetailViewModel.getReadMeURL()
                let nsurl = URL(string: url)
                guard let mdData = try? Data(contentsOf: nsurl!) else {
                    return
                }
                let mrText = String().data2String(mdData)
                guard let contents = mrText as? String else {
                    return
                }
                let conversion = ConversionMDFormat();
                let imgChanged = conversion.imgToBase64(contents)
                let mdContents = conversion.escapeForText(imgChanged)
                self.mdView.loadHTMLString(mdContents, baseURL: nil)
                
            }
            
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
