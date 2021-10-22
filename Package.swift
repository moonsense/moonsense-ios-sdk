// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MoonsenseSDK",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "MoonsenseSDK",
            targets: ["MoonsenseSDK"]),
        .library(
            name: "MoonsenseSDK-static",
            targets: ["MoonsenseSDK-static"])
    ],
    targets: [
        .binaryTarget(
            name: "MoonsenseSDK",
            url: "https://github.com/moonsense/moonsense-ios-sdk/releases/download/0.1.0-alpha4/MoonsenseSDK.xcframework.zip",
            checksum: "07a0e73df364ec72182c48af9beda686b6c686acee9f50de78ea9413e5d63fc1"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://github.com/moonsense/moonsense-ios-sdk/releases/download/0.1.0-alpha4/MoonsenseSDK-static.xcframework.zip",
            checksum: "cf21919d4ef15edbed39c14bc7f9c232361ff50bd89832fd45ff646d8e054682"
        )
    ]
)
