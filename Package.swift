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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/1.1.1/MoonsenseSDK.xcframework-1.1.1.zip",
            checksum: "0968de5a85eec0f893c465b5c3d95b27cc19a4891a40d376aa888837155afb23"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.1.1/MoonsenseSDK-static.xcframework-1.1.1.zip",
            checksum: "ffb8141fe5bc0fa28f99b06114134ce0462dbbe2186a0bce843a59e37275c873"
        )
    ]
)
