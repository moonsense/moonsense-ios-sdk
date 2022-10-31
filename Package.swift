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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/1.2.2/MoonsenseSDK.xcframework-1.2.2.zip",
            checksum: "05381b0da248e69f03157e02d24e1b17a3dbfbabe629a54f0c9a13c3d49662bc"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.2.2/MoonsenseSDK-static.xcframework-1.2.2.zip",
            checksum: "5093bfe17d8525c83afea5ca034c6483e799b4bbf6aacdbe43d21b7440e9968e"
        )
    ]
)

if ProcessInfo.processInfo.environment["MOONSENSE_INCLUDE_CORE_PACKAGES"] != nil {
    package.products.append(Product.library(name: "MoonsenseCoreSDK", targets: ["MoonsenseCoreSDK"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.xcframework/versions/1.2.2/MoonsenseCoreSDK.xcframework-1.2.2.zip",
                                               checksum: "2d668a908902b18fc0ae70383357bd0ddd1821cc57bb66ee9d4448c0db39fe5c"))

    package.products.append(Product.library(name: "MoonsenseCoreSDK-static", targets: ["MoonsenseCoreSDK-static"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK-static",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK-static.xcframework/versions/1.2.2/MoonsenseCoreSDK-static.xcframework-1.2.2.zip",
                                               checksum: "3e216e2537c09cc5ed928731235bff288ffe03a5b48df52a962519a02b06a178"))
}
