//
//  TimetrialQuizModeController.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 13/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit
import AVFoundation

class TimetrialQuizModeController: QuestionViewController {
	
	//TODO: Add timer on top
	//TODO: Remove feedback time
	//TODO: Change scoring to account for time taken
	//TODO: Close controller when segwaying to next controller
	
	var answerSelected = false
	var answerStartTime: NSDate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
		
		audioPlayer = AVAudioPlayer()
		questionGenerator = QuestionGenerator(completQuizChoice: questionChoice!)
		quizLength = questionChoice!.getQuizLengthInt()
		testModeColor = appColors["timetrial"]!
		quitQuizButton.setTitleColor(testModeColor, forState: .Normal)
		restartQuizButton.setTitleColor(testModeColor, forState: .Normal)
		
		setUpReplayButton()
		setupTimer()
		
		delay(0.5){
			self.generateQuestion()
		}
    }
	
	func generateQuestion(){
		
		removeViews(1)
		questionGenerator?.generateQuestion()
		let fileName = questionGenerator?.getQuestionFileName()
		let percentage = Double(userScore) / Double(quizLength)
		playSound(fileName!)
		
		self.displayButtons(self.questionGenerator!.getQuestionSet(), nextFunction: #selector(TimetrialQuizModeController.questionButtonPressed(_:)))
		
		answerSelected = false
		generateTimer()
	}
	
	func setUpReplayButton(){
		let image = UIImage(named: "speaker")
		replayButton.frame = CGRect(
			x: self.view.frame.width * 0.2,
			y: self.view.frame.height * 0.16,
			width: self.view.frame.width * 0.6,
			height: (image?.size.height)!
		)
		replayButton.setImage(image, forState: .Normal)
		replayButton.titleLabel?.hidden = true
		replayButton.imageView?.contentMode = .Center
		replayButton.addTarget(self, action: #selector(QuestionViewController.replaySound(_:)), forControlEvents: .TouchUpInside)
		self.view.addSubview(replayButton)
	}
	
	func setupTimer(){
		
		let timerBackground = UIView(frame: CGRect(
			x: viewWidth * 0.07,
			y: viewHeight * 0.11,
			width: viewWidth * 0.86,
			height: 10
			))
		timerBackground.layer.cornerRadius = timerBackground.frame.height / 2
		timerBackground.backgroundColor = appColors["timetrialLight"]
		timerBackground.tag = 2
		self.view.addSubview(timerBackground)
		
	}
	
	func generateTimer(){
		
		answerStartTime = NSDate()
		
		let timerSeeker = UIView(frame: CGRect(
			x: viewWidth * 0.07,
			y: viewHeight * 0.11,
			width: viewWidth * 0.86,
			height: 10
			))
		timerSeeker.layer.cornerRadius = 5
		timerSeeker.backgroundColor = testModeColor
		timerSeeker.tag = 3
		
		self.view.addSubview(timerSeeker)
		
		UIView.animateWithDuration(
			5,
			animations: { () -> Void in
				timerSeeker.frame = CGRect(
					x: self.viewWidth * 0.07,
					y: self.viewHeight * 0.11,
					width: 10,
					height: 10
				)
			})
		
		delay(4){
			UIView.animateWithDuration(
				0.5,
				animations: { () -> Void in
					timerSeeker.alpha = 0
			})
		}
		
		delay(5){
			if self.answerSelected == false {
				//TODO: disable buttons
				self.questionButtonPressed(nil)
			}
		}
	}
	
	func questionButtonPressed(sender: CustomButton?){
		
		answerSelected = true
		removeViews(3)
		
		if sender != nil {
			
			sender!.setTitleColor(appColors["white"], forState: .Normal)
			
			if sender!.currentTitle! == questionGenerator?.getAnswer(){
				
				playSound("feedback-correct")
				sender!.backgroundColor = appColors["correctGreen"]
				
				userScore += Int(10 * scoreTimeFactor())
				
			} else {
				
				self.playSound("feedback-wrong")
				sender!.backgroundColor = appColors["incorrectRed"]
			}
		}
		
		delay(0.5) {
			
			if(self.stopCount != 1){
				if (self.questionNumber == self.quizLength){
					
					// When all questions have been answered
					self.audioPlayer!.stop()
					if let resultController = self.storyboard!.instantiateViewControllerWithIdentifier("ResultsViewController") as? ResultsViewController {
						resultController.result = self.userScore
						resultController.quizType = (self.questionChoice?.getQuizType())!
						resultController.maxScore = self.quizLength * 10
						self.presentViewController(resultController, animated: true, completion: nil)
					}
				} else {
					self.questionNumber += 1
					self.generateQuestion()
				}
			}
		}
	}
	
	func scoreTimeFactor() -> Float {
		let elapsedTime = NSDate().timeIntervalSinceDate(answerStartTime!)
		
		if elapsedTime < 1 {
			return 2.0
		} else if elapsedTime < 2 {
			return 1.6
		} else if elapsedTime < 5 {
			return 1.2
		} else if elapsedTime < 7 {
			return 0.8
		} else {
			return 0.4
		}
	}
	
	func displayButtons(buttonLabelSet: [String], nextFunction: Selector){
		
		var counter = 0
		
		//select (x, y, width, height) based on actual view dimensions
		let viewHeight = Float(self.view.frame.height);
		let viewWidth = Float(self.view.frame.width);
		let gutterWidth: Float = viewWidth / 16;
		let buttonWidth: Float = (viewWidth - (3 * gutterWidth))/2
		
		//get 75% of height, remove gutter space and divide remaining area by 3
		let buttonHeight = (((viewHeight) * 0.75) - (4 * gutterWidth)) / 3
		
		for label in buttonLabelSet {
			
			let customButton = CustomButton(
				frame: CGRect(
					x: Int(gutterWidth + (gutterWidth + buttonWidth) * Float(counter % 2)),
					y: Int((gutterWidth + buttonHeight) * Float( counter / 2) + (viewHeight * 0.46)),
					width: Int(buttonWidth),
					height: Int(buttonHeight))
			)
			customButton.setTitleColor(appColors["darkGrey"], forState: .Normal)
			customButton.setTitle(label, forState: .Normal)
			customButton.titleLabel?.font = UIFont(name: "Arial", size: 24)
			customButton.addTarget(self, action: nextFunction, forControlEvents: .TouchUpInside)
			customButton.backgroundColor = appColors["lightGrey"]
			fadeCentreInToSubview(customButton, delay: 0.25, completionAction: nil)
			customButton.tag = 1
			counter = counter + 1
		}
		
		let quizTotalLabel = UILabel(frame: CGRect(
			x: Int(gutterWidth),
			y: Int(viewHeight - viewHeight * 0.075),
			width: Int(viewWidth - 2 * gutterWidth),
			height: Int(viewHeight * 0.075)
			))
		let quizTotalLabelBackground = UIView(frame: CGRect(
			x: Int(gutterWidth),
			y: Int((gutterWidth + buttonHeight) * 2 + (viewHeight * 0.45)),
			width: Int(viewWidth - 2 * gutterWidth),
			height: Int(viewHeight * 0.2)
			))
		quizTotalLabel.textColor = appColors["white"]
		quizTotalLabel.text = "\(questionNumber) of \(quizLength)"
		quizTotalLabel.font = UIFont(name: "Arial", size: 20)
		quizTotalLabel.textAlignment = .Center
		
		quizTotalLabelBackground.layer.cornerRadius = 10
		quizTotalLabelBackground.backgroundColor = testModeColor
		
		self.view.addSubview(quizTotalLabelBackground)
		self.view.addSubview(quizTotalLabel)
		
		//		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(20)-[headerView]-(5)-[title(200)][]|", options: .None, metrics: <#T##[String : AnyObject]?#>, views: <#T##[String : AnyObject]#>))
		
	}


}
