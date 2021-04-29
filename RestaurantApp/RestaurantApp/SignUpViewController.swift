//
//  SignUpViewController.swift
//  RestaurantApp
//
//  Created by Joyce on 4/27/21.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController,UINavigationControllerDelegate{

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var lblstatus: UILabel!
    

        override func viewDidLoad() {
            super.viewDidLoad()
            lblstatus.text = ""
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func btnSignUp(_ sender: Any) {
        let password = txtPassword.text!
        
        if txtEmail.text?.isEmpty == true {
            lblstatus.text = "no text in Email field"
            return
        }
        
        if password == "" || password.count < 6 {
            lblstatus.text = "Password Invalid"
            return
        }
        
        if txtEmail.text?.isEmail == false {
            lblstatus.text = "Email Invalid"
            return
        }
        signUp()
    }
    
    
    @IBAction func btnBackLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func signUp(){
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) {(authResult, error) in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error?.localizedDescription)")
                return
            }
            
            self.lblstatus.text = "Successful Registered! Please Login!"
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(identifier: "Login")
//            vc.modalPresentationStyle = .overFullScreen
//            self.present(vc, animated: true)
            
        }
        
    }
}
