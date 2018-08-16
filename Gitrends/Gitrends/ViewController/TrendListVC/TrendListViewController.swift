/*********************************************************************
 Project Name : Gitrends
 
 File Name : TrendListViewController.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 16/08/18
 
 Description of File: This is a view controller file created to show list of trending git projects.
 *********************************************************************/
//
//  TrendListViewController.swift
//  Gitrends
//
//  Created by JYOTSNA  on 16/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit

class TrendListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Outlet Component Variable
    @IBOutlet weak var trendProjectListTableView : UITableView!
    
    //Create View Model Object here
    let trendListVM = TrendListViewModel()
    

    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Private Methods
    
    /**
     @method: This method is used to setup ui for trend view controller
     @parameter:
     @return:
    **/
    private func setupUI()
    {
        self.doInitialization()
    }
    
    /**
     @method: This method is used to do the initialization of the values
     @parameter:
     @return:
     **/
    private func doInitialization()
    {
        self.title = GIT_HUB_TITLE
        self.trendListVM.getTrendList(parentViewController: self){ success in
            
            if success{
                self.trendProjectListTableView.reloadData()
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
    
    //MARK: - UITableView Delegate & DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.trendListVM.numberOfSectionsInTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trendListVM.numberOfIRowsInTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.trendListVM.setUpTrendListTableViewCell(indexPath: indexPath, tableView: tableView)
        return cell
    }
    

}
