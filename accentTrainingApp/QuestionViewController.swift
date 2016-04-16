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
    }
	
	func replaySound(sender: CustomButton){
		playSound((questionGenerator?.getQuestionFileName())!)
	}
	
    //gets the audio file in the assets and plays
    func playSound(fileName:String){
        
        if let asset = NSDataAsset(name:fileName) {
            try! audioPlayer = AVAudioPlayer(data:asset.data, fileTypeHint:"mp3")
            audioPlayer!.play()
        }
    }
	
    @IBAction func quitPressed(sender: UIButton) {
        self.stopCount = 1
        self.audioPlayer!.stop()
    }
    
    func returnToDefaultState(button: CustomButton){ //to put the button back to its original state
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

}