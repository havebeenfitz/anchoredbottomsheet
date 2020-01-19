//
//  BottomSheetViewConstants.swift
//  BottomSheetTest
//
//  Created by Max Kraev on 18.01.2020.
//  Copyright © 2020 Max Kraev. All rights reserved.
//

import UIKit

public struct BottomSheetViewConstants {
    public static let topPositionHeight: CGFloat = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - 60 // Navigation bar height
    public static let middlePositionHeight: CGFloat = UIScreen.main.bounds.height / 2 + 100 // for keyboard and textFields
    public static let bottomPositionHeight: CGFloat = 100
}
