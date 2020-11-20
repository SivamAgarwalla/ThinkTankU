//
//  PostCell.swift
//  ThinkTankU
//
//  Created by Sivam Agarwalla on 11/12/20.
//  Copyright © 2020 Sivam Agarwalla. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userStartup: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var onLikeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
