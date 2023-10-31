//
//  BottomSheetViewController.swift
//  BottomSheetTest
//
//  Created by Max Kraev on 18.01.2020.
//  Copyright © 2020 Max Kraev. All rights reserved.
//

import UIKit

open class BottomSheetViewController: UIViewController {
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public weak var delegate: BottomSheetViewControllerDelegate?
    public var bottomSheetView: BottomSheetView
    
    // From
    public var dismissOnAction: (() -> Void)?
    
    // To
    public var viewDidAppear: (() -> Void)?
    public var viewWillDisappear: (() -> Void)?
    public var viewDidDisappear: (() -> Void)?
    
    private var backgroundView = UIView()
    private var tapGesture = UITapGestureRecognizer()
    
    private var heightConstraint: NSLayoutConstraint?
    
    public init(bottomSheetView: BottomSheetView) {
        self.bottomSheetView = bottomSheetView
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        modalPresentationCapturesStatusBarAppearance = true
        addDismissOnActionEvent()
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
        viewDidAppear?()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidDisappear?()
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
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        [
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        .forEach { $0.isActive = true }
        
        
        view.addSubview(bottomSheetView)
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        [
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        .forEach { $0.isActive = true }
        
        heightConstraint = bottomSheetView.heightAnchor.constraint(equalToConstant: 0)
        
        view.setNeedsLayout()
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
    
    private func addDismissOnActionEvent() {
        dismissOnAction = { [weak self] in
            self?.dismissRoutine()
        }
    }
    
    fileprivate func dismissRoutine() {
        viewWillDisappear?()
        heightConstraint?.isActive = false
        heightConstraint = bottomSheetView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.2, animations: {
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
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: bottomSheetView) ?? false {
            return false
        }
        return true
    }
}
