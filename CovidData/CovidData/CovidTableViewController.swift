//
//  CovidTableViewController.swift
//  CovidData
//
//  Created by Joyce on 3/30/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

class CovidTableViewController: UITableViewController {
    
    var newsTxtField : UITextField?
    var covidArr: [ModelCovid] = [ModelCovid]()
    let viewModel = ViewModel()
    
    @IBOutlet var tblCovid: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func viewWillAppear(_ animated: Bool) {
        
        self.viewModel.getCovidData(covidurl).done { covidData in
            self.covidArr = [ModelCovid]()
            
            for data in covidData {
                self.covidArr.append(data)
            }

            self.tblCovid.reloadData()
        }.catch { (error) in
            print("Error in getting all the pridiction values \(error)")
        }
    }
       

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return covidArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CovidTableViewCell", owner: self, options: nil)?.first as! CovidTableViewCell
        
            
          cell.State.text = "\(covidArr[indexPath.row].state) "
          cell.Total.text = "\(covidArr[indexPath.row].total)"
          cell.Positive.text = "\(covidArr[indexPath.row].positive)"

        return cell
    
    }
    
     

   
}
