//
//  QuizOptionsController.swift
//  neaterDifferent
//
//  Created by HochinKazuma on 18/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation
import UIKit


class QuizOptionsController: CustomViewController{
    
    let quizOptions = QuizChoice()
    let lengthOptions = ["15","25","35"]
    let accentOptions = ["London","US","Manchester","NewZealand","Australia","Glasgow","Australia"]
    let speakerOptions = [
        "London" : ["Anna","Chloe","John","Matthew"],
        "US" : ["01","04","05","06"],
        "Manchester":["01","02","03"],
        "NewZealand": ["03","04","05"],
        "Australia": ["03","04"],
        "Glasgow":["01","02","03","04"]
        // "Sheffield":["02","03","04","05"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLengthOptions()
        
    }
    
    func getLengthOptions(){
        displayLabel("Choose Length")
        displayButtons(lengthOptions,nextFunction: "getAccentOptions:")
    }
    
    func getAccentOptions(sender: CustomButton){
        self.quizOptions.setLength(sender.currentTitle!)
        removeViews(1)
        displayLabel("Choose Accent")
        displayButtons(accentOptions, nextFunction:"getSpeakerOptions:",buttonX: 20,buttonY:160,buttonW:140,buttonH: 75)
    }
    
    func getSpeakerOptions(sender: CustomButton){
        self.quizOptions.setAccent(sender.currentTitle!)
        removeViews(1)
        displayLabel("Choose Speaker")
        displayButtons(speakerOptions[quizOptions.getQuizAccent()]!, nextFunction: "moveToQuestionView:")
    }
    
    func moveToQuestionView(sender:CustomButton){
        self.quizOptions.setSpeaker(sender.currentTitle!)
        if let resultController = storyboard!.instantiateViewControllerWithIdentifier("QuestionViewController") as? QuestionViewController {
            resultController.questionChoice = self.quizOptions
            presentViewController(resultController, animated: true, completion: nil)
        }
    }
    
    
    
    
}