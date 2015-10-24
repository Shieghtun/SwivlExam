//
//  GHUUserCellDelegate.swift
//  GitHubUsers
//
//  Created by admin on 10/25/15.
//  Copyright © 2015 Shieghtun. All rights reserved.
//

import UIKit

@objc public protocol GHUUserCellDelegate : NSObjectProtocol {
    optional func avatarTapped(avatarImage:UIImage)
}
