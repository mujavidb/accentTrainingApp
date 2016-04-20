//
//  Extensions.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 20/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
	
	static func mainFontOfSize(fontSize: CGFloat) -> UIFont {
		var mainFont = UIFont(name: "MuseoSans-500", size: fontSize)
		if mainFont == nil {
			mainFont = UIFont.systemFontOfSize(fontSize)
		}
		return mainFont!
	}
	
	static func boldMainFontOfSize(fontSize: CGFloat) -> UIFont {
		var mainFont = UIFont(name: "MuseoSans-700", size: fontSize)
		if mainFont == nil {
			mainFont = UIFont.boldSystemFontOfSize(fontSize)
		}
		return mainFont!
	}
}