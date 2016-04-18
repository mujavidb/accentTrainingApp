//
//  ViewController.swift
//  neaterDifferent
//
//  Created by HochinKazuma on 18/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
	
	
	@IBOutlet weak var mainLogo: UIImageView!
	@IBOutlet weak var practiceButton: CustomButton!
	@IBOutlet weak var timetrialButton: CustomButton!
	@IBOutlet weak var highscoresButton: CustomButton!
	@IBOutlet weak var aboutButton: UIButton!	
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.whiteColor()
		
		if self.view.frame.height < 568 {
		
			mainLogo.frame = CGRect(
				x: self.view.frame.width * 0.1,
				y: self.view.frame.height * 0.05,
				width: self.view.frame.width * 0.8,
				height: self.view.frame.height * 0.4
			)
			
			var counter: CGFloat = 0
			
			for button in [practiceButton, timetrialButton, highscoresButton]{
				button.frame = CGRect(
					x: self.view.frame.width * 0.1,
					y: self.view.frame.height * 0.5 + (counter * (self.view.frame.height * 0.12 + 10)),
					width: self.view.frame.width * 0.8,
					height: self.view.frame.height * 0.12
					)
				counter = counter + 1
			}
			
			
			
		}
		
    }
	
	@IBAction func goToPractice(sender: CustomButton) {
		if let resultController = storyboard!.instantiateViewControllerWithIdentifier("QuizOptionsController") as? QuizOptionsController {
			resultController.quizOptions.setType("practice")
			presentViewController(resultController, animated: true, completion: nil)
		}
	}
	
	@IBAction func goToTimetrial(sender: AnyObject) {
		if let resultController = storyboard!.instantiateViewControllerWithIdentifier("QuizOptionsController") as? QuizOptionsController {
			resultController.quizOptions.setType("timetrial")
			presentViewController(resultController, animated: true, completion: nil)
		}
	}
	
	//allows moving back to MainVC
	@IBAction func unwindToMVC(segue: UIStoryboardSegue){}
}

