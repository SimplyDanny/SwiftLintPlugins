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
            url: "https://github.com/realm/SwiftLint/releases/download/0.62.0/SwiftLintBinary.artifactbundle.zip",
            checksum: "5e1956c22fcc9997cde69c62daeecc78baef88d4c03c07349815df881fc1ce28"
        )
    ]
)
