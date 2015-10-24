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
    weak var delegate:GHUUserCellDelegate?
    weak var model:GHUUserModel?
    
    @IBAction func avatarTapped() {
        delegate?.avatarTapped!((self.avatar?.image)!)
    }
    
    func updateUIWithModel(userModel:GHUUserModel) {
        self.model = userModel
        self.userNameLabel?.text = userModel.userName
        self.userProfileLink?.text = userModel.profileURL
        self.avatar?.image = UIImage()
        self.avatar?.setImageWithURL(NSURL.init(string: userModel.avatarURL!)!)
    }

}
