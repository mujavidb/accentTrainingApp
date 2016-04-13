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
            ["bed","bard","bad","bud"],
            ["beck","bark","back","buck"],
            ["ben","barn","ban","bun"],
            ["hem","harm","ham","hum"],
            ["kept","carped","capped","cupped"],
            ["mesh","marsh","mash","mush"],
            ["messed","mast","massed","must"],
            ["met","mart","mat","mutt"],
            ["peck","park","pack","puck"],
            ["pet","part","pat","putt"],
            
            ["feel","phil","file","fail"],
            ["field","filled","filed","failed"],
            ["feet","fit","fight","fate"],
            ["heat","hit","height","hate"],
            ["leak","lick","like","lake"],
            ["meal","mill","mile","mail"],
            ["meat","mitt","might","mate"],
            ["peel","pill","pile","pale"],
            ["sleet","slit","slight","slate"],
            ["wheat","wit","white","wait"],
        
            ["shoot","shout","shirt"],
            ["blues","blouse","blurs"],
            ["fool","foul","furl"],
            ["flute","flout","flirt"],
            ["wholl","howl","hurl"],
            ["cooed","cowed","curd"],
            ["cool","cowl","curl"],
            ["pooch","pouch","perch"],
            ["scoot","scout","skirt"],
            ["booed","bowed","bird"],

            ["fox","folks","forks"],
            ["cod","code","chord"],
            ["con","cone","corn"],
            ["cost","coast","coursed"],
            ["cot","coat","caught"],
            ["knot","note","naught"],
            ["pock","poke","pork"],
            ["rod","road","roared"],
            ["stock","stoke","stalk"],
            ["was","woes","wars"]
        
    ]
    
    func getQuestionSet(index: Int) -> [String]{
        return questionSet[index]
    }
    
    func getAnswer(setIndex: Int, answerIndex:Int)->String{
        return questionSet[setIndex][answerIndex]
    }
    
}