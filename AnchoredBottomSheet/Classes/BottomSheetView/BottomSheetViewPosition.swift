//
//  BottomSheetViewPosition.swift
//  BottomSheetTest
//
//  Created by Max Kraev on 17.01.2020.
//  Copyright © 2020 Max Kraev. All rights reserved.
//

import UIKit

public enum BottomSheetViewPosition {
    case fixed(height: CGFloat)
    case top(height: CGFloat = BottomSheetViewConstants.topPositionHeight)
    case middle(height: CGFloat = BottomSheetViewConstants.middlePositionHeight)
    case bottom(height: CGFloat = BottomSheetViewConstants.bottomPositionHeight)
    case byContent
}
