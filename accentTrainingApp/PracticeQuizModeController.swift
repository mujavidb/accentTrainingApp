//
//  PracticeQuizModeController.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 13/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit

class PracticeQuizModeController: QuestionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		testModeColor = appColors["practice"]!
		quitQuizButton.setTitleColor(testModeColor, forState: .Normal)
		restartQuizButton.setTitleColor(testModeColor, forState: .Normal)
	}

}
