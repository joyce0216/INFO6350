//
//  ForecastTableViewCell.swift
//  WorldWeather
//
//  Created by Joyce on 3/14/21.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblWeekOfDay: UILabel!
    
    @IBOutlet weak var lblHigh: UILabel!
    
    @IBOutlet weak var lblLow: UILabel!
    
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var imgNight: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
}
