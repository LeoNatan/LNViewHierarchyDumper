// swift-tools-version:5.1

import PackageDescription

let package = Package(
	name: "LNViewHierarchyDumper",
	platforms: [
		.iOS(.v13)
	],
	products: [
		.library(
			name: "LNViewHierarchyDumper",
			type: .dynamic,
			targets: ["LNViewHierarchyDumper"]),
		.library(
			name: "LNViewHierarchyDumper-Static",
			type: .static,
			targets: ["LNViewHierarchyDumper"]),
	],
	dependencies: [],
	targets: [
		.target(
			name: "LNViewHierarchyDumper",
			dependencies: [],
			path: "LNViewHierarchyDumper",
			exclude: [
				"LNViewHierarchyDumper/Info.plist",
				"LNViewHierarchyDumper.xcodeproj"
			],
			publicHeadersPath: "include"
		),
	]
)
