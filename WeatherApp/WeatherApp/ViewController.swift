//
//  ViewController.swift
//  WeatherApp
//
//  Created by Joyce on 3/7/21.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var lblCity: UILabel!
    
    
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func GetInfo(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currLocation = locations.last{
            let lat = currLocation.coordinate.latitude
            let lng = currLocation.coordinate.longitude
            
            
            print("Latitude : \(lat)")
            print("Longitude : \(lng)")
            
            let url = getLocationURL( lat, lng)
            
            getLocationData(url)
                .done { (key, city) in
                    self.lblCity.text = "City : \(city)"
                }
                .catch { error in
                    print("ERROR \(error.localizedDescription)")
                    
                }
                                     
        }
    }
    
    func updateLocalWeather( _ lat: CLLocationDegrees, _ lng : CLLocationDegrees) {
        let url = getLocationURL( lat,lng)
        
        getLocationData(url)
            .done { (key, city) in
                self.lblCity.text = "City : \(city)"
                
                let currentUrl = self.getConditionURL(key)
                
                self.updateWeatherData(currentConditionURL).done { (currCondition, temp) in
                    print(currCondition)
                    print(temp)
                    
                }
                .catch {error in
                    print("Error \(error.localizedDescription)")
                }
            }
            .catch { error in
                print("ERROR \(error.localizedDescription)")
                
            }
        
    }
    
    func getLocationURL(_ lat : CLLocationDegrees, _ lng : CLLocationDegrees) -> String{
        var url = locationURL
        url.append("?apikey=\(apiKey)")
        url.append("&q=\(lat),\(lng)")
        
        return url
    }
    
    func getConditionURL(_ cityKey : String) -> String{
        var url = currentConditionURL
        url.append(cityKey)
        url.append("?apikey=\(apiKey)")
        
        return url
    }
    
    func getLocationData(_ url: String) -> Promise<(String, String)>{
        return Promise<(String, String)> { seal -> Void in
            
            AF.request(url).responseJSON { response in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                let locationJSON : JSON = JSON(response.data as Any)
                let key = locationJSON["Key"].stringValue
                let city = locationJSON["LocalizedName"].stringValue
                
                seal.fulfill((key, city))
                
            }
        }
    }
    
    func updateWeatherData(_ url : String) -> Promise<(String, Int)> {
        return Promise<(String, Int)> { seal -> Void in
            
            AF.request(url).responseJSON { response in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                let locationJSON : JSON = JSON(response.data).arrayValue
                let condition = locationJSON[0]["WeatherText"].stringValue
                let temp = locationJSON[0]["Temperature"]["Imperial"]["Value"].intValue
               
                
                seal.fulfill((condition, temp))
        }
    }
    

    //2253217 key for seattle
    
}
    
