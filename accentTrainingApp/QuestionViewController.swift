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
	
	//TODO: Change feedback audio files
    
    var questionChoice: QuizChoice?
    var audioPlayer: AVAudioPlayer?
    var questionGenerator: QuestionGenerator?
	var replayButton = UIButton()
	var questionNumber = 1
	var testModeColor = UIColor.clearColor()
	var quizLength = 0
    var counter = 0
    var stopCount = 0
    var userScore = 0
	@IBOutlet weak var quitQuizButton: UIButton!
	@IBOutlet weak var restartQuizButton: UIButton!
	
	
    override func viewDidLoad(){
        super.viewDidLoad()
		if viewHeight > 700 {
			quitQuizButton.titleLabel?.font = UIFont.mainFontOfSize(24)
			quitQuizButton.frame = CGRect(
				x: quitQuizButton.frame.origin.x,
				y: quitQuizButton.frame.origin.y,
				width: quitQuizButton.frame.width + 50,
				height: quitQuizButton.frame.height
			)
			restartQuizButton.titleLabel?.font = UIFont.mainFontOfSize(24)
			restartQuizButton.frame = CGRect(
				x: restartQuizButton.frame.origin.x - 50,
				y: restartQuizButton.frame.origin.y,
				width: restartQuizButton.frame.width + 50,
				height: restartQuizButton.frame.height
			)
		}
    }
	
	func setUpReplayButton(){
		let image = UIImage(named: "speaker")
		
		replayButton.frame = CGRect(
			x: self.view.frame.width * 0.2,
			y: self.view.frame.height * 0.16,
			width: self.view.frame.width * 0.6,
			height: CGFloat(viewWidth * 0.4)
		)
		
		replayButton.setImage(image, forState: .Normal)
		replayButton.titleLabel?.hidden = true
		replayButton.imageView?.contentMode = .ScaleAspectFit
		replayButton.addTarget(self, action: #selector(QuestionViewController.replaySound(_:)), forControlEvents: .TouchUpInside)
		self.view.addSubview(replayButton)
	}
	
	func replaySound(sender: CustomButton){
		playSound((questionGenerator?.getQuestionFileName())!)
	}
	
    //gets the audio file in the assets and plays - http://www.techotopia.com/index.php/Playing_Audio_on_iOS_8_using_AVAudioPlayer
    func playSound(fileName:String){
        
        let url = NSURL.fileURLWithPath(
            NSBundle.mainBundle().pathForResource(fileName,
                ofType: "mp3")!)
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: url)
        audioPlayer!.play()
    }
	
	//disable all buttons
	func changeButtonStates(){
		var viewsToChangeState = [CustomButton]()
		self.view.subviews.forEach({ if $0.tag == 1 { viewsToChangeState.append(($0 as? CustomButton)!)}})
		for button in viewsToChangeState {
			if button.enabled {
				button.enabled = false
			}
		}
	}
    
    func fileExists(fileName: String)-> Bool{
		
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")
        if path != nil{
            return true
        }
        return false
    }
	
	//return a highlighted button back to greys
    func returnToDefaultState(button: CustomButton){
        button.backgroundColor = appColors["lightGrey"]
        button.setTitleColor(appColors["darkGrey"], forState: .Normal)
    }
    
    func feedbackForWrong(wrongButton: CustomButton, correctButton: CustomButton, wrongFile: String, correctFile: String){
        if stopCount != 1 {
			wrongButton.setTitleColor(self.appColors["white"], forState: .Normal)
			wrongButton.backgroundColor = appColors["incorrectRed"]
			playSound(wrongFile)
			delay(1.2){
				self.returnToDefaultState(wrongButton)
				
				if(self.stopCount != 1){
					correctButton.setTitleColor(self.appColors["white"], forState: .Normal)
					correctButton.backgroundColor = self.appColors["correctGreen"]
					self.playSound(correctFile)
					self.delay(1){
						self.returnToDefaultState(correctButton)
					}
				}
			}
		}
	}
	
	@IBAction func unwindToMVC(segue: UIStoryboardSegue){}
}