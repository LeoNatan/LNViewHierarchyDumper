//
//  SceneDelegate.swift
//  ViewHierarchyDumpTester
//
//  Created by Leo Natan (Wix) on 7/3/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	var topNavigationItem: UINavigationItem {
		return (window!.rootViewController! as! UINavigationController).topViewController!.navigationItem
	}

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
#if targetEnvironment(macCatalyst)
		let toolbar = NSToolbar(identifier: "mainToolbar")
//		toolbar.centeredItemIdentifier = NSToolbarItem.Identifier(rawValue: "mainTabsToolbarItem")
		toolbar.insertItem(withItemIdentifier: NSToolbarItem.Identifier(rawValue: "newWindow"), at: 0)
		toolbar.insertItem(withItemIdentifier: NSToolbarItem.Identifier(rawValue: "dumpHierarchy"), at: 1)
		toolbar.displayMode = .iconOnly
		toolbar.delegate = self
		
		windowScene.titlebar?.titleVisibility = .visible
		windowScene.titlebar?.toolbar = toolbar
		
		windowScene.title = topNavigationItem.title
#endif
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}
}

#if targetEnvironment(macCatalyst)
extension SceneDelegate: NSToolbarDelegate {
	func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
		
		if itemIdentifier.rawValue == "newWindow" {
			let item = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: topNavigationItem.rightBarButtonItem!)
			item.label = "New Window"
			item.toolTip = "New Window"
			return item
		}
		
		if itemIdentifier.rawValue == "dumpHierarchy" {
			let item = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: topNavigationItem.leftBarButtonItem!)
			item.label = "Dump View Hierarchy"
			item.toolTip = "Dump View Hierarchy"
			return item
		}
		
		return nil
	}
	
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return [NSToolbarItem.Identifier(rawValue: "newWindow"), NSToolbarItem.Identifier(rawValue: "dumpHierarchy")]
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarDefaultItemIdentifiers(toolbar)
	}
}
#endif
