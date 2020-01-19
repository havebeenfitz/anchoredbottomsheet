//
//  BottomSheetViewConfiguration.swift
//  BottomSheetTest
//
//  Created by Max Kraev on 18.01.2020.
//  Copyright © 2020 Max Kraev. All rights reserved.
//

import UIKit

public class BottomSheetViewConfiguration {
    let contentView: UIView
    let parentViewController: UIViewController?
    let defaultPosition: BottomSheetViewPosition
    let positions: [BottomSheetViewPosition]
    
    let isPullIndicatorNeeded: Bool
    let isCloseButtonNeeded: Bool
    let isDismissAllowed: Bool
    let cornerRadius: CGFloat = 16
    
    public init(contentView: UIView, parentViewController: UIViewController?, defaultPosition: BottomSheetViewPosition = .middle(), positions: [BottomSheetViewPosition], isPullIndicatorNeeded: Bool, isCloseButtonNeeded: Bool, isDismissAllowed: Bool) {
        self.contentView = contentView
        self.parentViewController = parentViewController
        self.defaultPosition = defaultPosition
        self.positions = positions
        self.isPullIndicatorNeeded = isPullIndicatorNeeded
        self.isCloseButtonNeeded = isCloseButtonNeeded
        self.isDismissAllowed = isDismissAllowed
    }
}
