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
	
    override func viewDidLoad(){
        super.viewDidLoad()
		audioPlayer = AVAudioPlayer()
        questionGenerator = QuestionGenerator(completQuizChoice: questionChoice!)
        generateQuestion()
		setUpReplayButton()
    }
	
	func setUpReplayButton(){
		replayButton.frame = CGRect(
			x: Int(self.view.frame.width * 0.15),
			y: 75,
			width: Int(self.view.frame.width * 0.7),
			height: Int(self.view.frame.width * 0.7)
		)
		replayButton.titleLabel?.hidden = true
		replayButton.imageView?.image = UIImage(contentsOfFile: "speaker")
		replayButton.imageView?.contentMode = UIViewContentMode.Center
		self.view.addSubview(replayButton)
	}
    
    func generateQuestion(){
        
        removeViews(1)
        questionGenerator?.generateQuestion()
		displayButtons(questionGenerator!.getQuestionSet(), nextFunction: "questionButtonPressed:")
        let fileName = questionGenerator?.getQuestionFileName()
        displayLabel(fileName!, textColor: UIColor.blackColor())
        playSound(fileName!)
        
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
        if sender.currentTitle! == questionGenerator?.getAnswer(){ // if correct answer selected
            playSound("feedback-correct")
            sender.backgroundColor = UIColor.greenColor()
            time = 1.3
            
        }
        else{ // if wrong answer selected
            self.playSound("feedback-wrong")
            sender.backgroundColor = UIColor.redColor()
            delay(1){
        
                let accent = self.questionChoice!.getQuizAccent()
                let speakerName = self.questionChoice!.getQuizSpeaker()
                let answer: String = sender.currentTitle!
                let tempFileName =  "\(accent)_\(speakerName)_\(answer)"
                self.playSound(tempFileName)
                print(tempFileName)
            }
            delay(3){
                for view in self.view.subviews as [UIView] {
                    if let button = view as? CustomButton {
                        if button.currentTitle! == self.questionGenerator?.getAnswer(){
                            button.backgroundColor = UIColor.greenColor()
                            let tempFileName = self.questionGenerator?.getQuestionFileName()
                            print(tempFileName)
                            self.playSound(tempFileName!)
                        }
                    }
                }
            }
            time = 5
        }
        delay(time) {
            self.generateQuestion()
        }
    }
    
    func delay(time:Double, closure:()->Void) { // delays for double second and executes the code inside the closure
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(time * Double(NSEC_PER_SEC))),dispatch_get_main_queue(), closure)
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
			customButton.setTitle(label, forState: UIControlState.Normal)
			customButton.titleLabel?.font = UIFont(name: "Arial", size: 24)
			customButton.addTarget(self, action: nextFunction, forControlEvents: .TouchUpInside)
			customButton.backgroundColor = appColors["lightGrey"]
			self.view.addSubview(customButton)
			customButton.tag = 1
			counter = counter + 1
		}
	}
   

}