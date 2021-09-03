# LNViewHierarchyDumper

A framework for programmatically dumping the view hierarchy of your app into an Xcode 12 and 13 compatible view hierarchy file archive.

[![GitHub release](https://img.shields.io/github/release/LeoNatan/LNViewHierarchyDumper.svg)](https://github.com/LeoNatan/LNViewHierarchyDumper/releases) [![GitHub stars](https://img.shields.io/github/stars/LeoNatan/LNViewHierarchyDumper.svg)](https://github.com/LeoNatan/LNViewHierarchyDumper/stargazers) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/LeoNatan/LNViewHierarchyDumper/master/LICENSE) <span class="badge-paypal"><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BR68NJEJXGWL6" title="Donate to this project using PayPal"><img src="https://img.shields.io/badge/paypal-donate-yellow.svg?style=flat" alt="PayPal Donation Button" /></a></span>

[![GitHub issues](https://img.shields.io/github/issues-raw/LeoNatan/LNViewHierarchyDumper.svg)](https://github.com/LeoNatan/LNViewHierarchyDumper/issues) [![GitHub contributors](https://img.shields.io/github/contributors/LeoNatan/LNViewHierarchyDumper.svg)](https://github.com/LeoNatan/LNViewHierarchyDumper/graphs/contributors) ![](https://img.shields.io/badge/swift%20package%20manager-compatible-green)

<p align="center"><img src="Screenshot.png"/></p>

The framework supports targeting iOS, tvOS and watchOS simulators, hardware devices (**with developer image mounted**), and macOS and Catalyst (**with Xcode installed**). Under unsupported targets or environments, the frameworks fails silently.

**This framework uses Xcode's internal DebugHierarchyFoundation framework, and is not AppStore safe**, thus you should use with care, only linking against it in development/testing scenarios/builds.

Using the framework is very easy:

```swift
import LNViewHierarchyDumper

//...

let url = //URL to a directory
try LNViewHierarchyDumper.shared.dumpViewHierarchy(to: url)
```

