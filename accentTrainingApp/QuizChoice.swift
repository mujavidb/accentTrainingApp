//
//  QuizChoice.swift
//  neaterDifferent
//
//  Created by Mujavid Bukhari on 09/03/2016.
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
    func getQuizLengthInt()->Int{
        switch(self.quizLength!){
            case "Short (15)": return 15
            case "Medium (25)": return 25
            case "Long (40)" : return 40
        default: return 0
        }
    }
    
}