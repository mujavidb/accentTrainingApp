//
//  QuestionSets.swift
//  accentTrainingApp
//
//  Created by HochinKazuma on 19/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation

class QuestionSet{
    let questionSet = [
        ["back","bark","beck","buck"],
        ["ban","barn","ben","bun"],
        ["hate","heat","height","hit"],
        ["lake","leak","lick","like"],
        ["wait","wheat","white","wit"]
    ]
    
    func getQuestionSet(index: Int) -> [String]{
        return questionSet[index]
    }
    
    func getAnswer(setIndex: Int, answerIndex:Int)->String{
        return questionSet[setIndex][answerIndex]
    }
    
}