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
            url: "https://github.com/moonsense/moonsense-ios-sdk/releases/download/0.1.0-alpha3/MoonsenseSDK.xcframework.zip",
            checksum: "734c088749105e4f58d4ec0b692c6efdcca331060b8339ec9c43c49d028d93c9"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://github.com/moonsense/moonsense-ios-sdk/releases/download/0.1.0-alpha3/MoonsenseSDK-static.xcframework.zip",
            checksum: "8f717a1cc356d247393292504687bd0fa02ebe5cf3bab6a0ac9866230e9dc00a"
        )
    ]
)
