//
//  LoginViewController.swift
//  RestaurantApp
//
//  Created by Joyce on 4/24/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblStatus.text = ""
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        if email == "" || password == "" || password.count < 6 {
            lblStatus.text = "Email/Password Invalid"
            return
        }
        
        if email.isEmail == false {
            lblStatus.text = "Email Invalid"
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if error != nil {
                self.lblStatus.text = error?.localizedDescription
                return
            }
            
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    
}
