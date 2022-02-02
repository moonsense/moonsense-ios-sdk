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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/0.2.0/MoonsenseSDK.xcframework-0.2.0.zip",
            checksum: "7ccdab724c37ffdd1bd5394fd1eafbf8e93a330561dda43b647d7d007c1c6fdd"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/0.2.0/MoonsenseSDK-static.xcframework-0.2.0.zip",
            checksum: "c2b57938330f7e31e453b5b6c3fc29b94b1be316c6961d8e55e6bab95c2fedf6"
        )
    ]
)
