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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // will go to user profile here
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GHUUserCell") as! GHUUserCell
        cell.updateUIWithModel(self.usersList[indexPath.row])
        return cell
    }
}
