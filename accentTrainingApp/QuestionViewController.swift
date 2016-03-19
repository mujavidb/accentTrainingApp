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


class QuestionViewController: CustomViewController{
    
    var questionChoice: QuizChoice?
    var audioPlayer: AVAudioPlayer?
    var questionGenerator: QuestionGenerator?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer()
        questionGenerator = QuestionGenerator(completQuizChoice: questionChoice!)
        generateQuestion()
    }
    
    func generateQuestion(){
        
        removeViews(1)
        questionGenerator?.generateQuestion()
        displayButtons(questionGenerator!.getQuestionSet(),nextFunction: "questionButtonPressed:")
        let fileName = questionGenerator?.getQuestionFileName()
        displayLabel(fileName!)
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
        }else{
            playSound("feedback-wrong")
        }
        sleep(1)
        generateQuestion()
    }
    
    
    
    
    
}