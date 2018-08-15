/*********************************************************************
 Project Name : Gitrends
 
 File Name : TrendProjectListTableViewCell.swift
 
 Owner of File : Jyotsna Kadam
 
 Created Date: 16/08/18
 
 Description of File: This is a table view cell file created to show detail of trend projects
 *********************************************************************/
//
//  TrendProjectListTableViewCell.swift
//  Gitrends
//
//  Created by JYOTSNA  on 16/08/18.
//  Copyright © 2018 Jyotsna Kadam. All rights reserved.
//

import UIKit

class TrendProjectListTableViewCell: UITableViewCell {
    //Outlet Component Variable
    @IBOutlet weak var projectNameLabel : UILabel!
    @IBOutlet weak var projectStarLabel : UILabel!
    @IBOutlet weak var projectDetaiLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
