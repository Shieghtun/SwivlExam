//
//  GHUTableViewController.swift
//  GitHubUsers
//
//  Created by admin on 10/24/15.
//  Copyright © 2015 Shieghtun. All rights reserved.
//

import UIKit

class GHUTableViewController: UITableViewController {
    
    var usersLoader:GHUUsersLoader?
    var usersList:Array<GHUUserModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.usersLoader = GHUUsersLoader(successHandler: didLoadUsersList,
            failureHandler: didFailToLoadUsersList)
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            self.usersLoader?.loadUsers()
        })
    }
    
    func didLoadUsersList(usersList:Array<GHUUserModel>) {
        self.usersList = usersList
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    
    func didFailToLoadUsersList(error:NSError) {
        // Will show error here
    }
    
    // UITableViewDelegate, UITableViewDataSource

}
