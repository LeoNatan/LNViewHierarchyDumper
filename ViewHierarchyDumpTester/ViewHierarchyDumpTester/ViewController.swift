//
//  ViewController.swift
//  ViewHierarchyDumpTester
//
//  Created by Leo Natan (Wix) on 7/3/20.
//

import UIKit
import UniformTypeIdentifiers
import LNViewHierarchyDumper

func randomString(length: Int) -> String {
	let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	return String((0..<length).map{ _ in letters.randomElement()! })
}

extension UIColor {
	fileprivate class func lightColor(withSeed seed: String) -> UIColor {
		srand48(seed.hash)
		
		let hue = CGFloat(drand48())
		let saturation = CGFloat(0.5)
		let brightness = CGFloat(1.0 - 0.25 * drand48())
		
		return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
	}
	
	fileprivate class func darkColor(withSeed seed: String) -> UIColor {
		srand48(seed.hash)
		
		let hue = CGFloat(drand48())
		let saturation = CGFloat(0.5)
		let brightness = CGFloat(0.3 + 0.25 * drand48())
		
		return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
	}
	
	class func adaptiveColor(withSeed seed: String) -> UIColor {
		let light = lightColor(withSeed: seed)
		let dark = darkColor(withSeed: seed)
		
		return UIColor { traitCollection -> UIColor in
			if traitCollection.userInterfaceStyle == .dark {
				return dark
			}
			
			return light
		}
	}
}

class SelfColoringView: UIView {
	override func didMoveToWindow() {
		super.didMoveToWindow()
		
		backgroundColor = UIColor.adaptiveColor(withSeed: randomString(length: 10))
	}
}

class ViewController: UIViewController, UIDocumentPickerDelegate {
	private var pendingTempUrl: URL? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
#if targetEnvironment(macCatalyst)
		self.navigationController?.isNavigationBarHidden = true
#endif
		
		if self.traitCollection.userInterfaceIdiom == .phone {
			navigationItem.rightBarButtonItem = nil
		}
	}
	
	@IBAction func newWindow(_ sender: UIButton) {
		UIApplication.shared.requestSceneSessionActivation(nil, userActivity: nil, options: nil, errorHandler: nil)
	}
	
	@IBAction func dumpHierarchy(_ sender: Any) {
#if targetEnvironment(macCatalyst) || !targetEnvironment(simulator)
		pendingTempUrl = URL(fileURLWithPath: "\(NSTemporaryDirectory())/\(ProcessInfo.processInfo.processName)[\(ProcessInfo.processInfo.processIdentifier)].viewhierarchy")
		do {
			try LNViewHierarchyDumper.shared.dumpViewHierarchy(to: pendingTempUrl!)
			let picker = UIDocumentPickerViewController(forExporting: [pendingTempUrl!], asCopy: true)
			picker.view.layoutIfNeeded()
			picker.delegate = self
#if targetEnvironment(macCatalyst)
			self.present(picker, animated: true, completion: nil)
#else
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
				self.present(picker, animated: true, completion: nil)
			}
			RunLoop.current.run(until: .init(timeIntervalSinceNow: 0.3))
#endif
		} catch let e {
			let alert = UIAlertController(title: "View Hierarchy Dump Failed", message: e.localizedDescription, preferredStyle: .alert)
			if #available(iOS 16.0, *) {
				alert.severity = .critical
			}
			alert.addAction(.init(title: "OK", style: .default, handler: nil))
			present(alert, animated: true, completion: nil)
		}
#else
		let somePath = NSHomeDirectory()
		let userPath = somePath[somePath.startIndex..<somePath.range(of: "/Library")!.lowerBound]
		let url = URL(fileURLWithPath: String(userPath)).appendingPathComponent("Desktop").appendingPathComponent("\(ProcessInfo.processInfo.processName)[\(ProcessInfo.processInfo.processIdentifier)].viewhierarchy")
		do {
			try LNViewHierarchyDumper.shared.dumpViewHierarchy(to: url)
			let alert = UIAlertController(title: "View Hierarchy Dumped", message: url.path, preferredStyle: .alert)
			alert.addAction(.init(title: "OK", style: .default, handler: nil))
			present(alert, animated: true, completion: nil)
		} catch let e {
			let alert = UIAlertController(title: "View Hierarchy Dump Failed", message: e.localizedDescription, preferredStyle: .alert)
			if #available(iOS 16.0, *) {
				alert.severity = .critical
			}
			alert.addAction(.init(title: "OK", style: .default, handler: nil))
			present(alert, animated: true, completion: nil)
		}
#endif
	}
	
	func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
		if let pendingTempUrl = pendingTempUrl {
			try? FileManager.default.removeItem(at: pendingTempUrl)
		}
	}
}

