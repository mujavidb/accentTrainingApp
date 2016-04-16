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
        let rhymeIndex = 2
		XCTAssertEqual(qs.getQuestionSet(index, rhymeSet: rhymeIndex), qs.r3[index])
	}
	
	func testGetAnswer(){
		let qIndex = 5
		let aIndex = 2
        let rIndex = 2
		XCTAssertEqual(qs.getAnswer(qIndex,answerIndex: aIndex,rhymeSet: rIndex), qs.r3[qIndex][aIndex])
	}
    
}
