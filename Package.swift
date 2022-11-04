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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/1.3.0/MoonsenseSDK.xcframework-1.3.0.zip",
            checksum: "994bb56692ffa965b19202522b1364bb9d1ad3badf6f31202ed5a8d144d53823"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.3.0/MoonsenseSDK-static.xcframework-1.3.0.zip",
            checksum: "4566fb13bc5cbdbd0722c733897bc8bfd3d44c693570b95b33d300a6c5dcaaf7"
        )
    ]
)

if ProcessInfo.processInfo.environment["MOONSENSE_INCLUDE_CORE_PACKAGES"] != nil {
    package.products.append(Product.library(name: "MoonsenseCoreSDK", targets: ["MoonsenseCoreSDK"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.xcframework/versions/1.3.0/MoonsenseCoreSDK.xcframework-1.3.0.zip",
                                               checksum: "79c754e23d88e0da3e8700c7bc94f017a70f386182118c4e237f8681584c2de4"))

    package.products.append(Product.library(name: "MoonsenseCoreSDK-static", targets: ["MoonsenseCoreSDK-static"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK-static",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK-static.xcframework/versions/1.3.0/MoonsenseCoreSDK-static.xcframework-1.3.0.zip",
                                               checksum: "d7cf3bae2aeda3cc3653add30914b8aad88831687e02a493c76d1a62e544bb47"))
}
