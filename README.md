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

## About

<img width="300" alt="Screenshot 2020-01-19 at 20 06 23" src="https://user-images.githubusercontent.com/31866271/72685093-ab178580-3af7-11ea-8456-f1eefcd0fa56.png">


This is iOS Maps like anchored bottom sheet with configurable anchors and reusable `BottomSheetView`, that can be used inside provided modal controller or without it.

`BottomSheetView` supports all kinds of `UIView's` including `UIScrollView` and it's ancestors as a container view.

`BottomSheetViewController` is intended to use as a modal presented controller.

To configure `BottomSheetView` you should use `BottomSheetViewConfiguration` struct like follwing:

```swift
let configuration = BottomSheetViewConfiguration(contentView: data.tableView,
                                                 parentViewController: self,
                                                 defaultPosition: .middle(),
                                                 positions: [.middle(), .top(), .bottom()],
                                                 isPullIndicatorNeeded: true,
                                                 isCloseButtonNeeded: false,
                                                 isDismissAllowed: true)
```

Supported anchors: 
1. Top
2. Middle
3. Bottom
4. Fixed

Each anchor has associated value, which override default height for this anchor.
By content mode is not yet implemented, feel free to open a pull request.

When configuration is done, create `BottomSheetView` like this:
```swift
let bottomSheetView = BottomSheetView(configuration: configuration)
```

If you want to use this view for some complex UI cases, `BottomSheetView` will handle the pan gesture and will notify `BottomSheetViewDelegate` in `heightDidChange(to height: CGFloat)` method

If you want to implement general pop-up behaviour, you should use `BottomSheetViewController`. Create and present it like so:
```swift
let bottomSheetViewController = BottomSheetViewController(bottomSheetView: bottomSheetView)
        
bottomSheetViewController.delegate = sel
bottomSheetViewController.present(from: self)
```


## Author

havebeenfitz, max.kraev@gmail.com

## License

AnchoredBottomSheet is available under the MIT license. See the LICENSE file for more info.
