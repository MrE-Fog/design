// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "DesignSite",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "DesignSite",
            targets: ["DesignSite"]
        ),
        .library(name: "VaporDesign", targets: ["VaporDesign"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.8.0")
    ],
    targets: [
        .executableTarget(
            name: "DesignSite",
            dependencies: [
                .product(name: "Publish", package: "publish"),
                "VaporDesign"
            ]
        ),
        .target(
            name: "VaporDesign",
            dependencies: [
                .product(name: "Publish", package: "publish")
            ]
        )
    ]
)
