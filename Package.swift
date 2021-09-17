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
    ],
    targets: [
        .binaryTarget(
            name: "MoonsenseSDK",
            url: "https://github.com/moonsense/moonsense-ios-sdk/releases/download/0.1.0-alpha1/MoonsenseSDK.xcframework.zip",
            checksum: "7495f380cab3ccf1b89e292fa536b07a3186261434dbf0c69494f4ffc0b8e22c"
        )
    ]
)
