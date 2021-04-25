//
//  CovidTableViewCell.swift
//  CovidData
//
//  Created by Joyce on 3/30/21.
//

import UIKit

class CovidTableViewCell: UITableViewCell {
    
    @IBOutlet weak var State: UILabel!
    
    @IBOutlet weak var Total: UILabel!
    
    @IBOutlet weak var Positive: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
