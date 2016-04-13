//
//  CustomButtonTest.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 07/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import XCTest
@testable import accentTrainingApp

class CustomButtonTest: XCTestCase {
	
	let button = CustomButton()
    
    func testRoundness() {
		XCTAssertEqual(button.layer.cornerRadius, 10)
	}
}
