//
//  ViewController.swift
//  RestaurantApp
//
//  Created by Joyce on 4/24/21.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblRestaurant: UITableView!
    
    @IBOutlet weak var lblNearby: UILabel!
        
    let locationManager = CLLocationManager()
    var newsTxtField : UITextField?
    var restaurantArr: [ModelRestaurant] = [ModelRestaurant]()
    let viewModel = RestaurantViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblRestaurant.estimatedRowHeight = 200
        self.tblRestaurant.rowHeight = UITableView.automaticDimension
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        tblRestaurant.delegate = self
        tblRestaurant.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("RestaurantTableViewCell", owner: self, options: nil)?.first as! RestaurantTableViewCell
        
        cell.lblName.text = "Name: \(restaurantArr[indexPath.row].resName) "
        cell.lblRating.text = "Rating: \(restaurantArr[indexPath.row].rating)"
        cell.lblAddress.text = "Address: \(restaurantArr[indexPath.row].address)"
        cell.lblStatus.text = "Status: \(restaurantArr[indexPath.row].status)"
        cell.imgMain.image = UIImage(data: restaurantArr[indexPath.row].imageData, scale: 1)
        
        return cell
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "goLoginSegue", sender: self)
    }
    
    //MARK: Location Manager functions
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currLocation = locations.last{
            
            let lat = currLocation.coordinate.latitude
            let lng = currLocation.coordinate.longitude
            
            searchRestaurant(lat, lng)
        }
    }
    
    func searchRestaurant(_ lat : CLLocationDegrees, _ lng : CLLocationDegrees){
        let retaurantURL = getNearbyRestaurantURL(lat, lng)
        viewModel.getRestaurant(retaurantURL).done { restaurants in
            self.restaurantArr = [ModelRestaurant]()
            
            for restaurant in restaurants {
                self.restaurantArr.append(restaurant)
            }
            
            self.tblRestaurant.reloadData()
        }.catch { (error) in
            print("Error in getting all the pridiction values \(error)")
        }
    }
    
}




