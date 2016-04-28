//
//  QuizOptionsController.swift
//  neaterDifferent
//
//  Created by Mujavid Bukhari on 09/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation
import UIKit


class QuizOptionsController: CustomViewController{
    
    let quizOptions = QuizChoice()
    let lengthOptions = ["Short (15)","Medium (25)","Long (40)"]
    let accentOptions = ["London","US","Manchester","NewZealand","Australia","Glasgow"]
    let speakerOptions = [
        "London" : ["Anna","Chloe","John","Matthew"],
        "US" : ["Katie","Vinny","Sharon","Clare"],
        "Manchester":["Alex","Olivia","Sam"],
        "NewZealand": ["Richard","Ruby","Jack"],
        "Australia": ["Shane","Marlee"],
        "Glasgow":["Steward","Laura","Robert","Anna"]
    ]
	
	var testModeColor = UIColor.clearColor()
	
	@IBOutlet weak var testModeTitle: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		//depending on quiztype default color is set
		if quizOptions.getQuizType() == "practice" {
			testModeColor = appColors["practice"]!
		} else {
			testModeColor = appColors["timetrial"]!
			testModeTitle.text = "Time Trial"
		}
		self.view.backgroundColor = testModeColor
		getLengthOptions()
    }
	
    func getLengthOptions(){
        displayLabel("Choose quiz length", textColor: testModeColor)
		displaySingleColumnButtons(lengthOptions, textColor: testModeColor, nextFunction: #selector(QuizOptionsController.getAccentOptions(_:)))
    }
	
    func getAccentOptions(sender: CustomButton){
        self.quizOptions.setLength(sender.currentTitle!)
        removeViews(1)
		delay(0.25){
			self.displayLabel("Choose an accent", textColor: self.testModeColor)
			self.displayTwoColumnButtons(self.accentOptions, textColor: self.testModeColor, nextFunction:#selector(QuizOptionsController.getSpeakerOptions(_:)))
		}
    }
    
    func getSpeakerOptions(sender: CustomButton){
        self.quizOptions.setAccent(sender.currentTitle!)
        removeViews(1)
		delay(0.25){
			self.displayLabel("Choose a speaker", textColor: self.testModeColor)
			self.displayTwoColumnButtons(self.speakerOptions[self.quizOptions.getQuizAccent()]!, textColor: self.testModeColor, nextFunction: #selector(QuizOptionsController.moveToQuestionView(_:)))
		}
    }
    
    func moveToQuestionView(sender:CustomButton){
        quizOptions.setSpeaker(sender.currentTitle!)
		
		if quizOptions.getQuizType() == "practice" {
			if let resultController = storyboard!.instantiateViewControllerWithIdentifier("PracticeQuizModeController") as? PracticeQuizModeController {
				resultController.questionChoice = self.quizOptions
				presentViewController(resultController, animated: true, completion: nil)
			}
		} else {
			if let resultController =
				storyboard!.instantiateViewControllerWithIdentifier("TimetrialQuizModeController") as? TimetrialQuizModeController {
				resultController.questionChoice = self.quizOptions
				presentViewController(resultController, animated: true, completion: nil)
			}
		}
    }
	
	//used for quiz length selection
	func displaySingleColumnButtons(buttonLabelSet: [String], textColor: UIColor, nextFunction: Selector){
		var posX: Int
		var posY: Int
		var counter = 1
		
		let viewHeight = Float(self.viewHeight)
		let viewWidth = Float(self.viewWidth)
		let gutterSize = Int(viewWidth / 18.75)
		let buttonWidth = Int(viewWidth) - (2 * gutterSize)
		posX = gutterSize;
		
		let buttonHeight = Int(((Int(viewHeight * 0.5) / (buttonLabelSet.count)) - gutterSize))
		
		for label in buttonLabelSet {
			
			posY = Int(80 + (counter * (buttonHeight + gutterSize)))
			
			let customButton = CustomButton(
				frame: CGRect(x: posX, y: posY, width: buttonWidth, height: buttonHeight)
			)
			customButton.setTitleColor(textColor, forState: .Normal)
			customButton.setTitle(label, forState: .Normal)
			customButton.titleLabel!.font = UIFont.boldMainFontOfSize(CGFloat(viewWidth / 14.4))
			customButton.addTarget(self, action: nextFunction, forControlEvents: .TouchUpInside)
			customButton.backgroundColor = appColors["white"]
			self.view.addSubview(customButton)
			customButton.tag = 1
			counter = counter + 1
		}
	}
	
	func displayTwoColumnButtons(buttonLabelSet: [String], textColor: UIColor, nextFunction: Selector){
		
		var posX: Int
		var posY: Int
		var counter = 0
		
		//select (x, y, width, height) based on actual view dimensions
		let viewHeight = Float(self.viewHeight)
		let viewWidth = Float(self.viewWidth)
		
		let gutterWidth = viewWidth / 18.75
		let buttonWidth = (viewWidth - (3 * gutterWidth)) / 2
		
		//get 75% of height, remove gutter space and divide remaining area by 3
		let buttonHeight = (((viewHeight) * 0.75) - (4 * gutterWidth)) / 3
		
		let spacing: CGFloat = viewHeight >= 568 ? 6 : 4
		let edgeInsets = UIEdgeInsetsMake(0.0, -80.0, -(80.0 + spacing), 0.0);
		
		var labelString: NSString
		var titleSize: CGSize
		
		let screenAdjustmentFactor: CGFloat = viewHeight > 700 ? 11 : viewHeight > 568 ? 6 : (viewHeight == 568 ? -2 : -9.5)
		
		for label in buttonLabelSet {
			
			posX = Int(gutterWidth + (gutterWidth + buttonWidth) * Float(counter % 2))
			posY = Int((gutterWidth + buttonHeight + (viewHeight > 568 ? 0 : 10)) * Float( 1 + counter / 2))
			
			let image = UIImage(named: label)
			
			let customButton = CustomButton(
				frame: CGRect(x: posX, y: posY, width: Int(buttonWidth), height: Int(buttonHeight))
			)
			customButton.setImage(image, forState: .Normal)
			customButton.setTitleColor(appColors["white"], forState: .Normal)
			customButton.setTitle(label, forState: .Normal)
			customButton.titleLabel!.font = UIFont.boldMainFontOfSize(CGFloat(viewWidth / 14.4))
			customButton.addTarget(self, action: nextFunction, forControlEvents: .TouchUpInside)
			customButton.tag = 1
			
			customButton.titleEdgeInsets = edgeInsets
			labelString = NSString(string: customButton.titleLabel!.text!)
			titleSize = labelString.sizeWithAttributes([NSFontAttributeName: customButton.titleLabel!.font])
			customButton.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width);
			
			let buttonImageBorder = UIView(frame: CGRect(
				x: customButton.frame.origin.x + ((customButton.frame.width - 80) / 2) - (viewHeight >= 568 ? 5 : 2.5),
				y: customButton.frame.origin.y + screenAdjustmentFactor,
				width: 80 + (viewHeight >= 568 ? 10 : 5),
				height: 80 + (viewHeight >= 568 ? 10 : 5)
				))
			buttonImageBorder.layer.cornerRadius = (80 + (viewHeight >= 568 ? 10 : 5)) / 2
			buttonImageBorder.backgroundColor = appColors["white"]
			buttonImageBorder.tag = 1
				
			fadeUpInToSubview(buttonImageBorder, delay: 0.25 + (0.05 * Double(( counter == 0 || counter == 1 ? 0 : counter == 2 || counter == 3 ? 1 : 2))), completionAction: nil)
			
			fadeUpInToSubview(customButton, delay: 0.25 + (0.05 * Double(( counter == 0 || counter == 1 ? 0 : counter == 2 || counter == 3 ? 1 : 2))), completionAction: nil)
			counter = counter + 1
		}
	}
	
}