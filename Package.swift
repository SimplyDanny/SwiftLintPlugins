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
                url: "https://github.com/realm/SwiftLint/releases/download/0.56.2/SwiftLintBinary-macos.artifactbundle.zip",
                checksum: "197df93d7f5041d8cd46d6902a34ad57914efe1b5b50635995f3b9065f2c3ffd"
        )
    ]
)
