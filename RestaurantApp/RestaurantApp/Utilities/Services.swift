//
//  Services.swift
//  RestaurantApp
//
//  Created by Joyce on 4/24/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

func getAFResponseJSON(_ url : String) -> Promise<JSON>{
    
    return Promise<JSON> { seal -> Void in
        
        AF.request(url).responseJSON { response in
            // If there was an error we will reject the promise
            if response.error != nil {
                seal.reject(response.error!)
            }
            
            // get the JSON array and fulfill the promise
            let json: JSON = JSON(response.data!)
            seal.fulfill(json)
        }
    }
    
}

func getAFResponseData(_ url : String) -> Promise<Data>{
    
    return Promise<Data> { seal -> Void in
        
        AF.request(url).response { response in
            // If there was an error we will reject the promise
            if response.error != nil {
                seal.reject(response.error!)
            }
            
            // get the JSON array and fulfill the promise
            let data = response.data!
            seal.fulfill(data)
        }
    }
}
