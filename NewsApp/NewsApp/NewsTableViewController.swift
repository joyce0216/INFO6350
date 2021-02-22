//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Joyce on 2/21/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class NewsTableViewController: UITableViewController {
        var newsTxtField : UITextField?
            
        var newsArr: [News] = [News]()
    
    
    @IBOutlet var tblNews: UITableView!
    
        override func viewDidLoad() {
            super.viewDidLoad()

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }

        // MARK: - Table view data source

        override func viewWillAppear(_ animated: Bool) {
            getData();
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return newsArr.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          // let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           
           let cell = Bundle.main.loadNibNamed("NewsTableViewCell", owner: self, options: nil)?.first as! NewsTableViewCell
           
           
           cell.lblTitle.text = newsArr[indexPath.row].title

           return cell
        }

        func getUrl() -> String {
            var url = apiURL
            
//            url = String( url.dropLast() )
            
            url.append(apiKey)
            
            return url
        }
        
        func getData() {
            let url = getUrl()
            
            //SwiftSpinner.show("Getting News Titles")
            
            AF.request(url).responseJSON { response in
                
               //SwiftSpinner.hide()
                if response.error == nil {
                    
                    guard let value = response.value else {return}
                    //debugPrint("Value is ")
                    //debugPrint(value)
                    
                    guard let news = JSON(value)["articles"].array else { return }
                    //debugPrint("News is ")
                    //debugPrint(news)
                    
                    if news.count == 0 {
                        return
                    }
                    
                    self.newsArr = [News]()
                    
                    for n in news {
                        let title = n["title"].stringValue
                        let description = n["description"].stringValue
                        let author = n["author"].stringValue
                        let newss = News()
                        newss.author = author
                        newss.title = title
                        newss.description = description
                        self.newsArr.append(newss)
                    }
                    
                    self.tblNews.reloadData()
                }
                
            }
        }
}
