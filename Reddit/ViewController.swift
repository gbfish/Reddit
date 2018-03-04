//
//  ViewController.swift
//  Reddit
//
//  Created by David Yu on 2018/3/3.
//  Copyright © 2018年 David Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(success: {
            print("success")
            DispatchQueue.main.async {
                
            }
            
            print("cellDataArray = \(self.cellDataArray)")
        })
    }
    
    // MARK: - Fetch data from server
    
    private func fetchData(success: @escaping () -> ()) {
        if let url = URL(string: "https://api.reddit.com") {
            _ = URLSession.shared.dataTask(with: url, completionHandler : {data, response, error -> Void in
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary {
                    self.updateData(json: json)
                    success()
                } else {
                    print("Cannot fetch data from server!")
                }
            }).resume()
        } else {
            print("The url is wrong!")
        }
    }
    
    // MARK: - Updata local data
    
    private struct CellData {
        let title: String
        let author: String
        let created: Int
        let thumbnail: String
        let numberOfComments: Int
    }
    
    private var cellDataArray = [CellData]()
    
    private func updateData(json: NSDictionary) {
        if let data = json["data"] as? NSDictionary, let children = data["children"] as? NSArray {
            for child in children {
                if let childDictionary = child as? NSDictionary {
                    if let data = childDictionary["data"] as? NSDictionary,
                        let title = data["title"] as? String,
                        let author = data["author"] as? String,
                        let created = data["created"] as? Int,
                        let thumbnail = data["thumbnail"] as? String,
                        let numberOfComments = data["num_comments"] as? Int {
                        cellDataArray.append(CellData(title: title, author: author, created: created, thumbnail: thumbnail, numberOfComments: numberOfComments))
                    }
                }
            }
        }
    }
    
    
    
    
}

