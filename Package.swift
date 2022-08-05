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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/1.1.0/MoonsenseSDK.xcframework-1.1.0.zip",
            checksum: "4f0d9a2d0e238bcde47ee04e3bdb38a59f74490636487e2deb8de13d95e82517"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.1.0/MoonsenseSDK-static.xcframework-1.1.0.zip",
            checksum: "799063b699b4574225edd7773331fab42d57f4b7fbce1684035d23a6c00a380f"
        )
    ]
)
