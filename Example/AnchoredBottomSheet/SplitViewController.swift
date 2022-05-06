//
//  SplitViewController.swift
//  AnchoredBottomSheet_Example
//
//  Created by Max Kraev on 20.01.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import AnchoredBottomSheet

class SplitViewController: UIViewController {
    private let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        return view
    }()
    
    private let accessibleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Push me, I'm accessible", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.darkGray, for: .highlighted)
        button.titleEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        button.layer.cornerRadius = 25
        return button
    }()
    
    private lazy var bottomSheetView: BottomSheetView = {
        let label = UILabel()
        label.text = "   Some content here"
        let config = BottomSheetViewConfiguration(
            contentView: label,
            parentViewController: self,
            defaultPosition: .middle(),
            positions: [.top(), .middle(), .bottom()],
            isSlidingToAppear: false,
            isPullIndicatorNeeded: true,
            isDismissAllowed: false
        )
        let view = BottomSheetView(configuration: config)
        view.delegate = self
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
        
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bottomSheetView.didSetupConstraints = true
    }
    
    private func setup() {
        view.backgroundColor = .red
        view.addSubview(yellowView)
        view.addSubview(bottomSheetView)
        
        yellowView.addSubview(accessibleButton)
        accessibleButton.translatesAutoresizingMaskIntoConstraints = false
        [
            accessibleButton.centerXAnchor.constraint(equalTo: yellowView.centerXAnchor),
            accessibleButton.centerYAnchor.constraint(equalTo: yellowView.centerYAnchor),
            accessibleButton.heightAnchor.constraint(equalToConstant: 50),
            accessibleButton.widthAnchor.constraint(equalToConstant: 250)
        ]
        .forEach { $0.isActive = true }
        
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        [
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        .forEach { $0.isActive = true }
        
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        [
            yellowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            yellowView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            yellowView.topAnchor.constraint(equalTo: view.topAnchor),
            yellowView.bottomAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 20)
        ]
        .forEach { $0.isActive = true}
    }
}

extension SplitViewController: BottomSheetViewDelegate {
    
    func heightDidChange(to y: CGFloat) {
        print("Height did change to: \(y)")
    }
    
}
