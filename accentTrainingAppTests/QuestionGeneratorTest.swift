//
//  QuestionGeneratorTest.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 11/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import XCTest
@testable import accentTrainingApp

class QuestionGeneratorTest: XCTestCase {
	
	var quizChoiceInstance: QuizChoice? = nil
	var generator: QuestionGenerator? = nil
    
    override func setUp() {
        super.setUp()
		quizChoiceInstance = QuizChoice()
		quizChoiceInstance?.setAccent("London")
		quizChoiceInstance?.setSpeaker("Lily")
		quizChoiceInstance?.setType("practice")
		quizChoiceInstance?.setLength("Long")
		generator = QuestionGenerator(completQuizChoice: quizChoiceInstance!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
