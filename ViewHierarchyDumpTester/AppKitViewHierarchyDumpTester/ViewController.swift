//
//  ViewController.swift
//  AppKitViewHierarchyDumpTester
//
//  Created by Leo Natan on 02/08/2023.
//

import Cocoa
import WebKit
import LNViewHierarchyDumper

class ViewController: NSViewController {
	@IBOutlet var webView: WKWebView!

	override func viewDidLoad() {
		super.viewDidLoad()

		webView.load(URLRequest(url: URL(string:"https://nytimes.com")!))
	}

	@IBAction func dumpHierarchy(_ sender: Any) {
		let savePanel = NSSavePanel()
		savePanel.nameFieldStringValue = "\(ProcessInfo.processInfo.processName)[\(ProcessInfo.processInfo.processIdentifier)].viewhierarchy"
		savePanel.beginSheetModal(for: view.window!) { response in
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
				guard response == .OK, let url = savePanel.url else {
					return
				}
				
				do {
					try LNViewHierarchyDumper.shared.dumpViewHierarchy(to: url)
				} catch let e {
					let alert = NSAlert(error: e)
					alert.runModal()
				}
			}
		}
		
//#if targetEnvironment(macCatalyst) || !targetEnvironment(simulator)
//		pendingTempUrl = URL(fileURLWithPath: "\(NSTemporaryDirectory())/\(ProcessInfo.processInfo.processName)[\(ProcessInfo.processInfo.processIdentifier)].viewhierarchy")
//		do {
//			try LNViewHierarchyDumper.shared.dumpViewHierarchy(to: pendingTempUrl!)
//			let picker = UIDocumentPickerViewController(forExporting: [pendingTempUrl!], asCopy: true)
//			picker.view.layoutIfNeeded()
//			picker.delegate = self
//#if targetEnvironment(macCatalyst)
//			self.present(picker, animated: true, completion: nil)
//#else
//			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//				self.present(picker, animated: true, completion: nil)
//			}
//			RunLoop.current.run(until: .init(timeIntervalSinceNow: 0.3))
//#endif
//		} catch let e {
//			let alert = UIAlertController(title: "View Hierarchy Dump Failed", message: e.localizedDescription, preferredStyle: .alert)
//			if #available(iOS 16.0, *) {
//				alert.severity = .critical
//			}
//			alert.addAction(.init(title: "OK", style: .default, handler: nil))
//			present(alert, animated: true, completion: nil)
//		}
//#else
//		let somePath = NSHomeDirectory()
//		let userPath = somePath[somePath.startIndex..<somePath.range(of: "/Library")!.lowerBound]
//		let url = URL(fileURLWithPath: String(userPath)).appendingPathComponent("Desktop").appendingPathComponent("\(ProcessInfo.processInfo.processName)[\(ProcessInfo.processInfo.processIdentifier)].viewhierarchy")
//		do {
//			try LNViewHierarchyDumper.shared.dumpViewHierarchy(to: url)
//			let alert = UIAlertController(title: "View Hierarchy Dumped", message: url.path, preferredStyle: .alert)
//			alert.addAction(.init(title: "OK", style: .default, handler: nil))
//			present(alert, animated: true, completion: nil)
//		} catch let e {
//			let alert = UIAlertController(title: "View Hierarchy Dump Failed", message: e.localizedDescription, preferredStyle: .alert)
//			if #available(iOS 16.0, *) {
//				alert.severity = .critical
//			}
//			alert.addAction(.init(title: "OK", style: .default, handler: nil))
//			present(alert, animated: true, completion: nil)
//		}
//#endif
	}
}

