// swift-tools-version:5.3

import PackageDescription
import class Foundation.ProcessInfo

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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/1.2.1/MoonsenseSDK.xcframework-1.2.1.zip",
            checksum: "2d76f92420694aea7b487fcc4d008e15a4f68471e611672fde7bbaf3a7705d3e"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.2.1/MoonsenseSDK-static.xcframework-1.2.1.zip",
            checksum: "f7f3373ee3c14202695425c6a6614e6548498761b4d14e14d9906c1089a6bb45"
        )
    ]
)

if ProcessInfo.processInfo.environment["MOONSENSE_INCLUDE_CORE_PACKAGES"] != nil {
    package.products.append(Product.library(name: "MoonsenseCoreSDK", targets: ["MoonsenseCoreSDK"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.xcframework/versions/1.2.1/MoonsenseCoreSDK.xcframework-1.2.1.zip",
                                               checksum: "ac4437a2359b0af3a735ad64b760f7346d3136256d818805c8ff50a2023fce70"))

    package.products.append(Product.library(name: "MoonsenseCoreSDK-static", targets: ["MoonsenseCoreSDK-static"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK-static",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK-static.xcframework/versions/1.2.1/MoonsenseCoreSDK-static.xcframework-1.2.1.zip",
                                               checksum: "a25f60e1a23e87c647f67e0be18107604e6194cc4bcc44612923b33160ecd870"))
}
