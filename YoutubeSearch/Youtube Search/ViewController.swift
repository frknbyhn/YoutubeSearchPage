//
//  ViewController.swift
//  Youtube Search
//
//  Created by Furkan Beyhan on 28.02.2019.
//  Copyright © 2019 Furkan Beyhan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var dataList = [SearchItem]()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
            Alamofire.request("https://www.googleapis.com/youtube/v3/search?part=snippet&q=lokmata&key=API_KEY_HERE&maxResults=25").responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    
                    let decoder = JSONDecoder()
                    let response = try! decoder.decode(Response.self, from: responseData.data!)
                    
                    self.dataList = response.items!
                    self.tableView.reloadData()
                  
                }
                
            }
        tableView.delegate = self
        tableView.dataSource = self
        
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jsonCell")!
        let item = dataList[indexPath.row]
        cell.textLabel?.text = item.snippet!.title
        cell.detailTextLabel?.text = item.snippet!.description
        cell.imageView?.kf.setImage(with: URL(string : item.snippet!.thumbnails!.high!.url!))
        
        return cell
    }
        
    }
