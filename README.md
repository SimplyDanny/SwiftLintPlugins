# SwiftLint Plugins

This repository provides the Swift Package Manager plugins (and only the plugins) that are developed as a part of
[SwiftLint](https://github.com/realm/swiftlint).

> [!NOTE]
> This is only an excerpt of the official [SwiftLint](https://github.com/realm/swiftlint) project. The plugins will be
> developed there next to SwiftLint as a command-line tool itself. The plugin source code is kept in sync with SwiftLint
> and so are the releases. Please report issues and propose changes to the plugins in the main source repository.

Offering the plugins in a separate package has multiple advantages:

* No need to clone the whole SwiftLint repository.
* SwiftLint itself is included as a binary dependency, thus the consumer doesn't need to build it first.
* There are no other dependencies that need to be downloaded, resolved and compiled.
* There is especially no induced dependency on [SwiftSyntax](https://github.com/apple/swift-syntax) which would require
  a lot of build time alone.
* For projects having adopted Swift macros or depend on SwiftSyntax for other reasons, there is no version conflict
  caused by the fact that SwiftLint has to rely on a fixed and pretty current version.
