//
//  ViewController.swift
//  BeautyCamera
//
//  Created by Joyce on 1/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    
    var BtnPressed : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func PressNameAction(_ sender: UIButton) {
        if BtnPressed == true{
            BtnPressed = false
            lblName.text = "First Name"
        }
        else{
            BtnPressed = true
            lblName.text = "Last Name"
        }
        
        
        print("Button Pressed")
    }
    
}

