//
//  TimetrialQuizModeController.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 13/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit

class TimetrialQuizModeController: QuestionViewController {
	
	//TODO: Add timer on left side
	//TODO: Specialise layout methods
	//TODO: Remove feedback time
	//TODO: Change scoring to account for time taken
	//TODO: Close controller when segwaying to next controller

    override func viewDidLoad() {
        super.viewDidLoad()
		testModeColor = appColors["timetrial"]!
		quitQuizButton.setTitleColor(testModeColor, forState: .Normal)
		restartQuizButton.setTitleColor(testModeColor, forState: .Normal)
    }

}
