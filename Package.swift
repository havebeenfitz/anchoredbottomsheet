// swift-tools-version:5.5

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
