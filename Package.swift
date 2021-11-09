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
            url: "https://github.com/moonsense/moonsense-ios-sdk/releases/download/0.1.0-alpha5/MoonsenseSDK.xcframework.zip",
            checksum: "b728363ab9c45b7157afd2ce31005b764db26545cf676554adf412ac1d125918"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://github.com/moonsense/moonsense-ios-sdk/releases/download/0.1.0-alpha5/MoonsenseSDK-static.xcframework.zip",
            checksum: "f0d5df48fa7fab1640273d67153e0a8f5c25d66c6c72a7eed5721fe7476e20f2"
        )
    ]
)
