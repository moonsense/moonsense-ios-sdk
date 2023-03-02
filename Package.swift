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
            checksum: "510afdead54fc1d51be74f6cb352f98ccbd2efb8ed929af78800506faaecf2ec"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.6.0/MoonsenseSDK-static.xcframework-1.6.0.zip",
            checksum: "ff6cfaaba553a08fc6b29058970aa9007ac1a4737f302f5a6b5badfbd318755c"
        )
    ]
)

if ProcessInfo.processInfo.environment["MOONSENSE_INCLUDE_CORE_PACKAGES"] != nil {
    package.products.append(Product.library(name: "MoonsenseCoreSDK", targets: ["MoonsenseCoreSDK"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.xcframework/versions/1.6.0/MoonsenseCoreSDK.xcframework-1.6.0.zip",
                                               checksum: "7c3898effdf8caa9f506d52c9b0323f4c9de0baa47f3cd9de71edf706f788c4b"))

    package.products.append(Product.library(name: "MoonsenseCoreSDK-static", targets: ["MoonsenseCoreSDK-static"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK-static",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK-static.xcframework/versions/1.6.0/MoonsenseCoreSDK-static.xcframework-1.6.0.zip",
                                               checksum: "c2e84cb123f5e5cd2f053400ad3b4f3b5510c0d4f216207ab29f085d2d771ff5"))
}
