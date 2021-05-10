//
//  BottomSheetView.swift
//  BottomSheetTest
//
//  Created by Max Kraev on 17.01.2020.
//  Copyright © 2020 Max Kraev. All rights reserved.
//

import UIKit

public class BottomSheetView: UIView {
    
    // MARK:- Interface
    
    public private(set) var isDismissAllowed: Bool
    public private(set) var defaultPosition: BottomSheetViewPosition = .middle()
    public var didSetupConstraints: Bool = false {
        didSet {
            setInitialHeight()
        }
    }
    public weak var delegate: BottomSheetViewDelegate?
    
    // MARK:- Private
    
    private var heightConstraint: NSLayoutConstraint?
    
    private lazy var currentPosition: BottomSheetViewPosition = defaultPosition
    private var fixedPositionHeight: CGFloat = 0
    private var topPositionHeight: CGFloat = 0
    private var middlePositionHeight: CGFloat = 0
    private var bottomPositionHeight: CGFloat = 0
    private var byContentPositionHeight: CGFloat = 0
    
    private let contentView: UIView
    private weak var parentViewController: UIViewController?
    private let positions: [BottomSheetViewPosition]
    private let isSlidingToAppear: Bool
    private let isPullIndicatorNeeded: Bool
    private let closeButtonIcon: UIImage?
    private let cornerRadius: CGFloat
    
    private lazy var startPositionY: CGFloat = frame.height
    
