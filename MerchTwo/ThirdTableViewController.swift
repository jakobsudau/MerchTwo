//
//  SecondViewController.swift
//  MerchTwo
//
//  Created by JSudau on 04.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class ThirdTableViewController: UITableViewController {
    
    var stockItemsData = [itemData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        if let data = UserDefaults.standard.value(forKey:"stockItemsData") as? Data {
            stockItemsData = try! PropertyListDecoder().decode(Array<itemData>.self, from: data)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapButton))
        self.navigationItem.title = "Stock"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
    }
    
    @objc func tapButton() {
        print("You tapped!")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return stockItemsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if stockItemsData[section].opened {
            return stockItemsData[section].options.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SecondTableViewCell
            cell?.parentThirdTableViewController = self
            cell?.cellImage.image = UIImage(data: stockItemsData[indexPath.section].imageData)
            cell?.cellTitle.text = stockItemsData[indexPath.section].title
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell") as? SecondTableViewSubCell
            cell?.textLabel?.text = stockItemsData[indexPath.section].options[dataIndex]
            return cell!
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0  {
            if stockItemsData[indexPath.section].opened == true {
                stockItemsData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                stockItemsData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 85
        } else {
            return 44
        }
    }
}
