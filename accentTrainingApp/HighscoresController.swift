//
//  HighscoresController.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 26/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit

class HighscoresController: CustomViewController {
	
	let practiceOption = UIButton()
	let timetrialOption = UIButton()
	let scores = [
		"Mujavid",
		"Freddie Merc.",
		"Led",
		"M",
		"Efumi",
		"Jess",
		"Beccs",
		"Muhammad"
	]
	var current = "practice" {
		//observer design pattern
		didSet {
			if current == "practice" {
				practiceOption.backgroundColor = appColors["white"]
				practiceOption.setTitleColor(appColors["highscores"], forState: .Normal)
				timetrialOption.backgroundColor = appColors["transparent_white"]
				timetrialOption.setTitleColor(appColors["white"], forState: .Normal)
			} else {
				practiceOption.backgroundColor = appColors["transparent_white"]
				practiceOption.setTitleColor(appColors["white"], forState: .Normal)
				timetrialOption.backgroundColor = appColors["white"]
				timetrialOption.setTitleColor(appColors["highscores"], forState: .Normal)
			}
			
			//TODO: Some code to update the model with other scores
			//TODO: Then update scores
			removeViews(1)
			displayScores(scores)
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.view.backgroundColor = appColors["highscores"]
		displayScoreListSelector()
		displayScores(scores)
		
    }
	
	func displayScoreListSelector(){
		let buttonWidth = (viewWidth * 0.5) - 20
		practiceOption.frame = CGRect(
			x: 20,
			y: viewHeight * 0.15,
			width: buttonWidth,
			height: 40
		)
		practiceOption.setTitle("Practice", forState: .Normal)
		practiceOption.backgroundColor = appColors["white"]
		practiceOption.setTitleColor(appColors["highscores"], forState: .Normal)
		
		timetrialOption.frame = CGRect(
			x: viewWidth - 20 - buttonWidth,
			y: viewHeight * 0.15,
			width: buttonWidth,
			height: 40
		)
		timetrialOption.setTitle("Time Trial", forState: .Normal)
		timetrialOption.backgroundColor = appColors["transparent_white"]
		timetrialOption.setTitleColor(appColors["white"], forState: .Normal)
		
		for b in [practiceOption, timetrialOption] {
			b.titleLabel?.font = UIFont.boldSystemFontOfSize(CGFloat(self.view.frame.width / 14))
			b.titleLabel?.textAlignment = .Center
			b.layer.cornerRadius = 6
			b.addTarget(self, action: #selector(HighscoresController.changeCurrentHighScores), forControlEvents: .TouchUpInside)
		}
		
		self.view.addSubview(practiceOption)
		self.view.addSubview(timetrialOption)
	}
	
	func changeCurrentHighScores(){
		if current == "practice" {
			current = "Time Trial"
		} else {
			current = "practice"
		}
	}
	
	func displayScores(scores: Array<String>){
		
		var counter = 0
		
		for name in scores {
			
			if counter < 3 {
				labelBackground(counter)
			}
			
			let label = UILabel(frame: CGRect(
				x: 40,
				y: Int(viewHeight * 0.25) + (counter * 50),
				width: Int(viewWidth * 0.5),
				height: 40
				))
			label.text = "\(name)"
			label.font = UIFont.systemFontOfSize(CGFloat(viewWidth / 16))
			label.textColor = UIColor.whiteColor()
			label.tag = 1
			fadeInToSubview(label, delay: 0.3 + (0.05 * Double(counter)), completionAction: nil)
			
			let number = UILabel(frame: CGRect(
				x: Int(viewWidth - 40 - (viewWidth * 0.2)),
				y: Int(viewHeight * 0.25) + (counter * 50),
				width: Int(viewWidth * 0.2),
				height: 40
				))
			number.text = "\(500 - counter * 50)"
			number.font = UIFont.systemFontOfSize(CGFloat(viewWidth / 16))
			number.textColor = UIColor.whiteColor()
			number.textAlignment = .Right
			number.tag = 1
			fadeInToSubview(number, delay: 0.3 + (0.05 * Double(counter)), completionAction: nil)
			counter += 1
		}
	}
	
	func labelBackground(counter: Int){
		
		var trophyColor = appColors["highscores"]
		
		switch counter {
		case 0: trophyColor = appColors["gold"]!
		case 1: trophyColor = appColors["silver"]!
		case 2: trophyColor = appColors["bronze"]!
		default: break
		}
		
		let background = UIView(frame: CGRect(
			x: 20,
			y: Int(viewHeight * 0.25) + (counter * 50),
			width: Int(viewWidth - 40),
			height: 40
			))
		
		background.backgroundColor = trophyColor
		background.layer.cornerRadius = 10
		background.tag = 1

		fadeInToSubview(background, delay: 0.3 + (0.05 * Double(counter)), completionAction: nil)
	}
}