    private let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    
    private let pullIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 229 / 255, green: 229 / 255, blue: 229 / 255, alpha: 1)
        
        return view
    }()
    
    private var closeButton: UIButton?
    
    public init(configuration: BottomSheetViewConfiguration) {
        self.contentView = configuration.contentView
        self.parentViewController = configuration.parentViewController
        self.defaultPosition = configuration.defaultPosition
        self.positions = configuration.positions
        self.isSlidingToAppear = configuration.isSlidingToAppear
        self.isPullIndicatorNeeded = configuration.isPullIndicatorNeeded
        self.closeButtonIcon = configuration.closeButtonIcon
        self.isDismissAllowed = configuration.isDismissAllowed
        self.cornerRadius = configuration.cornerRadius
        super.init(frame: CGRect.zero)
        setup()
        addPanGesture()
        checkPositions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        pullIndicatorView.layer.cornerRadius = 2
    }
    
    
    
    private func checkPositions() {
        for position in positions {
            switch position {
            case let .fixed(height: height):
                fixedPositionHeight = height
                if positions.count > 1 {
                    assertionFailure("Should only use fixed position")
                }
            case let .top(height: height):
                topPositionHeight = height
            case let .middle(height: height):
                middlePositionHeight = height
            case let .bottom(height: height):
                bottomPositionHeight = height
            case .byContent:
                if let scrollView = contentView as? UIScrollView {
                    let finalRect = scrollView.contentSize
                    byContentPositionHeight = finalRect.height + 70
                } else {
                    let finalRect: CGRect = contentView.subviews.reduce(into: .zero) { rect, subview in
                        rect = rect.union(subview.frame)
                    }
                    byContentPositionHeight = finalRect.height
                }
            }
        }
    }
    
    private func setup() {
        backgroundColor = .white
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        if isPullIndicatorNeeded {
            addSubview(pullIndicatorView)
            pullIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            [
                pullIndicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                pullIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
                pullIndicatorView.heightAnchor.constraint(equalToConstant: 3),
                pullIndicatorView.widthAnchor.constraint(equalToConstant: 104)
            ]
            .forEach { $0.isActive = true }

            [
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentView.topAnchor.constraint(equalTo: pullIndicatorView.bottomAnchor, constant: 16)
            ]
            .forEach { $0.isActive = true }
        } else {
            [
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentView.topAnchor.constraint(equalTo: topAnchor, constant: 16)
            ]
            .forEach { $0.isActive = true }
        }
        
        if contentView.isKind(of: UIScrollView.self) {
            let constraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            constraint.priority = .init(999)
            constraint.isActive = true
        }
        
        
        if let closeButtonIcon = closeButtonIcon {
            closeButton = UIButton()
            closeButton?.setImage(closeButtonIcon, for: .normal)
            addSubview(closeButton ?? UIButton())
            closeButton?.translatesAutoresizingMaskIntoConstraints = false
            [
                closeButton?.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                closeButton?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ]
            .forEach { $0?.isActive = true }
            
            closeButton?.addTarget(self, action: #selector(onClose(sender:)), for: .touchUpInside)
        }
    }
    
    @objc private func onClose(sender: UIButton) {
        if isDismissAllowed {
            delegate?.shouldDismiss(sender: sender)
        } else {
            assertionFailure("You prohibited the dismiss. Consider removing close button")
        }
    }
    
    private func setInitialHeight() {
        if superview != nil {
            switch currentPosition {
            case .fixed(let height):
                setInitialHeight(height)
            case .top(let height):
                setInitialHeight(height)
            case .middle(let height):
                setInitialHeight(height)
            case .bottom(let height):
                setInitialHeight(height)
            case .byContent:
                setInitialHeight(byContentPositionHeight)
            }
        }
    }
    
    private func setInitialHeight(_ height: CGFloat) {
        heightConstraint?.isActive = false
        heightConstraint = heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.priority = .init(999)
        heightConstraint?.isActive = true
        
        setNeedsLayout()
        
        if isSlidingToAppear {
            UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent, animations: {
                self.superview?.layoutIfNeeded()
                self.delegate?.heightDidChange(to: height)
            })
        } else {
            delegate?.heightDidChange(to: height)
        }
    }
    
    private func addPanGesture() {
        addGestureRecognizer(panGesture)
        panGesture.delegate = self
        panGesture.addTarget(self, action: #selector(pan(sender:)))
    }
    
    @objc private func pan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .possible:
            startPositionY = frame.height
        case .changed:
            if let scrollView = contentView as? UIScrollView, scrollView.contentOffset.y <= 0 {
                scrollView.contentOffset.y = 0
            }
            let height = -sender.translation(in: parentViewController?.view).y + startPositionY
            update(height: height, animated: false)
        case .cancelled, .ended, .failed:
            startPositionY = frame.height
            if sender.velocity(in: parentViewController?.view).y > 1000, isDismissAllowed {
                delegate?.shouldDismiss(sender: self)
                break
            }
            
            moveToClosestAnchor(from: -sender.translation(in: parentViewController?.view).y + startPositionY, velocity: sender.velocity(in: parentViewController?.view).y)
        @unknown default:
            break
        }
    }
    
    private func moveToClosestAnchor(from y: CGFloat?, velocity: CGFloat) {
        guard let y = y else { return }
        
        switch currentPosition {
        case .fixed(let height):
            change(to: .fixed(height: height))
        case .top(let height):
            if height <= y, velocity <= 0, topPositionHeight != 0 {
                change(to: .top(height: topPositionHeight))
            } else if height >= y, velocity >= 0, middlePositionHeight != 0 {
                change(to: .middle(height: middlePositionHeight))
            } else if height >= y, velocity >= 0, bottomPositionHeight != 0 {
                change(to: .bottom(height: bottomPositionHeight))
            } else {
                change(to: .top(height: topPositionHeight))
            }
        case .middle(let height):
            if height <= y, velocity <= 0, topPositionHeight != 0 {
                change(to: .top(height: topPositionHeight))
            } else if height >= y, velocity >= 0, bottomPositionHeight != 0 {
                change(to: .bottom(height: bottomPositionHeight))
            } else {
                change(to: .middle(height: middlePositionHeight))
            }
        case .bottom(let height):
            if height >= y, velocity >= 0, bottomPositionHeight != 0 {
                change(to: .bottom(height: bottomPositionHeight))
            } else if height <= y, velocity <= 0, middlePositionHeight != 0 {
                change(to: .middle(height: middlePositionHeight))
            } else if height <= y, velocity <= 0, topPositionHeight != 0 {
                change(to: .top(height: topPositionHeight))
            }
        case .byContent:
            change(to: .byContent)
        }
    }
    
    private func change(to newPosition: BottomSheetViewPosition) {
        
        switch newPosition {
        case .fixed(let height):
            update(height: height)
        case .top:
            update(height: topPositionHeight)
            currentPosition = .top(height: topPositionHeight)
        case .middle:
            update(height: middlePositionHeight)
            currentPosition = .middle(height: middlePositionHeight)
        case .bottom:
            update(height: bottomPositionHeight)
            currentPosition = .bottom(height: bottomPositionHeight)
        case .byContent:
            update(height: byContentPositionHeight)
            currentPosition = .byContent
        }
    }
    
    private func update(height: CGFloat, animated: Bool = true) {
        heightConstraint?.isActive = false
        heightConstraint = heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.priority = .init(999)
        heightConstraint?.isActive = true
        
        setNeedsLayout()
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: ({
                self.superview?.layoutIfNeeded()
            }))
        }
        
        delegate?.heightDidChange(to: height)
    }
}

extension BottomSheetView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let scrollView = contentView as? UIScrollView else {
            return false
        }
        
        return scrollView.contentOffset.y == 0 && panGesture.velocity(in: parentViewController?.view).y > 0
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: contentView) ?? false) && gestureRecognizer.isKind(of: UITapGestureRecognizer.self) {
            return false
        }
        
        return true
    }
}
