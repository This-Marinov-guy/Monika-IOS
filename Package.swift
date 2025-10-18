// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MonikaSwift",
    platforms: [
        .macOS(.v14),
        .iOS(.v16)
    ],
    dependencies: [
        .package(url: "https://github.com/supabase/supabase-swift.git", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "MonikaSwift",
            dependencies: [
                .product(name: "Supabase", package: "supabase-swift")
            ]),
    ]
)
