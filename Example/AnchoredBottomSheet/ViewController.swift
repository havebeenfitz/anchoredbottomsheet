//
//  ViewController.swift
//  AnchoredBottomSheet
//
//  Created by havebeenfitz on 01/19/2020.
//  Copyright (c) 2020 havebeenfitz. All rights reserved.
//

import UIKit
import AnchoredBottomSheet
import SnapKit

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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func presentModal(at index: Int) {
        switch index {
        case 0:
            presentModalWithStackView()
        case 1:
            presentModalWithTableView()
        case 2:
            pushSplitScreen()
        default:
            break
        }
    }
    
    private func presentModalWithStackView() {
        let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        button1.backgroundColor = .green
        
        let button2 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        button2.backgroundColor = .red
        
        let button3 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        button3.backgroundColor = .yellow
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        
        let configuration = BottomSheetViewConfiguration(contentView: stackView,
                                                         parentViewController: self,
                                                         defaultPosition: .middle(),
                                                         positions: [.middle(), .top()],
                                                         isPullIndicatorNeeded: true,
                                                         isCloseButtonNeeded: false,
                                                         isDismissAllowed: true)
        let bottomSheetView = BottomSheetView(configuration: configuration)
        let bottomSheetViewController = BottomSheetViewController(bottomSheetView: bottomSheetView)
        
        bottomSheetViewController.delegate = self
        bottomSheetViewController.present(from: self)
    }
    
    func presentModalWithTableView() {
        
        let configuration = BottomSheetViewConfiguration(contentView: data.tableView,
                                                         parentViewController: self,
                                                         defaultPosition: .middle(),
                                                         positions: [.middle(), .top(), .bottom()],
                                                         isPullIndicatorNeeded: true,
                                                         isCloseButtonNeeded: false,
                                                         isDismissAllowed: true)
        let bottomSheetView = BottomSheetView(configuration: configuration)
        let bottomSheetViewController = BottomSheetViewController(bottomSheetView: bottomSheetView)
        
        bottomSheetViewController.delegate = self
        bottomSheetViewController.present(from: self)
        
        data.tableView.reloadData()
    }
    
    func pushSplitScreen() {
        navigationController?.pushViewController(SplitViewController(), animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentModal(at: indexPath.row)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Present with stackView"
            return cell
        case 1:
            cell.textLabel?.text = "Present with tableView"
            return cell
        case 2:
            cell.textLabel?.text = "Push \"split screen\""
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

