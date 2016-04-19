//
//  QuestionViewContollerTest.swift
//  accentTrainingApp
//
//  Created by HochinKazuma on 15/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import XCTest
@testable import accentTrainingApp
import AVFoundation

class QuestionViewContollerTest: XCTestCase {
    
    let qv = QuestionViewController()
    let qs = QuestionSet()
    
    let accentOptions = ["London","US","Manchester","NewZealand","Australia","Glasgow"]
    let speakerOptions = [
        "London" : ["Anna","Chloe","John","Matthew"],
        "US" : ["Katie","Vinny","Sharon","Clare"],
        "Manchester":["Alex","Olivia","Sam"],
        "NewZealand": ["Richard","Ruby","Jack"],
        "Australia": ["Shane","Marlee"],
        "Glasgow":["Steward","Laura","Robert","Anna"]
    ]
    
    func audioreturn(){
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("", ofType: "mp3")!)
        print(url)
    }
    
    func testAudioExists(){
        for accent in accentOptions{
            for speaker in speakerOptions[accent]!{
                for rhymes in [qs.r1,qs.r2,qs.r3,qs.r4]{
                    for wordset in rhymes{
                        for word in wordset{
                            let fileName = "\(accent)_\(speaker)_\(word)"
                            XCTAssertNotNil(NSDataAsset(name: fileName), "no audio: \(fileName)")
                        }
                    }
                }
            }
        }
        
    }
    
    
}
