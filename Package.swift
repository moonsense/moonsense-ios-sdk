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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/1.6.0/MoonsenseSDK.xcframework-1.6.0.zip",
            checksum: "f830a47e0d4715743040a4bfce78aaa973e7f6aa1b07a3421a44c3a9ef5b9498"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.6.0/MoonsenseSDK-static.xcframework-1.6.0.zip",
            checksum: "e37091b69c1b2e5233879f061348cb557d9e00c5dd21aa08b6f08a5121a8bb6f"
        )
    ]
)

if ProcessInfo.processInfo.environment["MOONSENSE_INCLUDE_CORE_PACKAGES"] != nil {
    package.products.append(Product.library(name: "MoonsenseCoreSDK", targets: ["MoonsenseCoreSDK"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.xcframework/versions/1.6.0/MoonsenseCoreSDK.xcframework-1.6.0.zip",
                                               checksum: "4f97c4b8bb00095195ae9daefe0ef4c1abb60fb75a12e62fb6d7ab778bc80300"))

    package.products.append(Product.library(name: "MoonsenseCoreSDK-static", targets: ["MoonsenseCoreSDK-static"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK-static",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK-static.xcframework/versions/1.6.0/MoonsenseCoreSDK-static.xcframework-1.6.0.zip",
                                               checksum: "71c8bbf422283741d7dc7f82331b59ab6097ad96c02b25aed72c49d7400d5f4a"))
}
