//
//  QuestionSetTest.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 07/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import XCTest
@testable import accentTrainingApp

class QuestionSetTest: XCTestCase {
	
	let qs = QuestionSet()
	
	func testGetSet(){
		let index = 5
		XCTAssertEqual(qs.getQuestionSet(index), qs.questionSet[index])
	}
	
	func testGetAnswer(){
		let qIndex = 5
		let aIndex = 2
		XCTAssertEqual(qs.getAnswer(5,answerIndex: 2), qs.questionSet[qIndex][aIndex])
	}
    
}
