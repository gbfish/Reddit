//
//  HomeTableViewCell.swift
//  Reddit
//
//  Created by David Yu on 2018/3/4.
//  Copyright © 2018年 David Yu. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    func update(title: String, author: String, created: String, numberOfComments: String) {
        titleLabel.text = "Title: \(title)"
        authorLabel.text = "Author: \(author)"
        createdLabel.text = created
        numberOfCommentsLabel.text = "Number of comments: \(numberOfComments)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
