//
//  PostDetailsViewController.swift
//  ThinkTankU
//
//  Created by Sivam Agarwalla on 11/26/20.
//  Copyright © 2020 Sivam Agarwalla. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class PostDetailsViewController: UIViewController {
    
    var post: PFObject!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var startupLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var userpostImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var likeImageButton: UIButton!
    @IBOutlet weak var commentImageButton: UIButton!
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postUser = post["author"] as! PFUser
        usernameLabel.text = post["authorUsername"] as? String
        startupLabel.text = postUser["startup"] as? String
        postTitleLabel.text = post["title"] as? String
        postDescriptionLabel.text = post["description"] as? String
        
        let currentUser = PFUser.current()
        let currentUserID = (currentUser?.objectId!)!
        let defaultLike = UIImage(systemName: "heart.fill")
        let defaultNotLiked = UIImage(systemName: "heart")
        
        if post["likes"] != nil {
            if((post["likes"] as! NSArray).contains(currentUserID)) {
                likeImageButton.setImage(defaultLike, for: UIControl.State.normal)
            } else {
                likeImageButton.setImage(defaultNotLiked, for: UIControl.State.normal)
            }
        } else {
            likeImageButton.setImage(defaultNotLiked, for: UIControl.State.normal)
        }
        
        if postUser["profileImage"] != nil {
            let userImageFile = postUser["profileImage"] as! PFFileObject
            let urlString = userImageFile.url!
            let url = URL(string: urlString)!
            userProfileImageView.af.setImage(withURL: url)
        } else {
            let defaultPostImageField = UIImage(systemName: "person")
            userProfileImageView.image = defaultPostImageField
        }
        
        if post["image"] != nil {
            let postImageFile = post["image"] as! PFFileObject
            let urlString = postImageFile.url!
            let url = URL(string: urlString)!
            userpostImageView.af.setImage(withURL: url)
        }
        
        if self.post["likes"] != nil {
            let numberOfLikes = (self.post["likes"] as AnyObject).count
            self.likeCountLabel.text = "\(numberOfLikes ?? 0)"
        } else {
            self.likeCountLabel.text = "0"
        }

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onLikeButton(_ sender: Any) {
        let currentUser = PFUser.current()
        let currentUserID = (currentUser?.objectId!)!
        
        var postLikes: [String] = []
        postLikes.append(currentUserID)
        var likeSizeBefore = 0
        if self.post["likes"] != nil {
            likeSizeBefore = (self.post["likes"] as AnyObject).count
        }
        self.post.addUniqueObjects(from: postLikes, forKey: "likes")
        let likesSizeAfter = (self.post["likes"] as AnyObject).count
        self.post.saveInBackground { (success: Bool, error: Error?) in
            if(success) {
                if(likesSizeAfter == likeSizeBefore) {
                    self.post.removeObjects(in: postLikes, forKey: "likes")
                    self.post.saveInBackground()
                    let defaultUnlikeButton = UIImage(systemName: "heart")
                    self.likeImageButton.setImage(defaultUnlikeButton, for: UIControl.State.normal)
                    self.likeCountLabel.text = "\((self.post["likes"] as AnyObject).count ?? 0)"
                } else {
                    let defaultLikeButton = UIImage(systemName: "heart.fill")
                    self.likeImageButton.setImage(defaultLikeButton, for: UIControl.State.normal)
                    self.likeCountLabel.text = "\((self.post["likes"] as AnyObject).count ?? 0)"
                }
            } else {
                print("Error: \(error?.localizedDescription ?? "There was an error saving likes array.")")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
