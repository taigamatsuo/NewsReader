//
//  ListViewController.swift
//  NewsReader
//
//  Created by 松尾大雅 on 2019/07/06.
//  Copyright © 2019 litech. All rights reserved.
//

import UIKit

//デリゲートの指定をする
class ListViewController: UITableViewController , XMLParserDelegate {
    var parser:XMLParser!
    var items = [Item]()
    var item:Item?
    var currentString = ""
    //表示するセルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //表示するセルの作成
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startDounload()
    }
    //startdownload
    
    //データのダウンロード
    func startDounload() {
        self.items = []//記事の重複を防ぐ
        if let url = URL(
            string: "https:/wired.jp/rssfeeder/"){
            if let parser = XMLParser(contentsOf: url) {
                self.parser = parser
                self.parser.delegate = self
                self.parser.parse()
            }
        }
}

    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName  qName: String?,
                attributes attributeDict: [String : String]) {
        self.currentString = ""
        if elementName == "item" {
            self.item = Item()
        }
    }
    
    
    
    func parser(_ parser:XMLParser , foundCharacters string : String) {
        self.currentString += string
    }
    //内容を取り出す処理
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        switch elementName {
        case "title": self.item?.title = currentString
        case "link": self.item?.link = currentString
        case "item": self.items.append(self.item!)
        default : break
        }
    }
    
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = items[indexPath.row]
            let controller = segue.destination as! DetailViewController
            controller.title = item.title
            controller.link = item.link
        }
    }
}
