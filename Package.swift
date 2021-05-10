// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AnchoredBottomSheet",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "AnchoredBottomSheet",
            targets: ["AnchoredBottomSheet"])
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(
            name: "AnchoredBottomSheet",
            dependencies: ["SnapKit"],
            path: "AnchoredBottomSheet",
            exclude: ["Example/", "ExampleSPM/", "AnchoredBottomSheet.podspec"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
