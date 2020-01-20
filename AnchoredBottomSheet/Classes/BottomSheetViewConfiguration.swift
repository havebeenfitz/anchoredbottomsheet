//
//  BottomSheetViewConfiguration.swift
//  BottomSheetTest
//
//  Created by Max Kraev on 18.01.2020.
//  Copyright © 2020 Max Kraev. All rights reserved.
//

import UIKit

public class BottomSheetViewConfiguration {
    /// Any UIView to contain
    let contentView: UIView
    /// Coordinate system for pan gesture
    let parentViewController: UIViewController?
    /// Middle by default
    let defaultPosition: BottomSheetViewPosition
    /// Avalilable positions
    let positions: [BottomSheetViewPosition]
    /// Should slide from bottom or not
    let isSlidingToAppear: Bool
    /// Gray line to grab to
    let isPullIndicatorNeeded: Bool
    /// Appears on the top right corner, notifies the delegate
    let isCloseButtonNeeded: Bool
    /// Can dismiss or not. Not to use with close button
    let isDismissAllowed: Bool
    /// Corner radius of the bottom sheet. Default to 16
    let cornerRadius: CGFloat
    
    public init(contentView: UIView,
                parentViewController: UIViewController?,
                defaultPosition: BottomSheetViewPosition = .middle(),
                positions: [BottomSheetViewPosition],
                isSlidingToAppear: Bool = true,
                isPullIndicatorNeeded: Bool,
                isCloseButtonNeeded: Bool,
                isDismissAllowed: Bool,
                cornerRadius: CGFloat = 16) {
        self.contentView = contentView
        self.parentViewController = parentViewController
        self.defaultPosition = defaultPosition
        self.positions = positions
        
        self.isSlidingToAppear = isSlidingToAppear
        
        self.isPullIndicatorNeeded = isPullIndicatorNeeded
        self.isCloseButtonNeeded = isCloseButtonNeeded
        self.isDismissAllowed = isDismissAllowed
        
        self.cornerRadius = cornerRadius
    }
}
