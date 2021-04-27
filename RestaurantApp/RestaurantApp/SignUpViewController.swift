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
    

        override func viewDidLoad() {
            super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func btnSignUp(_ sender: Any) {
        if txtEmail.text?.isEmpty == true {
            print("no text in Email field")
            return
        }
        
        if txtPassword.text?.isEmpty == true {
            print("no text in Password field")
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
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Login")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            
        }
        
    }
}
