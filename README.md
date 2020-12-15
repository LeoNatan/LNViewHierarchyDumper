# LNViewHierarchyDumper

A framework for programmatically dumping the view hierarchy of your app into an Xcode 12-compatible view hierarchy file archive.

![](Screenshot.png)

The framework supports targeting iOS, tvOS and watchOS simulators, hardware devices (with developer image mounted), and macOS and Catalyst (with Xcode installed). Under unsupported targets or environments, the frameworks fails silently.

**This framework uses Xcode's internal DebugHierarchyFoundation framework, and is not AppStore safe**, thus you should use with care, only linking against it in development/testing scenarios/builds.

Using the framework is very easy:

```swift
import LNViewHierarchyDumper

//...

let url = //URL to a directory
try LNViewHierarchyDumper.shared.dumpViewHierarchy(to: url)
```

