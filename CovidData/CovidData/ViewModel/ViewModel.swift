//
//  ViewModel.swift
//  CovidData
//
//  Created by Joyce on 3/30/21.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

class ViewModel {
    
    func getCovidData(_ url : String) -> Promise<[ModelCovid]>{
        
        return Promise<[ModelCovid]> { seal -> Void in
            getAFResponseJSON(url).done { json in
                
                var arr  = [ModelCovid]()
                
                for fc in json.arrayValue {
                    
                    let covidData = ModelCovid()
                    covidData.state = fc["state"].stringValue
                    covidData.total = fc["total"].intValue
                    covidData.positive = fc["positive"].intValue
                    
                    
                    arr.append(covidData)
                }

                seal.fulfill(arr)
            }
            .catch { error in
                print(error)
                seal.reject(error)
            }
        }
    }
    
    func getAFResponseJSON(_ url : String) -> Promise<JSON>{
        
        return Promise<JSON> { seal -> Void in
            
            AF.request(url).responseJSON { response in
                // If there was an error we will reject the promise
                if response.error != nil {
                    seal.reject(response.error!)
                }
                
                // get the JSON array and fulfill the promise
                let json: JSON = JSON(response.data)
                seal.fulfill(json)
            }
        }
        
    }
    
}
