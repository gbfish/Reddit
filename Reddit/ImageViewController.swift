//
//  ImageViewController.swift
//  Reddit
//
//  Created by David Yu on 2018/3/4.
//  Copyright © 2018年 David Yu. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: imageURL) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    var imageURL = ""
}
