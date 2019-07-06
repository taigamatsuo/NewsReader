//
//  DetailViewController.swift
//  NewsReader
//
//  Created by 松尾大雅 on 2019/07/06.
//  Copyright © 2019 litech. All rights reserved.
//

import UIKit
import WebKit
//WebKitフレームワークをインポート
class DetailViewController : UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var link: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: self.link) {
            //linkプロパティを引数にしてurlインスタンスを作成
            let request = URLRequest(url: url)
            //urlインスタンスを引数にしてrequestクラスを作成
            self.webView.load(request)
            //作成requestインスタンスを引数にしてload(_:)メソッドを実行
        }
    }
    
    
}
