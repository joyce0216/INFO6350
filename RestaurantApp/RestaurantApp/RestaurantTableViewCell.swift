//
//  RestaurantTableViewCell.swift
//  RestaurantApp
//
//  Created by Joyce on 4/24/21.
//

import UIKit


class RestaurantTableViewCell: UITableViewCell {
   
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgMain: UIImageView!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = .flexibleHeight
        // Initialization code
    }
    
}
