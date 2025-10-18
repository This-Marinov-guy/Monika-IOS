// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MonikaSwift",
    platforms: [
        .macOS(.v14),
        .iOS(.v16)
    ],
    products: [
        // Library product for iOS app to import
        .library(
            name: "MonikaSwiftCore",
            targets: ["MonikaSwiftCore"]),
        // Executable for macOS
        .executable(
            name: "MonikaSwift",
            targets: ["MonikaSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/supabase/supabase-swift.git", from: "2.0.0")
    ],
    targets: [
        // Core library with all the app code (shared between macOS and iOS)
        .target(
            name: "MonikaSwiftCore",
            dependencies: [
                .product(name: "Supabase", package: "supabase-swift")
            ],
            path: "Sources",
            exclude: ["MonikaSwiftApp.swift"]
        ),
        // macOS executable target
        .executableTarget(
            name: "MonikaSwift",
            dependencies: ["MonikaSwiftCore"],
            path: "Sources",
            sources: ["MonikaSwiftApp.swift"]
        ),
    ]
)
