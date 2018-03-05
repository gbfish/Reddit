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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
    
    // MARK: - Local data
    
    private struct CellData {
        let title: String
        let author: String
        let created: Int
        let numberOfComments: Int
        let thumbnail: String
        let thumbnailWidth: Int
        let thumbnailHeight: Int
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
                        let numberOfComments = data["num_comments"] as? Int,
                        let thumbnail = data["thumbnail"] as? String,
                        let thumbnailWidth = data["thumbnail_width"] as? Int,
                        let thumbnailHeight = data["thumbnail_height"] as? Int {
                        let cellData = CellData(title: title, author: author, created: created, numberOfComments: numberOfComments, thumbnail: thumbnail, thumbnailWidth: thumbnailWidth, thumbnailHeight: thumbnailHeight)
                        cellDataArray.append(cellData)
                    }
                }
            }
        }
        cellDataArray.sort(by: { $0.created < $1.created })
    }
    
    // MARK: - TableView
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
        if let homeTableViewCell = cell as? HomeTableViewCell {
            let cellData = cellDataArray[indexPath.row]
            homeTableViewCell.update(title: cellData.title, author: cellData.author, created: "\(cellData.created)", numberOfComments: String(cellData.numberOfComments), thumbnail: cellData.thumbnail, thumbnailWidth: cellData.thumbnailWidth, thumbnailHeight: cellData.thumbnailHeight)
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
