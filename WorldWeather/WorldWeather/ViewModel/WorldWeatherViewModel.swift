//
//  CityViewModel.swift
//  WorldWeather
//
//  Created by Ashish Ashish on 10/03/21.
//

import Foundation
import PromiseKit

class WorldWeatherViewModel {

    func getCityData(_ url : String) -> Promise<ModelCity> {
        
        return Promise<ModelCity>{ seal ->Void in
            
            getAFResponseJSON(url).done { json in
                
                let key = json["Key"].stringValue
                let city = json["LocalizedName"].stringValue
                let cityModel: ModelCity = ModelCity(key, city)
                
                seal.fulfill(cityModel)
            }
            .catch { error in
                seal.reject(error)
            }
        }
    }
    
    func getCurrentConditions(_ url : String) -> Promise<ModelCurrentCondition>{
        return Promise<ModelCurrentCondition> { seal ->Void in
            
            getAFResponseJSONArray(url).done { currentWeatherJSON in
                
                let weatherText = currentWeatherJSON[0]["WeatherText"].stringValue
                let weatherIcon = currentWeatherJSON[0]["WeatherIcon"].intValue
                let conditionIcon = String(format: "%02d", weatherIcon) + "-s"
                let isDayTime = currentWeatherJSON[0]["IsDayTime"].boolValue
                let metricTemp = currentWeatherJSON[0]["Temperature"]["Metric"]["Value"].floatValue
                let imperialTemp = currentWeatherJSON[0]["Temperature"]["Imperial"]["Value"].intValue

                let currCondition = ModelCurrentCondition(weatherText, metricTemp, imperialTemp, UIImage(named: conditionIcon)!)
                currCondition.isDayTime  = isDayTime
                
                
                seal.fulfill(currCondition)
            
            }
            .catch { error in
                seal.reject(error)
            }
            
        }
    }
    
    func getOneDayConditions(_ url : String) -> Promise<ModelOneDayForecast>{
        return Promise<ModelOneDayForecast> { seal -> Void in
            
            getAFResponseJSON(url).done { json in
                
                let dayForecast = ModelOneDayForecast()
                let tempDayIcon = String(format: "%02d", json["DailyForecasts"][0]["Day"]["Icon"].intValue) + "-s"
                let tempNightIcon = String(format: "%02d", json["DailyForecasts"][0]["Night"]["Icon"].intValue) + "-s"
                dayForecast.headlineText = json["Headline"]["Text"].stringValue
                dayForecast.nightTemp = json["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].intValue
                dayForecast.dayTemp = json["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].intValue
                dayForecast.dayIcon = json["DailyForecasts"][0]["Day"]["Icon"].intValue
                dayForecast.nightIcon = json["DailyForecasts"][0]["Night"]["Icon"].intValue
                dayForecast.dayIconPhrase = json["DailyForecasts"][0]["Day"]["IconPhrase"].stringValue
                dayForecast.nightIconPhrase = json["DailyForecasts"][0]["Night"]["IconPhrase"].stringValue
                dayForecast.tempDayIcon = UIImage(named: tempDayIcon)!
                dayForecast.tempNightIcon = UIImage(named: tempNightIcon)!

                seal.fulfill(dayForecast)
            
            }
            .catch { error in
                seal.reject(error)
            }
            
        }
    }
    
    func getFiveDayForecast(_ url : String) -> Promise<[Forecast]>{
        
        return Promise<[Forecast]> { seal -> Void in
            getAFResponseJSON(url).done { json in
                
                var arr  = [Forecast]()
                
                for fc in json["DailyForecasts"].arrayValue {
                    
                    let forecast = Forecast()
                    let dayIconName = String(format: "%02d", fc["Day"]["Icon"].intValue) + "-s"
                    let nightIconName = String(format: "%02d", fc["Night"]["Icon"].intValue) + "-s"
                    forecast.weekOfDay = self.dayOfTheWeek(fc["EpochDate"].doubleValue)
                    forecast.high = fc["Temperature"]["Maximum"]["Value"].intValue
                    forecast.low = fc["Temperature"]["Minimum"]["Value"].intValue
                    forecast.iconImage = UIImage(named: dayIconName)!
                    forecast.iconNight = UIImage(named: nightIconName)!
                    
                    arr.append(forecast)
                }

                seal.fulfill(arr)
            }
            .catch { error in
                print(error)
                seal.reject(error)
            }
        }
    }

    func dayOfTheWeek(_ epochDate :Double) -> String {
        let date = Date(timeIntervalSince1970: epochDate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        return dateFormatter.string(from: date)
//        let df1 = DateFormatter()
//       // let df2 = DateFormatter()
//        df1.dateFormat = "EEEE, MMMM dd, yyyy"
//
//        let bigDate = DateFormatter().date(from: date)
//        let formattedDate = dateFormatter.string(from: bigDate!)
//
//        return formattedDate
    }
}

