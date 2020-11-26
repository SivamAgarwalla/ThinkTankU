//
//  HomeFeedViewController.swift
//  ThinkTankU
//
//  Created by Sivam Agarwalla on 11/12/20.
//  Copyright © 2020 Sivam Agarwalla. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class HomeFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postsTableView: UITableView!
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.delegate = self
        postsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.postsTableView.reloadData()
            }
            else {
                print("Error: \(error?.localizedDescription ?? "There was an error loading the posts!")")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        
        let postUser = post["author"] as! PFUser
        cell.username.text = postUser["username"] as? String
        cell.userStartup.text = postUser["startup"] as? String
        cell.postTitle.text = post["title"] as? String
        cell.postDescription.text = post["description"] as? String
        
        let currentUser = PFUser.current()
        let currentUserID = (currentUser?.objectId!)!
        let defaultLike = UIImage(systemName: "heart.fill")
        let defaultNotLiked = UIImage(systemName: "heart")
        
        if post["likes"] != nil {
            if((post["likes"] as! NSArray).contains(currentUserID)) {
                cell.onLikeButton.setImage(defaultLike, for: UIControl.State.normal)
            } else {
                cell.onLikeButton.setImage(defaultNotLiked, for: UIControl.State.normal)
            }
        } else {
            cell.onLikeButton.setImage(defaultNotLiked, for: UIControl.State.normal)
        }
        
        if postUser["profileImage"] != nil {
            let userImageFile = postUser["profileImage"] as! PFFileObject
            let urlString = userImageFile.url!
            let url = URL(string: urlString)!
            cell.userImageView.af.setImage(withURL: url)
        } else {
            let defaultPostImageField = UIImage(systemName: "person")
            cell.userImageView.image = defaultPostImageField
        }
        
        if post["image"] != nil {
            let postImageFile = post["image"] as! PFFileObject
            let urlString = postImageFile.url!
            let url = URL(string: urlString)!
            cell.postImageView.af.setImage(withURL: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.postsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func onLikeButton(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.postsTableView)
        let indexPath = self.postsTableView.indexPathForRow(at: buttonPosition)
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath!) as! PostCell
        
        let post = posts[indexPath!.row]
        let currentUser = PFUser.current()
        let currentUserID = (currentUser?.objectId!)!
        
        var postLikes: [String] = []
        postLikes.append(currentUserID)
        var likeSizeBefore = 0
        if post["likes"] != nil {
            likeSizeBefore = (post["likes"] as AnyObject).count
        }
        post.addUniqueObjects(from: postLikes, forKey: "likes")
        post.saveInBackground { (success: Bool, error: Error?) in
            if(success) {
                let likesSizeAfter = (post["likes"] as AnyObject).count
                if(likesSizeAfter == likeSizeBefore) {
                    post.removeObjects(in: postLikes, forKey: "likes")
                    post.saveInBackground()
                    let defaultUnlikeButton = UIImage(systemName: "heart")
                    cell.onLikeButton.setImage(defaultUnlikeButton, for: UIControl.State.normal)
                    self.postsTableView.reloadRows(at: self.postsTableView.indexPathsForVisibleRows!, with: UITableView.RowAnimation.none)
                } else {
                    let defaultLikeButton = UIImage(systemName: "heart.fill")
                    cell.onLikeButton.setImage(defaultLikeButton, for: UIControl.State.normal)
                    self.postsTableView.reloadRows(at: self.postsTableView.indexPathsForVisibleRows!, with: UITableView.RowAnimation.none)
                }
            } else {
                print("Error: \(error?.localizedDescription ?? "There was an error saving likes array.")")
            }
        }
    }
    
    @IBAction func onCommentButton(_ sender: Any) {
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = postsTableView.indexPath(for: cell)!
        let post = posts[indexPath.row]
        
        let detailsViewController = segue.destination as! PostDetailsViewController
        detailsViewController.post = post
        
        //Pass the selected movie to the details view controller
    }
 }
