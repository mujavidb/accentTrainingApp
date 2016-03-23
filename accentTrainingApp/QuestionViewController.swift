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
        if sender.currentTitle! == questionGenerator?.getAnswer(){
            playSound("feedback-correct")
            sender.backgroundColor = UIColor.greenColor()
        }
        else{
            playSound("feedback-wrong")
            sender.backgroundColor = UIColor.redColor()
            delay(0.5){
                for view in self.view.subviews as [UIView] {
                    if let btn = view as? CustomButton {
                        if btn.currentTitle! == self.questionGenerator?.getAnswer(){
                            btn.backgroundColor = UIColor.greenColor()
                        }
                    }
                }
            }
        }
        delay(1) {
            self.generateQuestion()
        }
    }
    
    func delay(delay:Double, closure:()->()) { // delays for double second and executes the code inside the closure
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
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