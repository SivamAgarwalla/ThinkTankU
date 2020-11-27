//
//  PostCommentCell.swift
//  ThinkTankU
//
//  Created by Sivam Agarwalla on 11/26/20.
//  Copyright © 2020 Sivam Agarwalla. All rights reserved.
//

import UIKit

class PostCommentCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
