//
//  PracticeQuizModeController.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 13/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit
import AVFoundation

class PracticeQuizModeController: QuestionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		audioPlayer = AVAudioPlayer()
		questionGenerator = QuestionGenerator(completQuizChoice: questionChoice!)
		quizLength = questionChoice!.getQuizLengthInt()
		
		setUpReplayButton()
		
		// delay after speaker selected and before audio plays to prepare user
		delay(0.5){
			self.generateQuestion()
		}
		
		testModeColor = appColors["practice"]!
		quitQuizButton.setTitleColor(testModeColor, forState: .Normal)
		restartQuizButton.setTitleColor(testModeColor, forState: .Normal)
	}
	
	func generateQuestion(){
		
		removeViews(1)
        
        repeat{
            questionGenerator?.generateQuestion() //makes sure audio file exists
			
			//NSDataAsset(name: (questionGenerator?.getQuestionFileName())!) == nil //for ios 9 onwards
		} while(fileExists((questionGenerator?.getQuestionFileName())!) == false )
        
		let fileName = questionGenerator?.getQuestionFileName()
		playSound(fileName!)
		
        delay(0.8){
			//display the buttons after the audio has been played
            self.displayButtons(self.questionGenerator!.getQuestionSet(), nextFunction: #selector(PracticeQuizModeController.questionButtonPressed(_:)))
        }
		
	}
	
	func questionButtonPressed(sender: CustomButton){
		var time: Double
		sender.setTitleColor(appColors["white"], forState: .Normal)
		
		if sender.currentTitle! == questionGenerator?.getAnswer(){
			playSound("feedback-correct")
			sender.backgroundColor = appColors["correctGreen"]
			userScore = userScore + 10
			time = 1.3
		} else {
			
			self.playSound("feedback-wrong")
			sender.backgroundColor = appColors["incorrectRed"]
			
			// increase the probability of incorrectly selected vowel sound
			questionGenerator?.changeVowelProbability((questionGenerator?.rhymeSetIndex!)!, value: 1.2)
            
			delay(1){
				let accent = self.questionChoice!.getQuizAccent()
				let speakerName = self.questionChoice!.getQuizSpeaker()
				let answer: String = sender.currentTitle!
				let wrongFileName =  "\(accent)_\(speakerName)_\(answer)"
				let correctFileName = self.questionGenerator?.getQuestionFileName()
				
				for view in self.view.subviews{
					if let correctOption = view as? CustomButton {
						if correctOption.currentTitle! == self.questionGenerator?.getAnswer(){
							self.feedbackForWrong(sender, correctButton: correctOption, wrongFile: wrongFileName, correctFile: correctFileName!)
							self.delay(2.4){
								self.feedbackForWrong(sender, correctButton: correctOption, wrongFile: wrongFileName, correctFile: correctFileName!)
							}
						}
					}
				}
			}
			
			time = 6
		}
		
		delay(time) {
			if(self.stopCount != 1){
				if (self.questionNumber == self.quizLength){
					
					// session completed
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
	
	func displayButtons(buttonLabelSet: [String], nextFunction: Selector){
		
		var counter = 0
		
		//select (x, y, width, height) based on actual view dimensions
		let viewHeight = Float(self.view.frame.height);
		let viewWidth = Float(self.view.frame.width);
		let gutterWidth: Float = 20;
		let buttonWidth: Float = (viewWidth - (3 * gutterWidth))/2
		
		//get 70% of height, remove gutter space and divide remaining area by 3
		let buttonHeight = (((viewHeight) * 0.75) - (4 * gutterWidth)) / 3
		
		for label in buttonLabelSet {
			
			let customButton = CustomButton(
				frame: CGRect(
					x: Int(gutterWidth + (gutterWidth + buttonWidth) * Float(counter % 2)),
					y: Int((gutterWidth + buttonHeight) * Float( counter / 2) + (viewHeight * 0.45)),
					width: Int(buttonWidth),
					height: Int(buttonHeight))
			)
			customButton.setTitleColor(appColors["darkGrey"], forState: .Normal)
			customButton.setTitle(label, forState: .Normal)
			customButton.titleLabel?.font = UIFont.mainFontOfSize(24)
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
		quizTotalLabel.font = UIFont.mainFontOfSize(20)
		quizTotalLabel.textAlignment = .Center
		
		quizTotalLabelBackground.layer.cornerRadius = 10
		quizTotalLabelBackground.backgroundColor = testModeColor
		
		self.view.addSubview(quizTotalLabelBackground)
		self.view.addSubview(quizTotalLabel)
		
		//		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(20)-[headerView]-(5)-[title(200)][]|", options: .None, metrics: <#T##[String : AnyObject]?#>, views: <#T##[String : AnyObject]#>))
		
	}


}
