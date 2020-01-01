// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirestoreClient",
    platforms: [.iOS(.v10), .watchOS(.v4)],
    products: [.library(name: "FirestoreClient", targets: ["FirestoreClient"])],
    dependencies: [],
    targets: [
        .target(name: "FirestoreClient", dependencies: []),
        .testTarget(name: "FirestoreClientTests", dependencies: ["FirestoreClient"], path: "Tests")
    ],
    swiftLanguageVersions: [.v5]
)
