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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/0.3.0/MoonsenseSDK.xcframework-0.3.0.zip",
            checksum: "66866cf865589385de8b519013f16835f86d751ebdb1fe2c030ee03013d706cb"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/0.3.0/MoonsenseSDK-static.xcframework-0.3.0.zip",
            checksum: "9dc3e7370e7ae9faad247f7a7ecc7fad3a40fceda691daf881c2c888c2bbbe1b"
        )
    ]
)
