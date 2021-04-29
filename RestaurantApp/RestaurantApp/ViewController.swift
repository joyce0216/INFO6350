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
import FirebaseDatabase

class ViewController: UIViewController, UINavigationControllerDelegate,CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblRestaurant: UITableView!
    
    @IBOutlet weak var imageRestaurant: UIImageView!
    
    @IBOutlet weak var btnShowFavorite: UIButton!
    
    var databaseRef = Database.database().reference(fromURL: "https://restaurant-5b82f-default-rtdb.firebaseio.com/")
 
    let locationManager = CLLocationManager()
    var newsTxtField : UITextField?
    var restaurantArr: [ModelRestaurant] = [ModelRestaurant]()
    var favorites: [String] = [String]()
    var isFavoriteView: Bool = false
    
    let viewModel = RestaurantViewModel()
    var userId : String = "Unknown"

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
        
        cell.lblName.text = "\(restaurantArr[indexPath.row].resName) "
        cell.lblRating.text = "Rating: \(restaurantArr[indexPath.row].rating)"
        cell.lblAddress.text = "Address: \(restaurantArr[indexPath.row].address)"
        cell.lblStatus.text = "Status: \(restaurantArr[indexPath.row].status)"
        cell.imgMain.image = UIImage(data: restaurantArr[indexPath.row].imageData, scale: 1)
        
        let placeId = restaurantArr[indexPath.row].placeId
        if favorites.contains(placeId) {
            cell.btnFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        cell.actionBlock = { [self] in
            print("button clicked")
            
            if favorites.contains(placeId) { // Remove favorite
                favorites.remove(at: favorites.firstIndex(of: placeId)!)
                databaseRef.child(userId).child(placeId).removeValue()
                
                cell.btnFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
            } else { // Add favorite
                favorites.append(placeId)
                databaseRef.child(userId).child(placeId).setValue(restaurantArr[indexPath.row].resName)
                
                cell.btnFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return restaurantArr[indexPath.row].shouldDisplay ? tableView.rowHeight : 0
    }
    
    @IBAction func clickOnShowFavorite(_ sender: Any) {
        retrieveFavorites()
        
        if (isFavoriteView) { // Bring back to full view
            for restaurant in restaurantArr {
                restaurant.shouldDisplay = true
            }
        } else { // Bring to favorite view
            for restaurant in restaurantArr {
                if !favorites.contains(restaurant.placeId) {
                    restaurant.shouldDisplay = false
                }
            }
        }
        
        isFavoriteView = !isFavoriteView
        
        self.tblRestaurant.reloadData()
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
            retrieveFavorites()
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
    
    func retrieveFavorites() {
        databaseRef.child(userId).getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                self.favorites = Array((snapshot.value as? [String : AnyObject] ?? [:]).keys)
            }
            else {
                print("No data available")
            }
        }
    }
}




