//
//  GHUUserCell.swift
//  GitHubUsers
//
//  Created by admin on 10/24/15.
//  Copyright © 2015 Shieghtun. All rights reserved.
//

import UIKit

class GHUUserCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel:UILabel?
    @IBOutlet weak var userProfileLink:UILabel?
    @IBOutlet weak var avatar:UIImageView?
    
    @IBAction func avatarTapped() {
        
    }
    
    func updateUIWithModel(userModel:GHUUserModel) {
        self.userNameLabel?.text = userModel.userName
        self.userProfileLink?.text = userModel.profileURL
        self.avatar?.image = UIImage()
        self.avatar?.setImageWithURL(NSURL.init(string: userModel.avatarURL!)!)
    }

}
