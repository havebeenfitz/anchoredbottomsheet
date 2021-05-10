// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AnchoredBottomSheet",
    platforms: [.iOS(.v10)],
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
