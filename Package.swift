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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/0.3.1/MoonsenseSDK.xcframework-0.3.1.zip",
            checksum: "3ee9da1aa6b286c83d0893b9efa5b89423c171ce9a86ea3f50451a1799d25127"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/0.3.1/MoonsenseSDK-static.xcframework-0.3.1.zip",
            checksum: "364610ee724f2f74a7e28ecfb8a93c2cd7e0bc61908dd57d23a2a834ad2a3e28"
        )
    ]
)
