//
//  CommodityTableViewController.swift
//  CommodityTableView
//
//  Created by Joyce on 3/2/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit


class CommodityTableViewController: UITableViewController {
    
    var newsTxtField : UITextField?
    var commodityArr: [Commodity] = [Commodity]()
    var commodityArr2: [Commodity] = [Commodity]()

    @IBOutlet var tblCommodity: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return commodityArr.count
       }
       
    override func viewWillAppear(_ animated: Bool) {
       getData();
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
      let cell = Bundle.main.loadNibNamed("CommodityTableViewCell", owner: self, options: nil)?.first as! CommodityTableViewCell
      
          
        cell.lblName.text = "\(commodityArr[indexPath.row].name) "
        cell.lblPrice.text = "$\(commodityArr[indexPath.row].price)"
        

        return cell
       }
       
    func getUrl() -> String {
       var url = apiURL
       
       url.append(apiKey)
       
       return url
    }

       
    func getData() {

        let url = getUrl()
        
        getQuickShortQuote(url)
            .done { (commoditys) in
                self.commodityArr = [Commodity]()
                for commodity in commoditys {
                self.commodityArr.append(commodity)
                }
                
                self.tblCommodity.reloadData()
            }
            .catch { (error) in
                print("Error in getting all the commodity values \(error)")
            }
       
    }


    func getQuickShortQuote(_ url : String) -> Promise<[Commodity]>{
        
        return Promise<[Commodity]> { seal -> Void in
            
        AF.request(url).responseJSON { response in
            if response.error == nil {
    
                var arr  = [Commodity]()
                guard let data = response.data else {return seal.fulfill( arr ) }
                guard let commoditys = JSON(data).array else { return  seal.fulfill( arr ) }
                
                for commodity in commoditys {
                    
                    let name = commodity["name"].stringValue
                    let price = commodity["price"].floatValue
                    
                    let commodity = Commodity()
                    commodity.name = name
                    commodity.price = price
                    
                    arr.append(commodity)
                }
                
                seal.fulfill(arr)
            }
            else {
                seal.reject(response.error!)
            }
        }
        }
    }

}
