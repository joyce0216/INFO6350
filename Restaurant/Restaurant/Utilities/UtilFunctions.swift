//
//  UtilFunctions.swift
//  Restaurant
//
//  Created by Joyce on 4/23/21.
//

import Foundation
import CoreLocation

let apiKey = "AIzaSyA1E0Q07cNt3jorqCmtiWGNZ_sVpDR2ZNs"
let restaurantURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?radius=1500&type=restaurant&key=\(apiKey)"
let photoURL = "https://maps.googleapis.com/maps/api/place/photo?key=\(apiKey)"

func getNearbyRestaurantURL(_ lat : CLLocationDegrees, _ lng : CLLocationDegrees) -> String{
    var url = restaurantURL
    url.append("&location=\(lat),\(lng)")
    return url
}

func getRestaurantPhotoURL(_ photoReference : String, _ maxWidth : Int) -> String {
    var url = photoURL
    url.append("&maxwidth=\(maxWidth)")
    url.append("&photoreference=\(photoReference)")
    return url
}
