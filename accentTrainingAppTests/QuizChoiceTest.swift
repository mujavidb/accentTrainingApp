//
//  QuizChoiceTest.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 06/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import XCTest
@testable import accentTrainingApp

class QuizChoiceTest: XCTestCase {
	
	let quiz = QuizChoice()
	
	var testVar: String?
	
	func testType() {
		testVar = "practice"
		quiz.setType(testVar!)
		XCTAssertEqual(quiz.getQuizType(), testVar)
	}
	
	func testSpeaker() {
		testVar = "Lily"
		quiz.setSpeaker(testVar!)
		XCTAssertEqual(quiz.getQuizSpeaker(), testVar)
	}
	
	func testAccent() {
		testVar = "London"
		quiz.setAccent(testVar!)
		XCTAssertEqual(quiz.getQuizAccent(), testVar)
	}
	
	func testLength() {
		testVar = "Long"
		quiz.setLength(testVar!)
		XCTAssertEqual(quiz.getQuizLength(), testVar)
	}
	
	override func setUp() {
		super.setUp()
		testVar = ""
	}
}
