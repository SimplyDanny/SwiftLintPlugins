// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SwiftLintPlugins",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .plugin(name: "SwiftLintBuildToolPlugin", targets: ["SwiftLintBuildToolPlugin"]),
        .plugin(name: "SwiftLintCommandPlugin", targets: ["SwiftLintCommandPlugin"])
    ],
    targets: [
        .plugin(
            name: "SwiftLintBuildToolPlugin",
            capability: .buildTool(),
            dependencies: [.target(name: "SwiftLintBinary")]
        ),
        .plugin(
            name: "SwiftLintCommandPlugin",
            capability: .command(intent: .custom(verb: "swiftlint", description: "SwiftLint Command Plugin")),
            dependencies: [.target(name: "SwiftLintBinary")]
        ),
        .binaryTarget(
            name: "SwiftLintBinary",
                url: "https://github.com/realm/SwiftLint/releases/download/0.56.0/SwiftLintBinary-macos.artifactbundle.zip",
                checksum: "dcf90197f60b9fe4533544a9a3ec0538c9308cadbce2d5b20f5966376c53579a"
        )
    ]
)
