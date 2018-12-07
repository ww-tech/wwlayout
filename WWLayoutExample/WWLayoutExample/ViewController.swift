//
//===----------------------------------------------------------------------===//
//
//  ViewController.swift
//
//  Created by Steven Grosmark on 12/1/17.
//  Copyright © 2018 WW International, Inc.
//
//
//  This source file is part of the WWLayout open source project
//
//     https://github.com/ww-tech/wwlayout
//
//  Copyright © 2017-2018 WW International, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//===----------------------------------------------------------------------===//
//

import UIKit
import WWLayout

class ViewController: UIViewController {

    fileprivate let cellIdentifier = "Cell"
    fileprivate var tableView: UITableView?
    
    fileprivate struct Item {
        let label: String
        let controller: () -> UIViewController
    }
    fileprivate var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "WW Layout Samples"
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"Samples", style:.plain, target:nil, action:nil)
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        items = [
            Item(label: "Basic Sample", controller: { return BasicSample() }),
            Item(label: "Safe Area Sample", controller: { return self.wrapInTabBar(SafeAreaSample()) } ),
            Item(label: "Layout Margins Sample", controller: { return self.wrapInTabBar(LayoutMarginsSample()) } ),
            Item(label: "Three Edges", controller: { return ThreeEdges() } ),
            Item(label: "Fill Width", controller: { return FillWidthSample() } ),
            Item(label: "Center Edges", controller: { return CenterEdges() } ),
            Item(label: "Baseline Edges", controller: { return Baselines() } )
        ]
        
        tableView = UITableView()
        if let tableView = tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
            tableView.dataSource = self
            tableView.delegate = self
            view.addSubview(tableView)
        }
    }
    
    private func wrapInTabBar(_ controller: UIViewController) -> UIViewController {
        controller.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [controller]
        return tabBarController
    }
    
    private func setupConstraints() {
        tableView?.layout.fill(.superview)
    }

}

extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = items[indexPath.row].label
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        navigationController?.pushViewController(item.controller(), animated: true)
    }
}
