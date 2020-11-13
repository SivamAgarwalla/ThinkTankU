//
//  CreatePostViewController.swift
//  ThinkTankU
//
//  Created by Sivam Agarwalla on 11/12/20.
//  Copyright © 2020 Sivam Agarwalla. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    var userSelectedPostImage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the similar border on both the titleField and descriptionField
        self.titleField.layer.borderColor = UIColor.gray.cgColor
        self.titleField.layer.borderWidth = 1
        self.titleField.layer.cornerRadius = 5
        
        self.descriptionField.layer.borderColor = UIColor.gray.cgColor
        self.descriptionField.layer.borderWidth = 1
        self.descriptionField.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPostSave(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["title"] = titleField.text!
        post["description"] = descriptionField.text!
        
        let currentUser = PFUser.current()
        if currentUser != nil {
            post["author"] = currentUser
            if(currentUser?["startup"] != nil) {
                post["startup"] = currentUser?["startup"]
            }
        }
        
        if(userSelectedPostImage) {
            let imageData = postImageView.image!.pngData()
            let file = PFFileObject(data: imageData!)
            
            post["image"] = file
        }
        
        post.saveInBackground { (success, error) in
            if success {
                // No action required.
            } else {
                print("Error: \(error?.localizedDescription ?? "There was an error posting!")")
            }
        }
    }
    
    @IBAction func onCameraLaunch(_ sender: Any) {
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
            
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
            
        postImageView.image = scaledImage
            
        dismiss(animated: true, completion: nil)
        userSelectedPostImage = true
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
