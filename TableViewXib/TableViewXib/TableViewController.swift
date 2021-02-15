//
//  TableViewController.swift
//  TableViewXib
//
//  Created by Joyce on 2/14/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    let cities = ["Seattle", "Portland", "New York", "Miami", "Los Angeles"]
    let tempurature = ["34", "31", "36", "77", "64"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell

        cell.lblcities.text = cities[indexPath.row]
        cell.lblTemprature.text = tempurature[indexPath.row] + "°F"

        return cell
    }
}
