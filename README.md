# AnchoredBottomSheet

[![CI Status](https://img.shields.io/travis/havebeenfitz/AnchoredBottomSheet.svg?style=flat)](https://travis-ci.org/havebeenfitz/AnchoredBottomSheet)
[![Version](https://img.shields.io/cocoapods/v/AnchoredBottomSheet.svg?style=flat)](https://cocoapods.org/pods/AnchoredBottomSheet)
[![License](https://img.shields.io/cocoapods/l/AnchoredBottomSheet.svg?style=flat)](https://cocoapods.org/pods/AnchoredBottomSheet)
[![Platform](https://img.shields.io/cocoapods/p/AnchoredBottomSheet.svg?style=flat)](https://cocoapods.org/pods/AnchoredBottomSheet)

## Installation

AnchoredBottomSheet is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AnchoredBottomSheet'
```

## Requirements

Xcode 11, iOS deployment target ≥ 10

## About

<img width="250" alt="top" src="https://user-images.githubusercontent.com/31866271/72686183-ef5c5300-3b02-11ea-8ba2-a393273eb76d.png"><img width="250" alt="middle" src="https://user-images.githubusercontent.com/31866271/72686162-b6bc7980-3b02-11ea-9b79-7ba7d524695a.png"><img width="250" alt="bottom" src="https://user-images.githubusercontent.com/31866271/72686163-b6bc7980-3b02-11ea-9227-b5954d655104.png">



This is iOS Maps like anchored bottom sheet with configurable anchors and reusable `BottomSheetView`, that can be used inside provided modal controller or without it.

`BottomSheetView` supports all kinds of `UIView's` including `UIScrollView` and it's ancestors as a container view.

`BottomSheetViewController` is intended to be used as a modal presented controller.

To configure `BottomSheetView` you should use `BottomSheetViewConfiguration` struct like this:

```swift
let config = BottomSheetViewConfiguration(contentView: UIView(),
                                          parentViewController: self,
                                          defaultPosition: .middle(),
                                          positions: [.top(), .middle(), .bottom()],
                                          isSlidingToAppear: false,
                                          isPullIndicatorNeeded: true,
                                          isCloseButtonNeeded: false,
                                          isDismissAllowed: false,
                                          cornerRadius: 16)
```

Supported anchors: 
1. Top
2. Middle
3. Bottom
4. Fixed

Each anchor has associated value, which will override default height for this anchor.
By content mode is not yet implemented, feel free to open a pull request.

Once configuration is done, you should create `BottomSheetView` like this:
```swift
let bottomSheetView = BottomSheetView(configuration: configuration)
```

If you want to use this view for some complex UI cases, `BottomSheetView` will handle the pan gesture and will notify `BottomSheetViewDelegate` in `heightDidChange(to height: CGFloat)` method

If you want to implement general pop-up behaviour, you should use `BottomSheetViewController`. Create and present it like so:
```swift
let bottomSheetViewController = BottomSheetViewController(bottomSheetView: bottomSheetView)
        
bottomSheetViewController.delegate = self
bottomSheetViewController.present(from: self)
```

### This library uses a SnapKit as subdependency, please be aware

## Author

havebeenfitz, max.kraev@gmail.com

## License

AnchoredBottomSheet is available under the MIT license. See the LICENSE file for more info.
