//
//  BottomSheetViewController.swift
//  BottomSheetTest
//
//  Created by Max Kraev on 18.01.2020.
//  Copyright © 2020 Max Kraev. All rights reserved.
//

import UIKit

public class BottomSheetViewController: UIViewController {
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public weak var delegate: BottomSheetViewControllerDelegate?
    public var bottomSheetView: BottomSheetView
    
    private var backgroundView = UIView()
    private var tapGesture = UITapGestureRecognizer()
    
    public init(bottomSheetView: BottomSheetView) {
        self.bottomSheetView = bottomSheetView
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSubviews()
    }
    
    // MARK:- Present
    
    /// Present modally
    /// - Parameter vc: viewController to present from
    public func present(from vc: UIViewController) {
        vc.present(self, animated: false)
    }
    
    // MARK:- Private
    
    private func setupSubviews() {
        backgroundView.backgroundColor = .clear
        bottomSheetView.delegate = self
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(bottomSheetView)
        self.bottomSheetView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
        
        view.layoutIfNeeded()
        
        bottomSheetView.didSetupConstraints = true
    }
    
    private func addTapGesture() {
        tapGesture.addTarget(self, action: #selector(onTap(sender:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func onTap(sender: UITapGestureRecognizer) {
        if !bottomSheetView.frame.contains(sender.location(in: view)), bottomSheetView.isDismissAllowed {
            dismissRoutine()
        }
    }
    
    fileprivate func dismissRoutine() {
        bottomSheetView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.dismiss(animated: false, completion: nil)
            self.delegate?.didDismiss()
        }
    }
}

//MARK:- Delegates

extension BottomSheetViewController: BottomSheetViewDelegate {
    public func heightDidChange(to y: CGFloat) {
        bottomSheetView.snp.updateConstraints { make in
            make.height.equalTo(y)
        }
        
        UIView.animate(withDuration: 0.1) {
            self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(y / self.view.frame.height)
        }
    }
    
    public func shouldDismiss(sender: UIView) {
        dismissRoutine()
    }
}

extension BottomSheetViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
