# SwiftLint Plugins

This repository provides the Swift Package Manager plugins (and only the plugins) that are developed as a part of
[SwiftLint](https://github.com/realm/swiftlint). For comprehensive advice on how to integrate them into your projects
refer to the main repository, especially [Installation](https://github.com/realm/SwiftLint#installation) and
[Setup](https://github.com/realm/SwiftLint#setup).

> [!NOTE]
> This is only an excerpt of the official [SwiftLint](https://github.com/realm/swiftlint) project. The plugins will be
> developed there next to SwiftLint as a command-line tool itself. The plugin source code is kept in sync with SwiftLint
> and so are the releases. Please report issues and propose changes to the plugins in the main source repository.

Offering the plugins in a separate package has multiple advantages you should be aware of:

* No need to clone the whole SwiftLint repository.
* SwiftLint itself is included as a binary dependency, thus the consumer doesn't need to build it first.
* There are no other dependencies that need to be downloaded, resolved and compiled.
* There is especially no induced dependency on [SwiftSyntax](https://github.com/apple/swift-syntax) which would require
  a lot of build time alone.
* For projects having adopted Swift macros or depend on SwiftSyntax for other reasons, there is no version conflict
  caused by the fact that SwiftLint has to rely on a fixed and pretty current version.
* As this Swift package doesn't provide any build products, there is no way to add them as dependencies to iOS,
  watchOS, ... targets. They would fail to build if you were to do that.

That said, you are perfectly free to consume the plugins directly from the
[SwiftLint](https://github.com/realm/swiftlint) repository instead if you like to. Both ways are functionally
equivalent, however one comes with the aforementioned drawbacks.
