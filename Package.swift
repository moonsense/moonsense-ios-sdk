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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/1.2.0/MoonsenseSDK.xcframework-1.2.0.zip",
            checksum: "0f6840d57d7c2e23dc13853b526f61c9b545cb4741d33dfb7443161507a3953a"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.2.0/MoonsenseSDK-static.xcframework-1.2.0.zip",
            checksum: "4a937c62b1c271f36ee5e5e560438c853b1f3d1ca741bf540cfc2a703f745794"
        )
    ]
)

if ProcessInfo.processInfo.environment["MOONSENSE_INCLUDE_CORE_PACKAGES"] != nil {
    package.products.append(Product.library(name: "MoonsenseCoreSDK", targets: ["MoonsenseCoreSDK"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.xcframework/versions/1.2.0/MoonsenseCoreSDK.xcframework-1.2.0.zip",
                                               checksum: "62717a2b569943a142f5e2fb7360616dae4594ab19df730a00de6dd8935af53e"))

    package.products.append(Product.library(name: "MoonsenseCoreSDK-static", targets: ["MoonsenseCoreSDK-static"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK-static",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK-static.xcframework/versions/1.2.0/MoonsenseCoreSDK-static.xcframework-1.2.0.zip",
                                               checksum: "7671be70fbd6a99f501dbd4584af448feab4945d988d322eb8f3e4b7286e64bf"))
}
