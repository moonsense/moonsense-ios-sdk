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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/1.0.0/MoonsenseSDK.xcframework-1.0.0.zip",
            checksum: "32c9095f28ea48d6b91743d11798750aed13c87b17d685dca19b67b9e4fcb734"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.0.0/MoonsenseSDK-static.xcframework-1.0.0.zip",
            checksum: "a6ac835c57d9f05d73278974522e39b67904161d3781d54b973a63dd5f8715cc"
        )
    ]
)
