//
//  ProfileViewController.swift
//  ThinkTankU
//
//  Created by Sivam Agarwalla on 11/19/20.
//  Copyright © 2020 Sivam Agarwalla. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var schoolNameField: UILabel!
    @IBOutlet weak var startupField: UILabel!
    @IBOutlet weak var userBioField: UITextView!
    @IBOutlet var postCollectionView: UICollectionView!
    var currentUser: PFUser!
    var currentUserPostCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        self.postCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.postCollectionView.dataSource = self
        self.postCollectionView.delegate = self
        
        self.userBioField.layer.borderColor = UIColor.gray.cgColor
        self.userBioField.layer.borderWidth = 1
        self.userBioField.layer.cornerRadius = 5
        
        self.userBioField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        self.view.addGestureRecognizer(tap)
        
        self.currentUser = PFUser.current()
        let currentUserID = currentUser?["username"]
        print(currentUserID!)
        
        let query = PFQuery(className: "Posts")
        query.whereKey("authorUsername", equalTo: currentUserID!)
        
        query.findObjectsInBackground { (userPosts: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let userPosts = userPosts {
                // The find succeeded.
                self.currentUserPostCount = userPosts.count
                print("Successfully retrieved \(userPosts.count) posts.")
                
                // Do something with the found objects
                for userPosts in userPosts {
                    print(userPosts.objectId as Any)
                }
            }
        }

        self.nameField.text = (currentUser?["firstName"] as! String) + " " + (currentUser?["lastName"] as! String)
        self.schoolNameField.text = currentUser?["school"] as? String
        self.startupField.text = currentUser?["startup"] as? String
        
        if currentUser?["profileImage"] != nil {
            let userImageFile = currentUser?["profileImage"] as! PFFileObject
            let urlString = userImageFile.url!
            let url = URL(string: urlString)!
            profilePicture.af.setImage(withURL: url)
        }
        
        if currentUser?["userBio"] != nil {
            userBioField.text = currentUser?["userBio"] as? String
        }
        
    }
    
    @objc func hideKeyboardByTappingOutside() {
        self.view.endEditing(true)
    }
    
    /*
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.userBioField.resignFirstResponder()
        return true;
    }
     */
    
    func textViewDidEndEditing(_ textView: UITextView) {
        currentUser?["userBio"] = userBioField.text
        currentUser?.saveInBackground()
        self.userBioField.resignFirstResponder()
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
    }
    
    @IBAction func onProfileImageButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 151, height: 151)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        profilePicture.image = scaledImage
        
        let imageData = profilePicture.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        currentUser?["profileImage"] = file
        currentUser?.saveInBackground()
        
        dismiss(animated: true, completion: nil)
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

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Add this line of code to HomeScreen posts as well
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .systemPurple
        return cell
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
}
