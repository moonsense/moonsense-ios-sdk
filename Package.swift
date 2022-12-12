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
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK.xcframework/versions/1.4.0/MoonsenseSDK.xcframework-1.4.0.zip",
            checksum: "f840f4b52a920403088e5007e162b57f0647edf0a468771018300ad321c0017e"
        ),
        .binaryTarget(
            name: "MoonsenseSDK-static",
            url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseSDK-static.xcframework/versions/1.4.0/MoonsenseSDK-static.xcframework-1.4.0.zip",
            checksum: "6dea042fe33b484b53a1320fc9138275f017044d0752443f104b311d3f30f471"
        )
    ]
)

if ProcessInfo.processInfo.environment["MOONSENSE_INCLUDE_CORE_PACKAGES"] != nil {
    package.products.append(Product.library(name: "MoonsenseCoreSDK", targets: ["MoonsenseCoreSDK"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK.xcframework/versions/1.4.0/MoonsenseCoreSDK.xcframework-1.4.0.zip",
                                               checksum: "b597bcd413314d8d4788e53db710e282a3c50ea345353c22e2ef83225ed301e2"))

    package.products.append(Product.library(name: "MoonsenseCoreSDK-static", targets: ["MoonsenseCoreSDK-static"]))
    package.targets.append(Target.binaryTarget(name: "MoonsenseCoreSDK-static",
                                               url: "https://dl.moonsense.io/basic/sdk/raw/names/MoonsenseCoreSDK-static.xcframework/versions/1.4.0/MoonsenseCoreSDK-static.xcframework-1.4.0.zip",
                                               checksum: "7bdca40a13206777c0a677c4f6a93342e8597fe9ef802b09b141c04c8c9fc7d0"))
}
