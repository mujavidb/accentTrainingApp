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
	
	var answerSelected = false
	var answerStartTime: NSDate? = nil
	var selectionTimer: NSTimer? = NSTimer()
	
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
		
		generateQuestion()
		
		//Create the background label for the question number area
		let gutterWidth = viewWidth / 16;
		let buttonHeight = (((viewHeight) * 0.75) - (4 * gutterWidth)) / 3
		let quizTotalLabelBackground = UIView(frame: CGRect(
			x: Int(gutterWidth),
			y: Int((gutterWidth + buttonHeight) * 2 + (viewHeight * 0.45)),
			width: Int(viewWidth - 2 * gutterWidth),
			height: Int(viewHeight * 0.2)
			))
		quizTotalLabelBackground.layer.cornerRadius = 10
		quizTotalLabelBackground.backgroundColor = testModeColor
		self.view.addSubview(quizTotalLabelBackground)
    }
	
	@IBAction func restartQuiz(sender: AnyObject) {
		let restartPrompt = UIAlertController(title: "Are you sure you want to restart?", message: "", preferredStyle: .Alert)
		restartPrompt.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
		restartPrompt.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (UIAlertAction) in
			self.stopCount = 1
			self.audioPlayer!.stop()
			self.selectionTimer!.invalidate()
			self.selectionTimer = nil
			if let resultController = self.storyboard!.instantiateViewControllerWithIdentifier("TimetrialQuizModeController") as? TimetrialQuizModeController {
				resultController.questionChoice = self.questionChoice
				self.presentViewController(resultController, animated: true, completion: nil)
			}
		}))
		presentViewController(restartPrompt, animated: true, completion: nil)
	}
	
	@IBAction func quitPressed(sender: UIButton) {
		let quitPrompt = UIAlertController(title: "Are you sure you want to quit?", message: "", preferredStyle: .Alert)
		quitPrompt.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
		quitPrompt.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (UIAlertAction) in
			self.stopCount = 1
			self.audioPlayer!.stop()
			self.selectionTimer!.invalidate()
			self.selectionTimer = nil
			self.view.window!.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
		}))
		presentViewController(quitPrompt, animated: true, completion: nil)
	}
	
	override func setUpReplayButton(){
		let image = UIImage(named: "speaker")
		
		replayButton.frame = CGRect(
			x: self.view.frame.width * 0.2,
			y: self.view.frame.height * 0.18,
			width: self.view.frame.width * 0.6,
			height: CGFloat(viewWidth * 0.4)
		)
		
		replayButton.setImage(image, forState: .Normal)
		replayButton.titleLabel?.hidden = true
		replayButton.imageView?.contentMode = .ScaleAspectFit
		replayButton.addTarget(self, action: #selector(QuestionViewController.replaySound(_:)), forControlEvents: .TouchUpInside)
		self.view.addSubview(replayButton)
	}
	
	func generateQuestion(){
		
		removeViews(1)
		removeViews(2)
        repeat{
            questionGenerator?.generateQuestion() //makes sure audio file exists
			
			//NSDataAsset(name: (questionGenerator?.getQuestionFileName())!) == nil //for ios 9 onwards
        } while(fileExists((questionGenerator?.getQuestionFileName())!) == false )
		
        let fileName = questionGenerator?.getQuestionFileName()
		playSound(fileName!)
		
        delay(1.0){
			//display the buttons after the audio has been played
            self.displayButtons(self.questionGenerator!.getQuestionSet(), nextFunction: #selector(TimetrialQuizModeController.questionButtonPressed(_:)))
            self.answerSelected = false
            self.generateTimer()
        }
	}
	
	//display background timer bar
	func setupTimer(){
		
		let timerBackground = UIView(frame: CGRect(
			x: viewWidth * 0.07,
			y: viewHeight * 0.11,
			width: viewWidth * 0.86,
			height: 10
			))
		timerBackground.layer.cornerRadius = timerBackground.frame.height / 2
		timerBackground.backgroundColor = appColors["timetrialLight"]
		timerBackground.tag = 5
		self.view.addSubview(timerBackground)
	}
	
	//display foreground (decreasing) timer bar
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
		
		selectionTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(TimetrialQuizModeController.noOptionSelected), userInfo: nil, repeats: false)
	}
	
	func noOptionSelected(){
		if self.answerSelected == false {
			self.questionButtonPressed(nil)
		}
	}
	
	func questionButtonPressed(sender: CustomButton?){
		
		//disable all buttons
		changeButtonStates()
		
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
                
				// increase the probability of incorrectly selected vowel sound
				questionGenerator?.changeVowelProbability((questionGenerator?.rhymeSetIndex!)!, value: 1.2)
			}
		} else {
			playSound("feedback-wrong")
			delay(0.3){
				for view in self.view.subviews{
					if let correctOption = view as? CustomButton {
						if correctOption.currentTitle! == self.questionGenerator?.getAnswer(){
							correctOption.setTitleColor(self.appColors["white"], forState: .Normal)
							correctOption.backgroundColor = self.appColors["correctGreen"]
						}
					}
				}
			}
		}
		
		delay(1.5) {
			
			if(self.stopCount != 1){
				
				//Stop NSTimer to prevent spillover into next question
				self.selectionTimer!.invalidate()
				self.selectionTimer = nil
				
				if (self.questionNumber == self.quizLength){
					
					// When all questions have been answered
					self.audioPlayer!.stop()
					if let resultController = self.storyboard!.instantiateViewControllerWithIdentifier("ResultsViewController") as? ResultsViewController {
						resultController.result = self.userScore
						resultController.quizOptions = self.questionChoice
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
		} else if elapsedTime < 3 {
			return 1.2
		} else {
			return 0.8
		}
	}
	
	//Complex function that creates several view items
	//The majority of the complexity is fine tuning values for differant screen sizes
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
			customButton.titleLabel?.font = UIFont.mainFontOfSize(viewHeight > 700 ? 30 : 24)
			customButton.addTarget(self, action: nextFunction, forControlEvents: .TouchUpInside)
			customButton.backgroundColor = appColors["lightGrey"]
			fadeCentreInToSubview(customButton, delay: 0.25, completionAction: nil)
			customButton.tag = 1
			counter = counter + 1
		}
		
		removeViews(6)
		let quizTotalLabel = UILabel(frame: CGRect(
			x: Int(gutterWidth),
			y: Int(viewHeight - viewHeight * 0.075),
			width: Int(viewWidth - 2 * gutterWidth),
			height: Int(viewHeight * 0.075)
			))
		quizTotalLabel.textColor = appColors["white"]
		quizTotalLabel.text = "\(questionNumber) of \(quizLength)"
		quizTotalLabel.font = UIFont.mainFontOfSize(viewHeight > 700 ? 26 : 20)
		quizTotalLabel.textAlignment = .Center
		
		quizTotalLabel.tag = 6
		self.view.addSubview(quizTotalLabel)
		
	}


}
