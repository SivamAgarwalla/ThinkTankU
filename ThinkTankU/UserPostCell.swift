//
//  UserPostCell.swift
//  ThinkTankU
//
//  Created by Sivam Agarwalla on 11/20/20.
//  Copyright © 2020 Sivam Agarwalla. All rights reserved.
//

import UIKit

class UserPostCell: UICollectionViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.autoresizingMask.insert(.flexibleHeight)
        self.contentView.autoresizingMask.insert(.flexibleWidth)
    }
    
}
