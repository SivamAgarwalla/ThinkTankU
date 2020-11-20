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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userBioField.layer.borderColor = UIColor.gray.cgColor
        self.userBioField.layer.borderWidth = 1
        self.userBioField.layer.cornerRadius = 5
        
        self.userBioField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))

        self.view.addGestureRecognizer(tap)
        
        let currentUser = PFUser.current()
        
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
        let currentUser = PFUser.current()
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
        
        let currentUser = PFUser.current()
        
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
