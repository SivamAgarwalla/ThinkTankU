//
//  SignupViewController.swift
//  ThinkTankU
//
//  Created by Sivam Agarwalla on 11/8/20.
//  Copyright © 2020 Sivam Agarwalla. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var schoolField: UITextField!
    @IBOutlet weak var startupField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRegister(_ sender: Any) {
        let user = PFUser()
        // Setting the required fields of PFUser class
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
        
        // Setting up the additional fields of PFUser class
        user["firstName"] = firstNameField.text
        user["lastName"] = lastNameField.text
        user["school"] = schoolField.text
        user["startup"] = startupField.text
        
        user.signUpInBackground { (succeeded, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
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
