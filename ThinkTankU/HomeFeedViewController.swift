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
        
        let postImageFile = post["image"] as! PFFileObject
        let urlString = postImageFile.url!
        let url = URL(string: urlString)!
        
        cell.postImageView.af.setImage(withURL: url)
        
        return cell
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
