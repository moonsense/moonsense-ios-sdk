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
            url: "https://github.com/moonsense/moonsense-ios-sdk/releases/download/0.1.0-alpha2/MoonsenseSDK.xcframework.zip",
            checksum: "2f05dced2bdd25ffaeddd54c8403b43881f64c4a7740ff2300eb64de3a8d0c7c"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://github.com/moonsense/moonsense-ios-sdk/releases/download/0.1.0-alpha2/MoonsenseSDK-static.xcframework.zip",
            checksum: "12e019bcbfe8cb9b2eccbe4ffca325677f3ab782bf26ed445e32fd4d2758c8c7"
        )
    ]
)
