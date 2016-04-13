//
//  QuestionGenerator.swift
//  neaterDifferent
//
//  Created by HochinKazuma on 18/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation


class QuestionGenerator{
    let quizChoice: QuizChoice?
    let qs = QuestionSet()
    var askedQuestions = [(Int,Int)]() // (rhyme index, question set index)
    var rhyme1 = 1 // probability of each rhyme being asked
    var rhyme2 = 1
    var rhyme3 = 1
    var rhyme4 = 1
    
    var answer: String?
    var rhymeSetIndex: Int?
    var questionSetIndex: Int? //which set ie. back, bark set = 0
    var answerIndex: Int? // index of answer ie. beck = 2
    
    init(completQuizChoice: QuizChoice){
        self.quizChoice = completQuizChoice
    }
    
    func checkAnswered(index: Int)->Bool{
        for (rhymeIndex,askedIndex) in askedQuestions{
            if index == askedIndex && rhyme == rhymeSetIndex{
                return true
            }
        }
        return false
    }
    func generateQuestion(){
        
        rhymeSetIndex = randomNumber(probabilities: [rhyme1, rhyme2,rhyme3,rhyme4])
        
        repeat{questionSetIndex = Int(arc4random_uniform(UInt32(qs.questionSet[rhymeSetIndex].count)))}
            while(checkAnswered(questionSetIndex!))
        
        askedQuestions.append((rhymeSetIndex,questionSetIndex!))
        
        answerIndex = Int(arc4random_uniform(UInt32(qs.getQuestionSet(rhymeSetIndex, index: questionSetIndex!).count)))
        
        answer = qs.getAnswer(rhymeSetIndex, setIndex: questionSetIndex!,answerIndex:  answerIndex!)
    }
    
    func getQuestionFileName()->String{ // returns the name of the file in the format: london_anna_back
        let accent = quizChoice!.getQuizAccent()
        let speakerName = quizChoice!.getQuizSpeaker()
        return "\(accent)_\(speakerName)_\(answer!)"
    }
    
    func getQuestionSet() -> [String] {
        return qs.getQuestionSet(rhymeSetIndex, index: questionSetIndex!)
    }
    
    func getAnswer()-> String {
        return answer!
    }
    
    func randomNumber(probabilities probabilities: [Double]) -> Int {
        let sum = probabilities.reduce(0, combine: +)
        let rand = sum * Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
        var accum = 0.0
        for (i, p) in probabilities.enumerate() {
            accum += p
            if rand < accum {
                return i
            }
        }
        return (probabilities.count - 1)
    }
    
    
}