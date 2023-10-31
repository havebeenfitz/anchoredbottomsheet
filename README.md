![Untitled_Artwork 4](https://user-images.githubusercontent.com/31866271/117677140-dc1d3d00-b1b6-11eb-9b55-aade5409b006.png)

![Platform](https://img.shields.io/badge/platform-iOS-lightgrey?style=flat)
[![CI Status](https://img.shields.io/github/actions/workflow/status/havebeenfitz/anchoredbottomsheet/swift.yml?style=flat)](https://github.com/havebeenfitz/anchoredbottomsheet/actions/workflows/swift.yml)
![SPM](https://img.shields.io/badge/spm-compatible-success)
![Carthage](https://img.shields.io/badge/carthage-compatible-success)
![License](https://img.shields.io/github/license/havebeenfitz/anchoredbottomsheet?style=flat)

## About

![demo](https://user-images.githubusercontent.com/31866271/167087146-5d2d1bb4-4f80-4c67-bd3d-1c39ac708518.gif)

This is iOS Maps like anchored bottom sheet with configurable anchors and reusable `BottomSheetView`, that can be used inside provided modal controller or without it.

`BottomSheetView` supports all kinds of `UIView's` including `UIScrollView` and it's ancestors as a container view.

`BottomSheetViewController` is intended to be used as a modal presented controller.

To configure `BottomSheetView` you should use `BottomSheetViewConfiguration` struct like this:

```swift
let config = BottomSheetViewConfiguration(
    contentView: UIView(),
    parentViewController: self,
    defaultPosition: .middle(),
    positions: [.top(), .middle(), .bottom()],
    isSlidingToAppear: false,
    isPullIndicatorNeeded: true,
    closeButtonIcon: UIImage(named: "closeIcon"),
    isDismissAllowed: false,
    cornerRadius: 16
)
```

Supported anchors: 
1. Top
2. Middle
3. Bottom
4. Fixed
5. By content

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


## Installation

### Cocoapods

AnchoredBottomSheet is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AnchoredBottomSheet', '~> 1.6.4'
```


### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate AnchoredBottomSheet into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "havebeenfitz/anchoredbottomsheet" "1.6.4"
```

Run `carthage update` to build the framework and drag the built `SnapKit.framework` into your Xcode project.

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

> Xcode 14+ is required to build AnchoredBottomSheet using Swift Package Manager.

To integrate AnchoredBottomSheet into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/havebeenfitz/anchoredbottomsheet.git",
        .upToNextMajor(from: "1.6.4")
    )
]
```

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate AnchoredBottomSheet into your project manually.

---

## Requirements

Xcode 14+, iOS deployment target ≥ 12

## Author

havebeenfitz, max.kraev@gmail.com

## License

AnchoredBottomSheet is available under the MIT license. See the LICENSE file for more info.
