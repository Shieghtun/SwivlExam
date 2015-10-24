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
        self.operationManager?.GET( "https://api.github.com/users",
            parameters: ["per_page":"100"],
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                print("JSON: ", responseObject.description)
                if let jsonArray = responseObject as? NSArray {
                    for userObject in jsonArray {
                        let userDictionary = userObject as? NSDictionary
                        if (userDictionary != nil) {
                            let userModel = GHUUserModel()
                            userModel.avatarURL = userDictionary!.valueForKey("avatar_url") as? String
                            userModel.userName = userDictionary!.valueForKey("login") as? String
                            userModel.profileURL = userDictionary!.valueForKey("html_url") as? String
                            self.loadedUsers.append(userModel)
                        }
                    }
                }
                self.successHandler(self.loadedUsers)
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: ", error.localizedDescription)
                self.failureHandler(error)
        })
    }

}
