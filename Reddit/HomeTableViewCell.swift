//
//  HomeTableViewCell.swift
//  Reddit
//
//  Created by David Yu on 2018/3/4.
//  Copyright © 2018年 David Yu. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    func update(title: String, author: String, created: String, numberOfComments: String, thumbnail: String, thumbnailWidth: Int, thumbnailHeight: Int) {
        titleLabel.text = "Title: \(title)"
        authorLabel.text = "Author: \(author)"
        createdLabel.text = created
        numberOfCommentsLabel.text = "Number of comments: \(numberOfComments)"
        
        if let thumbnailURL = URL(string: thumbnail) {
            URLSession.shared.dataTask(with: thumbnailURL) { data, response, error in
                if let data = data, let image = UIImage(data: data), let responseURL = response?.url?.absoluteString, responseURL == thumbnail {
                    DispatchQueue.main.async() {
                        self.thumbnailImageView.image = image
                    }
                }
                }.resume()
        }
    }
}
