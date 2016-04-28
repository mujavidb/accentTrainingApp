//
//  Persister.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 28/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation

class Persister {
	
	static func saveQuizOptions(options: QuizChoice) {
		let keyName = "\(options.getQuizType())_recent"
		let userDefaults = NSUserDefaults.standardUserDefaults()
		let quizOptions = [
			options.getQuizType(),
			options.getQuizLength(),
			options.getQuizAccent(),
			options.getQuizSpeaker()
		]
		userDefaults.setValue(quizOptions, forKey: keyName)
		userDefaults.synchronize()
	}
	
	static func lastQuizSelection(quizType: String) -> QuizChoice {
		let keyName = "\(quizType)_recent"
		let userDefaults = NSUserDefaults.standardUserDefaults()
		
		let previousOptions = QuizChoice()
		
		if (userDefaults.objectForKey(keyName) != nil) {
			var quizOptions = userDefaults.objectForKey(keyName) as! [String]
			previousOptions.setType(quizOptions[0])
			previousOptions.setLength(quizOptions[1])
			previousOptions.setAccent(quizOptions[2])
			previousOptions.setSpeaker(quizOptions[3])
		} else {
			previousOptions.setType(quizType)
			previousOptions.setAccent("London")
			previousOptions.setLength("Short (15)")
			previousOptions.setSpeaker("Anna")
			if quizType == "practice" {
				previousOptions.setType(quizType)
			} else {
				previousOptions.setType("timetrial")
			}
		}
		return previousOptions
	}
}