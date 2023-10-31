// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "AnchoredBottomSheet",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "AnchoredBottomSheet",
            targets: ["AnchoredBottomSheet"]
        )
    ],
    targets: [
        .target(
            name: "AnchoredBottomSheet"
        )
    ],
    swiftLanguageVersions: [.v5]
)
