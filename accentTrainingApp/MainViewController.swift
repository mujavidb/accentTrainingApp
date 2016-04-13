//
//  ViewController.swift
//  neaterDifferent
//
//  Created by HochinKazuma on 18/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.whiteColor()
    }
	
	@IBAction func practiceButton(sender: CustomButton) {
		if let resultController = storyboard!.instantiateViewControllerWithIdentifier("QuizOptionsController") as? QuizOptionsController {
			resultController.quizOptions.setType("practice")
			presentViewController(resultController, animated: true, completion: nil)
		}
	}
	
	@IBAction func timetrialButton(sender: AnyObject) {
		if let resultController = storyboard!.instantiateViewControllerWithIdentifier("QuizOptionsController") as? QuizOptionsController {
			resultController.quizOptions.setType("timetrial")
			presentViewController(resultController, animated: true, completion: nil)
		}
	}
	
	//allows moving back to MainVC
	@IBAction func unwindToMVC(segue: UIStoryboardSegue){}
	
	//remove this
	func delay(time:Double, closure:() -> Void) {
		
		// delays for double second and executes the code inside the closure
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(time * Double(NSEC_PER_SEC))),dispatch_get_main_queue(), closure)
	}
}

