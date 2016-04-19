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
			previousHighscores.append([name: score])
			previousHighscores = fixOrder(previousHighscores)
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
	
	//bubble sort for sorting array of dictionaries with each dict containing one key-value pair
	class func fixOrder(numberList: [[String: Int]]) -> [[String: Int]] {
		//check for trivial case
		guard numberList.count > 1 else {
			return numberList
		}
		
		//make the array mutable
		var numberList = numberList
		for primaryIndex in 0..<numberList.count {
			let passes = (numberList.count - 1) - primaryIndex
			for secondaryIndex in 0..<passes {
				let testKey = (numberList[secondaryIndex]).filter { $0.0 != "" }[0]
				let comparisonKey = (numberList[secondaryIndex + 1]).filter { $0.0 != "" }[0]
				if(numberList[secondaryIndex][testKey.0] < numberList[secondaryIndex + 1][comparisonKey.0]){
					swap(&numberList[secondaryIndex], &numberList[secondaryIndex + 1])
				}
			}
		}
		return numberList
	}
}