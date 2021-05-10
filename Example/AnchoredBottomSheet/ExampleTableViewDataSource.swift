//
//  ExampleTableViewDataSource.swift
//  AnchoredBottomSheet_Example
//
//  Created by Max Kraev on 19.01.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import AnchoredBottomSheet

class ExampleTableViewDataSource: NSObject {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        
        return tableView
    }()
}

extension ExampleTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = "Index is \(indexPath.row)"
        return cell
    }
}
