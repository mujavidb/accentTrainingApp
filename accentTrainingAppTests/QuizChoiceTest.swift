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
	
	var testVar = ""
	
	func testType() {
		testVar = "Practice"
		quiz.setType(testVar)
		XCTAssertTrue(quiz.getQuizType() == testVar)
	}
	
	func testSpeaker() {
		testVar = "Lily"
		quiz.setSpeaker(testVar)
		XCTAssertTrue(quiz.getQuizSpeaker() == testVar)
	}
	
	func testAccent() {
		testVar = "London"
		quiz.setAccent(testVar)
		XCTAssertTrue(quiz.getQuizAccent() == testVar)
	}
	
	func testLength() {
		testVar = "Long"
		quiz.setLength(testVar)
		XCTAssertTrue(quiz.getQuizLength() == testVar)
	}
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
		testVar = ""
    }
    
}
