//
//  NonMacDumpLogic.swift
//  ViewHierarchyDumpTester
//
//  Created by Leo Natan on 11/08/2023.
//

import Foundation
import UniformTypeIdentifiers
import LNViewHierarchyDumper

extension String: LocalizedError {
	public var errorDescription: String? { return self }
}

func dumpViewHierarchy() throws -> URL {
#if !targetEnvironment(simulator) && os(watchOS)
	throw "This demo project is unable to dump view hierarchies on watchOS devices other than simulators"
#else
	let fileName = "\(ProcessInfo.processInfo.processName)[\(ProcessInfo.processInfo.processIdentifier)].viewhierarchy"
#if targetEnvironment(macCatalyst) || !targetEnvironment(simulator)
	let url = URL(fileURLWithPath: "\(NSTemporaryDirectory())/\(fileName)")
#else
	let somePath = NSHomeDirectory()
	let userPath = somePath[somePath.startIndex..<somePath.range(of: "/Library")!.lowerBound]
	let url = URL(fileURLWithPath: String(userPath)).appendingPathComponent("Desktop").appendingPathComponent(fileName)
#endif
	try LNViewHierarchyDumper.shared.dumpViewHierarchy(to: url)
	return url
#endif
}
