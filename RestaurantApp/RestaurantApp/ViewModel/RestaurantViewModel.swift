//
//  RestaurantViewModel.swift
//  RestaurantApp
//
//  Created by Joyce on 4/24/21.
//

import Foundation
import PromiseKit

class RestaurantViewModel {
    
    func getRestaurant(_ url : String) -> Promise<[ModelRestaurant]>{
        return Promise<[ModelRestaurant]> { seal -> Void in
            
            getAFResponseJSON(url).done { json in
                
                var arr = [ModelRestaurant]()
                
                for res in json["results"].arrayValue {
                    
                    let restaurant = ModelRestaurant()
                    restaurant.resName = res["name"].stringValue
                    restaurant.rating = res["rating"].floatValue
                    restaurant.status = res["business_status"].stringValue == "OPERATIONAL" ? "Open" : "Closed"
                    restaurant.address = res["vicinity"].stringValue
                    
                    if let reference = res["photos"].arrayValue[0]["photo_reference"].string {
                        let photoURL = getRestaurantPhotoURL(reference, 250)
                        getAFResponseData(photoURL).done{data in
                            restaurant.imageData = data
                        }.catch { error in
                            print(error)
                            seal.reject(error)
                        }
                    }
                    
                    arr.append(restaurant)
                }
                seal.fulfill(arr)
            }.catch { error in
                print(error)
                seal.reject(error)
            }
        }
    }
}
