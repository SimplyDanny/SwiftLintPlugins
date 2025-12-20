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
            dependencies: [.target(name: "SwiftLintBinary")],
            packageAccess: false
        ),
        .plugin(
            name: "SwiftLintCommandPlugin",
            capability: .command(
                intent: .custom(verb: "swiftlint", description: "SwiftLint Command Plugin"),
                permissions: [
                    .writeToPackageDirectory(
                        reason: "When this command is run with the `--fix` option it may modify source files."
                    ),
                ]
            ),
            dependencies: [.target(name: "SwiftLintBinary")],
            packageAccess: false
        ),
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.63.0-rc.2/SwiftLintBinary.artifactbundle.zip",
            checksum: "396d5b609bf6ffc3e4d68b5279999c111dc3344a3a7e7b9b099243eaf46f1307"
        )
    ]
)
