//
//  BottomSheetViewDelegate.swift
//  BottomSheetTest
//
//  Created by Max Kraev on 17.01.2020.
//  Copyright © 2020 Max Kraev. All rights reserved.
//

import UIKit

public protocol BottomSheetViewDelegate: class {
    func heightDidChange(to y: CGFloat)
    func shouldDismiss(sender: UIView)
}

public extension BottomSheetViewDelegate {
    func shouldDismiss(sender: UIView) {}
}
