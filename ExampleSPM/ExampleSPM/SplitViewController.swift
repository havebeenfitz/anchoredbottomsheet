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
        view.backgroundColor = .systemYellow
        return view
    }()
    
    private lazy var bottomSheetView: BottomSheetView = {
        let config = BottomSheetViewConfiguration(contentView: UIView(),
                                                  parentViewController: self,
                                                  defaultPosition: .middle(),
                                                  positions: [.top(), .middle(), .bottom()],
                                                  isSlidingToAppear: false,
                                                  isPullIndicatorNeeded: true,
                                                  isDismissAllowed: false)
        let view = BottomSheetView(configuration: config)
        view.delegate = self
        
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
        
        bottomSheetView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
        
        yellowView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(bottomSheetView.snp.top).inset(20)
        }
    }
}

extension SplitViewController: BottomSheetViewDelegate {
    func heightDidChange(to y: CGFloat) {
        print("Height did change to: \(y)")
    }
}
