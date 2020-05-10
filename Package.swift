// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "YYSwift",
    platforms: [
        .iOS(.v13),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_14)
    ],
    products: [
        .library(name: "YYSwift", targets: ["YYSwift"])
    ],
    dependencies: [],
    targets: [
        .target(name: "YYSwift", dependencies: [], path: "Sources")
    ]
)
