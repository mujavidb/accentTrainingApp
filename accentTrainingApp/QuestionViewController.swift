//
//  QuestionViewController.swift
//  neaterDifferent
//
//  Created by HochinKazuma on 18/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class QuestionViewController: CustomViewController {
    
    var questionChoice: QuizChoice?
    var audioPlayer: AVAudioPlayer?
    var questionGenerator: QuestionGenerator?
	var replayButton = UIButton()
	var questionNumber = 0
	var testModeColor = UIColor.clearColor()
	
	@IBOutlet weak var quitQuizButton: UIButton!
	@IBOutlet weak var restartQuizButton: UIButton!
	
	
    override func viewDidLoad(){
        super.viewDidLoad()
		audioPlayer = AVAudioPlayer()
        questionGenerator = QuestionGenerator(completQuizChoice: questionChoice!)
		
		if questionGenerator?.quizChoice?.getQuizType() == "practice" {
			testModeColor = appColors["practice"]!
		} else {
			testModeColor = appColors["timetrial"]!
		}
		quitQuizButton.setTitleColor(testModeColor, forState: .Normal)
		restartQuizButton.setTitleColor(testModeColor, forState: .Normal)
		
		setUpReplayButton()
        delay(1.15){ // delay after speaker selected and before audio plays to prepare user
            self.generateQuestion()
        }
    }
	
	func setUpReplayButton(){
		let image = UIImage(named: "speaker")
		replayButton.frame = CGRectMake(
			CGFloat(self.view.frame.width * 0.2),
			CGFloat(self.view.frame.height * 0.15),
			CGFloat(self.view.frame.width * 0.6),
			(image?.size.height)!
		)
		replayButton.setImage(image, forState: .Normal)
		replayButton.titleLabel?.hidden = true
		replayButton.imageView?.contentMode = .Center
        replayButton.addTarget(self, action: #selector(QuestionViewController.replaySound(_:)), forControlEvents: .TouchUpInside)
		self.view.addSubview(replayButton)
	}
	
	func replaySound(sender: CustomButton){
		playSound((questionGenerator?.getQuestionFileName())!)
	}
    
    func generateQuestion(){
        
        removeViews(1)
        questionGenerator?.generateQuestion()
        let fileName = questionGenerator?.getQuestionFileName()
        playSound(fileName!)
        
        delay(1.3){ // delay display button so that the user can focus on the audio first 
            self.displayButtons(self.questionGenerator!.getQuestionSet(), nextFunction: #selector(QuestionViewController.questionButtonPressed(_:)))
        }
        
    }
    
    //gets the audio file in the assets and plays
    func playSound(fileName:String){
        
        if let asset = NSDataAsset(name:fileName) {
            do {
                try audioPlayer = AVAudioPlayer(data:asset.data, fileTypeHint:"mp3")
                audioPlayer!.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func questionButtonPressed(sender: CustomButton){
        var time: Double
		sender.setTitleColor(appColors["white"], forState: .Normal)
		if sender.currentTitle! == questionGenerator?.getAnswer(){
			
			// if correct answer selected
            playSound("feedback-correct")
            sender.backgroundColor = appColors["correctGreen"]
			time = 1.3
        } else {
			
			// if wrong answer selected
            self.playSound("feedback-wrong")
            sender.backgroundColor = appColors["incorrectRed"]
			delay(1){
                let accent = self.questionChoice!.getQuizAccent()
                let speakerName = self.questionChoice!.getQuizSpeaker()
                let answer: String = sender.currentTitle!
                let tempFileName =  "\(accent)_\(speakerName)_\(answer)"
                self.playSound(tempFileName)
                print(tempFileName)
            }
            delay(2){
                for view in self.view.subviews as [UIView] {
                    if let button = view as? CustomButton {
                        if button.currentTitle! == self.questionGenerator?.getAnswer(){
							button.backgroundColor = self.appColors["correctGreen"]
							button.titleLabel?.textColor = self.appColors["white"]
                            let tempFileName = self.questionGenerator?.getQuestionFileName()
                            print(tempFileName)
                            self.playSound(tempFileName!)
							self.delay(1.2){
								self.playSound(tempFileName!)
							}
                        }
                    }
                }
            }
            time = 5
        }
		questionNumber += 1
        delay(time) {
            self.generateQuestion()
        }
    }
	
	func displayButtons(buttonLabelSet: [String], nextFunction: Selector){
		
		var posX: Int
		var posY: Int
		var counter = 0
		
		//select (x, y, width, height) based on actual view dimensions
		let viewHeight = Float(self.view.frame.height);
		let viewWidth = Float(self.view.frame.width);
		let gutterWidth: Float = 20;
		let buttonWidth: Float = (viewWidth - (3 * gutterWidth))/2
		
		//get 70% of height, remove gutter space and divide remaining area by 3
		let buttonHeight = (((viewHeight) * 0.75) - (4 * gutterWidth)) / 3
		
		for label in buttonLabelSet {
			
			posX = Int(gutterWidth + (gutterWidth + buttonWidth) * Float(counter % 2))
			posY = Int((gutterWidth + buttonHeight) * Float( counter / 2) + (viewHeight * 0.45))
			
			let customButton = CustomButton(
				frame: CGRect(x: posX, y: posY, width: Int(buttonWidth), height: Int(buttonHeight))
			)
			customButton.setTitleColor(appColors["darkGrey"], forState: .Normal)
			customButton.setTitle(label, forState: .Normal)
			customButton.titleLabel?.font = UIFont(name: "Arial", size: 24)
			customButton.addTarget(self, action: nextFunction, forControlEvents: .TouchUpInside)
			customButton.backgroundColor = appColors["lightGrey"]
			self.view.addSubview(customButton)
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
//			y: Int(viewHeight - viewHeight * 0.1),
			y: Int((gutterWidth + buttonHeight) * 2 + (viewHeight * 0.45)),
			width: Int(viewWidth - 2 * gutterWidth),
			height: Int(viewHeight * 0.2)
			))
		quizTotalLabel.textColor = appColors["white"]
		quizTotalLabel.text = "\(questionNumber) of \(questionGenerator!.qs.questionSet.count)"
		quizTotalLabel.font = UIFont(name: "Arial", size: 20)
		quizTotalLabel.textAlignment = .Center
		
		quizTotalLabelBackground.layer.cornerRadius = 10
		quizTotalLabelBackground.backgroundColor = testModeColor
		
		self.view.addSubview(quizTotalLabelBackground)
		self.view.addSubview(quizTotalLabel)
		
	}
   

}