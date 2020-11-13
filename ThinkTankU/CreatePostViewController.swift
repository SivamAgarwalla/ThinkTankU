//
//  CreatePostViewController.swift
//  ThinkTankU
//
//  Created by Sivam Agarwalla on 11/12/20.
//  Copyright © 2020 Sivam Agarwalla. All rights reserved.
//

import UIKit
import AlamofireImage

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    
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
