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
		
//		let appIcon = UIImage(named: "homeScreen")
//		let homeImage = UIImageView(image: appIcon)
//		homeImage.frame = CGRect(
//			self.view.frame.width - (homeImage.size.width / 2),
//			5,
//			homeImage.size.width,
//			homeImage.size.height,
//		)
		
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
}

