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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/1.5.0/MoonsenseSDK.xcframework-1.5.0.zip",
            checksum: "108fe821c1ef3820b8432f0a2da740aa261824f9ff9237cc0d23089f44d20b2a"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.5.0/MoonsenseSDK-static.xcframework-1.5.0.zip",
            checksum: "bb5f55e02174c853a36c302dfc5b1ffeacc719eeb57fbd8d4ddd9e89a2adacd5"
        )
    ]
)

if ProcessInfo.processInfo.environment["MOONSENSE_INCLUDE_CORE_PACKAGES"] != nil {
    package.products.append(Product.library(name: "MoonsenseCoreSDK", targets: ["MoonsenseCoreSDK"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.xcframework/versions/1.5.0/MoonsenseCoreSDK.xcframework-1.5.0.zip",
                                               checksum: "37a753b9a8488ab08d1bcfb80a6d06555a357be539012a631dd7fc27ad832f09"))

    package.products.append(Product.library(name: "MoonsenseCoreSDK-static", targets: ["MoonsenseCoreSDK-static"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK-static",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK-static.xcframework/versions/1.5.0/MoonsenseCoreSDK-static.xcframework-1.5.0.zip",
                                               checksum: "d9a437164c65d31a3af6ebc0147e161a9de7bee4c84b4bb93ac966011188f544"))
}
