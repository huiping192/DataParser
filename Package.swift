// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataParser",
    products: [
        .library(
            name: "DataParser",
            targets: ["DataParser"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CDataParser",
            path: "Sources/CDataParser",
            publicHeadersPath: ".",
            cSettings: [
              .headerSearchPath(".")
            ]
        ),
        .target(
          name: "ObjCDataParser",
          dependencies: ["CDataParser"],
          path: "Sources/ObjCDataParser",
          publicHeadersPath: ".",
          cSettings: [
            .headerSearchPath(".")
          ]
        ),
        .target(
            name: "DataParser",
            dependencies: ["ObjCDataParser"]),
        .testTarget(
            name: "DataParserTests",
            dependencies: ["DataParser"]),
    ]
)


