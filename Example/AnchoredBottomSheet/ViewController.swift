//
//  ViewController.swift
//  AnchoredBottomSheet
//
//  Created by havebeenfitz on 01/19/2020.
//  Copyright (c) 2020 havebeenfitz. All rights reserved.
//

import UIKit
import AnchoredBottomSheet

class ViewController: UIViewController {
    
    let data = ExampleTableViewDataSource()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        title = "Bottom sheets"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        .forEach { $0.isActive = true }
    }
    
    fileprivate func presentModal(at index: Int) {
        switch index {
        case 0:
            presentWithContentHeight()
        case 1:
            presentModalWithTableView()
        case 2:
            pushSplitScreen()
        default:
            break
        }
    }
    
    private func presentWithContentHeight() {
        let configuration = BottomSheetViewConfiguration(
            contentView: data.tableView,
            parentViewController: self,
            defaultPosition: .byContent,
            positions: [.byContent],
            isPullIndicatorNeeded: true,
            isDismissAllowed: true
        )
        let bottomSheetView = BottomSheetView(configuration: configuration)
        let bottomSheetViewController = BottomSheetViewController(bottomSheetView: bottomSheetView)
        
        if #available(iOS 13.0, *) {
            bottomSheetView.backgroundColor = .systemBackground
        }
        
        bottomSheetViewController.delegate = self
        bottomSheetViewController.present(from: self)
    }
    
    func presentModalWithTableView() {
        let configuration = BottomSheetViewConfiguration(
            contentView: data.tableView,
            parentViewController: self,
            defaultPosition: .middle(),
            positions: [.middle(), .top(), .bottom()],
            isPullIndicatorNeeded: true,
            isDismissAllowed: true
        )
        let bottomSheetView = BottomSheetView(configuration: configuration)
        let bottomSheetViewController = BottomSheetViewController(bottomSheetView: bottomSheetView)
        
        bottomSheetViewController.delegate = self
        bottomSheetViewController.present(from: self)
        if #available(iOS 13.0, *) {
            bottomSheetView.backgroundColor = .systemBackground
        }
        
        data.tableView.reloadData()
    }
    
    func pushSplitScreen() {
        navigationController?.pushViewController(SplitViewController(), animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentModal(at: indexPath.row)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Present tableView with it's content height"
            return cell
        case 1:
            cell.textLabel?.text = "Present tableView with middle,\ntop and bottom anchors"
            return cell
        case 2:
            cell.textLabel?.text = "Push \"split screen\" with\naccessible background"
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ViewController: BottomSheetViewControllerDelegate {
    func didDismiss() {
        print("dismissed")
    }
}
