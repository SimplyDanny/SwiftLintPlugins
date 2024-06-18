// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "SwiftLintPluginsTest",
    platforms: [
        .macOS(.v12),
    ],
    dependencies: [
        .package(path: "../SwiftLintPlugins"),
    ],
    targets: [
        .executableTarget(
            name: "Main",
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins"),
            ]
        ),
    ]
)
