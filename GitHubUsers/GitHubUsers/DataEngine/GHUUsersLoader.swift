//
//  UsersLoader.swift
//  GitHubUsers
//
//  Created by admin on 10/24/15.
//  Copyright © 2015 Shieghtun. All rights reserved.
//

import UIKit
import AFNetworking

class GHUUsersLoader: NSObject {
    
    var loadedUsers:Array<GHUUserModel> = []
    var successHandler:(Array<GHUUserModel>)->Void
    var failureHandler:(NSError)->Void
    var operationManager:AFHTTPRequestOperationManager?
    
    init(successHandler:(Array<GHUUserModel>)->Void, failureHandler:(NSError)->Void) {
        self.successHandler = successHandler
        self.failureHandler = failureHandler
        self.operationManager = AFHTTPRequestOperationManager()
        self.operationManager?.responseSerializer = AFJSONResponseSerializer()
    }
    
    func loadUsers() {
        var parameters:Dictionary = ["per_page":"100"]
        if loadedUsers.count > 0 {
            parameters.updateValue((self.loadedUsers.last?.userId)!, forKey: "since")
        }
        self.operationManager?.GET( "https://api.github.com/users",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if let jsonArray = responseObject as? NSArray {
                    for userObject in jsonArray {
                        let userDictionary = userObject as? NSDictionary
                        if (userDictionary != nil) {
                            let userModel = GHUUserModel()
                            userModel.avatarURL = userDictionary!.valueForKey("avatar_url") as? String
                            userModel.userName = userDictionary!.valueForKey("login") as? String
                            userModel.profileURL = userDictionary!.valueForKey("html_url") as? String
                            userModel.userId = String(userDictionary!.valueForKey("id") as! Int)
                            self.loadedUsers.append(userModel)
                        }
                    }
                }
                self.successHandler(self.loadedUsers)
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                self.failureHandler(error)
        })
    }

}
