//
//  DetailViewController.swift
//  NewsReader
//
//  Created by 松尾大雅 on 2019/07/06.
//  Copyright © 2019 litech. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var link: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: self.link) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    
    
}
