//
//  ViewController.swift
//  Dice
//
//  Created by Joyce on 1/29/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var wonLabel: UILabel!

    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var playBtn: UIButton!
    
    
    let imageArray = ["Dice1", "Dice2", "Dice3", "Dice4",  "Dice5", "Dice6"]
    
    var rand1 = Int.random(in: 0...5)
    var rand2 = Int.random(in: 0...5)
    
    var balance = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeImages()
        wonLabel.text = "Please tap Play button"
        balanceLabel.text = "Your balance = \(balance)$"
    }
    
    func changeImages() {
        rand1 = Int.random(in: 0...5)
        rand2 = Int.random(in: 0...5)
        image1.image = UIImage(named: imageArray[rand1])
        image2.image = UIImage(named: imageArray[rand2])
        

    }


    @IBAction func playButton(_ sender: UIButton) {
        changeImages()
        
        if rand1 + rand2 + 2 == 7 {
            
            balance = balance + 3
            wonLabel.text = "You won 3$"
        }
        else if rand1 + rand2 + 2 > 7 {
            
            balance += 1
            wonLabel.text = "You won 1$"

        }else if rand1 + rand2 + 2 < 7{
            balance -= 1
            wonLabel.text = "You lost 1$"

        }
        
        balanceLabel.text = "Your balance = \(balance)$"
        
        if balance <= 0 {
            playBtn.isEnabled = false
            wonLabel.text = "Please restart app"
        }

    }
}

