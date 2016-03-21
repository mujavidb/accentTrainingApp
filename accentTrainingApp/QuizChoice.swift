//
//  QuizChoice.swift
//  neaterDifferent
//
//  Created by HochinKazuma on 18/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation

class QuizChoice {
    
    var quizType: String?
    var quizLength: String?
    var quizAccent: String?
    var quizSpeaker: String?
    
    //setter
    
    func setType(type: String){
        self.quizType = type
    }
    
    func setSpeaker(name: String){
        self.quizSpeaker = name
    }
    
    func setAccent(accent: String){
        self.quizAccent = accent
    }
    
    func setLength(length: String){
        self.quizLength = length
    }
    
    //getter
    
    func getQuizType() -> String{
        return self.quizType!
    }
    func getQuizLength()-> String{
        return self.quizLength!
    }
    func getQuizSpeaker()-> String{
        return self.quizSpeaker!
    }
    func getQuizAccent()-> String{
        return self.quizAccent!
    }
    
    
}