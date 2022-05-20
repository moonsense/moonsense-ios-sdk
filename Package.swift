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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/0.4.0/MoonsenseSDK.xcframework-0.4.0.zip",
            checksum: "2731cc1dd2011409b73ebe5a934c8a9647ce78e4152d45d643f664ce81d9e7b3"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/0.4.0/MoonsenseSDK-static.xcframework-0.4.0.zip",
            checksum: "ca5a8afb2af7977e4e18f4c8b01882356f97be417eb5f005a36ff1fc3d4ab4e9"
        )
    ]
)
