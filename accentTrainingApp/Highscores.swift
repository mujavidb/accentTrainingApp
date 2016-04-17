//
//  HighscoresModel.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 17/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation

class Highscores {
	
	static func updateHighscores(quizType: String, name: String, score: Int) {
		let keyName = "\(quizType)_highscores"
		let userDefaults = NSUserDefaults.standardUserDefaults()
		var previousHighscores: [[String: Int]]
		
		if (userDefaults.objectForKey(keyName) != nil) {
			previousHighscores = (userDefaults.objectForKey(keyName) as? [[String: Int]])!
			var indexOfFirstSmallerThan = previousHighscores.count
			var counter = 0
			for element in previousHighscores {
				for (_, value) in element {
					if score > value {
						indexOfFirstSmallerThan = counter
					}
					counter = counter + 1
				}
			}
			previousHighscores.insert([name: score], atIndex: indexOfFirstSmallerThan)
			while previousHighscores.count > 8 {
				previousHighscores.removeLast()
			}
			
		} else {
			previousHighscores = [[name: score]]
		}
		
		userDefaults.setValue(previousHighscores, forKey: keyName)
		userDefaults.synchronize()

	}
	
	static func returnAllHighScores(quizType: String) -> [[ String: Int]]{
		let keyName = "\(quizType)_highscores"
		let allHighscores = NSUserDefaults.standardUserDefaults().objectForKey(keyName) as? [[String: Int]] ?? nil
		
		if allHighscores == nil {
			let allHighscores = [[String: Int]]()
			return allHighscores
		}
		
		return allHighscores!
	}
}