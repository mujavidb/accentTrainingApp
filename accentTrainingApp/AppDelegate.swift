//
//  AppDelegate.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 09/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	enum ShortcutIdentifier: String {
		case Practice
		case Timetrial
		case Highscores
		
		// MARK: Initializers
		init?(fullType: String) {
			guard let last = fullType.componentsSeparatedByString(".").last else { return nil }
			
			self.init(rawValue: last)
		}
		
		// MARK: Properties
		
		var type: String {
			return NSBundle.mainBundle().bundleIdentifier! + ".\(self.rawValue)"
		}
	}
	
	var window: UIWindow?
	
	/// Saved shortcut item used as a result of an app launch, used later when app is activated.
	
	var launchedShortcutItem: UIApplicationShortcutItem?
	
	@available(iOS 9.0, *)
	func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
		print("Handling shortcut")
		
		let handledShortCutItem = handleShortCutItem(shortcutItem)
		
		completionHandler(handledShortCutItem)
		
	}
	
	@available(iOS 9.0, *)
	func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
		var handled = false
		
		guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
		
		guard let shortCutType = shortcutItem.type as String? else { return false }
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		var vc = UIViewController()
		
		switch (shortCutType) {
		case ShortcutIdentifier.Practice.type:
			if let resultController = storyboard.instantiateViewControllerWithIdentifier("PracticeQuizModeController") as? PracticeQuizModeController {
				resultController.questionChoice = Persister.lastQuizSelection("practice")
				vc = resultController
			}
			handled = true
			break
		case ShortcutIdentifier.Timetrial.type:
			if let resultController = storyboard.instantiateViewControllerWithIdentifier("TimetrialQuizModeController") as? TimetrialQuizModeController {
				resultController.questionChoice = Persister.lastQuizSelection("timetrial")
				vc = resultController
			}
			handled = true
			break
		case ShortcutIdentifier.Highscores.type:
			vc = storyboard.instantiateViewControllerWithIdentifier("HighscoresController") as! HighscoresController
			handled = true
			break
		default:
			break
		}
		
		// Display the selected view controller
		window!.rootViewController?.presentViewController(vc, animated: true, completion: nil)
		
		return handled
	}
	
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
		
		// If a shortcut was launched, display its information and take the appropriate action

		if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
			launchedShortcutItem = shortcutItem
		}
		return true
	}
	
	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(application: UIApplication) {
		guard let shortcut = launchedShortcutItem else { return }
		
		handleShortCutItem(shortcut)
		
		launchedShortcutItem = nil
	}
	
	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	
}

