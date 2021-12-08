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
            url: "https://dl.cloudsmith.io/basic/moonsense/sdk/raw/names/MoonsenseSDK.xcframework/versions/0.1.0/MoonsenseSDK.xcframework.zip",
            checksum: "27386a63030c66ad286c7b22216c459682b67a74f5b8f4662424daa927d807b3"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.cloudsmith.io/basic/moonsense/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/0.1.0/MoonsenseSDK-static.xcframework.zip",
            checksum: "dc52aba710784bcb53eb2134e9b6ff2ee7ba494be2b5ee3ca6dc046606fd820d"
        )
    ]
)
