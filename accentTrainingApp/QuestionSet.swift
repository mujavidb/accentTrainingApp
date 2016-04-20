//
//  QuestionSets.swift
//  accentTrainingApp
//
//  Created by HochinKazuma on 19/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation

class QuestionSet{
    let r1 = [["bed","bard","bad","bud"],
              ["beck","bark","back","buck"],
              ["ben","barn","ban","bun"],
              ["hem","harm","ham","hum"],
              ["kept","carped","capped","cupped"],
              ["mesh","marsh","mash","mush"],
              ["messed","mast","massed","must"],
              ["met","mart","mat","mutt"],
              ["peck","park","pack","puck"],
              ["pet","part","pat","putt"]]
    let r2 = [["feel","fill","file","fail"],
              ["field","filled","filed","failed"],
              ["feet","fit","fight","fate"],
              ["heat","hit","height","hate"],
              ["leak","lick","like","lake"],
              ["meal","mill","mile","mail"],
              ["meat","mitt","might","mate"],
              ["peel","pill","pile","pale"],
              ["sleet","slit","slight","slate"],
              ["wheat","wit","white","wait"]]
    let r3 = [["shoot","shout","shirt"],
              ["blues","blouse","blurs"],
              ["fool","foul","furl"],
              ["flute","flout","flirt"],
              ["wholl","howl","hurl"],
              ["cooed","cowed","curd"],
              ["cool","cowl","curl"],
              ["pooch","pouch","perch"],
              ["scoot","scout","skirt"],
              ["booed","bowed","bird"]]
    let r4 = [["fox","folks","forks"],
              ["cod","code","chord"],
              ["con","cone","corn"],
              ["cost","coast","coursed"],
              ["cot","coat","caught"],
              ["knot","note","naught"],
              ["pock","poke","pork"],
              ["rod","road","roared"],
              ["stock","stoke","stalk"],
              ["was","woes","wars"]]
    
    func getQuestionSet(index: Int, rhymeSet: Int) -> [String]{
        switch rhymeSet {
        case 0: return r1[index]
        case 1: return r2[index]
        case 2: return r3[index]
        case 3: return r4[index]
        default:  print("either no valid rhymeset or index"); return []
        }
    }
    
    func getRhymeLength(rhymeSet: Int)-> Int{
        switch rhymeSet {
        case 0: return r1.count
        case 1: return r2.count
        case 2: return r3.count
        case 3: return r4.count
        default:  print("no valid rhyme set "); return 0
        }
    }

    func getAnswer(setIndex: Int, answerIndex:Int, rhymeSet: Int) -> String{
        var qset = getQuestionSet(setIndex, rhymeSet: rhymeSet)
        return qset[answerIndex]
    }

}