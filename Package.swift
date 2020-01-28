// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "WWLayout",
    platforms: [
        .iOS(.v10),
        .tvOS(.v10)
    ],
    products: [
        .library(
            name: "WWLayout",
            targets: ["WWLayout"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "WWLayout",
            dependencies: []),
        .testTarget(
            name: "WWLayoutTests",
            dependencies: ["WWLayout"])
    ]
)
