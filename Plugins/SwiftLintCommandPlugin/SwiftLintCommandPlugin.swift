import Foundation
import PackagePlugin

@main
struct SwiftLintCommandPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) throws {
        Diagnostics.remark("Command plugin arguments: \(arguments)")

        guard !arguments.contains("--cache-path") else {
            Diagnostics.error("Caching is managed by the plugin and so setting `--cache-path` is not allowed")
            return
        }
        var argExtractor = ArgumentExtractor(arguments)
        let targetNames = argExtractor.extractOption(named: "target")
        let remainingArguments = argExtractor.remainingArguments

        Diagnostics.remark("Remaining arguments: \(remainingArguments)")

        let targets: [Target]? = try {
            if !targetNames.isEmpty {
                return try context.package.targets(named: targetNames)
            }
            if let pathArgument = remainingArguments.last, FileManager.default.fileExists(atPath: pathArgument) {
                Diagnostics.remark("No targets provided, paths from remaining arguments will be used")
                return nil
            }
            return context.package.targets
        }()

        var arguments = remainingArguments
        if !arguments.contains("analyze") {
            // The analyze command does not support the `--cache-path` argument.
            arguments.insert(contentsOf: ["--cache-path", "\(context.pluginWorkDirectory.string)"], at: 0)
        }

        if let targets {
            Diagnostics.remark("Will act on targets: \(targets)")
            for target in targets {
                guard let target = target.sourceModule else {
                    Diagnostics.warning("Target '\(target.name)' is not a source module; skipping it")
                    continue
                }
                let arguments = arguments + [target.directory.string]
                try runProcess(title: "module '\(target.name)'", context: context, arguments: arguments)
            }
        } else {
            try runProcess(title: "listed files", context: context, arguments: arguments)
        }
    }

    private func runProcess(title: String, context: PluginContext, arguments: [String]) throws {
        let tool = try context.tool(named: "swiftlint")
        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: context.package.directory.string)
        process.executableURL = URL(fileURLWithPath: tool.path.string)
        process.arguments = arguments

        Diagnostics.remark("Run arguments: \(process.arguments!)")

        try process.run()
        process.waitUntilExit()
        switch process.terminationReason {
        case .exit:
            Diagnostics.remark("Finished running for \(title)")
        case .uncaughtSignal:
            Diagnostics.error("Got uncaught signal while running for \(title)")
        @unknown default:
            Diagnostics.error("Stopped running for \(title) due to unexpected termination reason")
        }
        if process.terminationStatus != EXIT_SUCCESS {
            Diagnostics.warning(
                "Command found violations or unsuccessfully stopped running for \(title)"
            )
            throw Error.unsuccessfulLinting
        }
    }
}

private enum Error: LocalizedError {
    case unsuccessfulLinting
}
