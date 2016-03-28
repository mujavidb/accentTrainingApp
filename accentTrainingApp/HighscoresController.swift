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
				timetrialOption.backgroundColor = appColors["highscores"]
				timetrialOption.setTitleColor(appColors["white"], forState: .Normal)
			} else {
				practiceOption.backgroundColor = appColors["highscores"]
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
		practiceOption.frame = CGRect(x: viewWidth * 0.125 , y: viewHeight * 0.15, width: viewWidth * 0.35, height: 40)
		practiceOption.setTitle("Practice", forState: .Normal)
		practiceOption.backgroundColor = appColors["white"]
		practiceOption.setTitleColor(appColors["highscores"], forState: .Normal)
		
		timetrialOption.frame = CGRect(x: viewWidth * 0.525 , y: viewHeight * 0.15, width: viewWidth * 0.35, height: 40)
		timetrialOption.setTitle("Time Trial", forState: .Normal)
		timetrialOption.backgroundColor = appColors["highscores"]
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
			
			switch counter {
				case 0: labelBackground(counter)
				case 1: labelBackground(counter)
				case 2: labelBackground(counter)
				default: break
			}
			
			let label = UILabel(frame: CGRect(
				x: Int(viewWidth * 0.15) ,
				y: Int(viewHeight * 0.25) + (counter * 50),
				width: Int(viewWidth * 0.5),
				height: 40
				))
			label.text = "\(name)"
			label.font = UIFont.systemFontOfSize(CGFloat(viewWidth / 16))
			label.textColor = UIColor.whiteColor()
			label.tag = 1
			self.view.addSubview(label)
			
			let number = UILabel(frame: CGRect(
				x: Int(viewWidth * 0.65),
				y: Int(viewHeight * 0.25) + (counter * 50),
				width: Int(viewWidth * 0.2),
				height: 40
				))
			number.text = "\(500 - counter * 50)"
			number.font = UIFont.systemFontOfSize(CGFloat(viewWidth / 16))
			number.textColor = UIColor.whiteColor()
			number.textAlignment = .Right
			number.tag = 1
			self.view.addSubview(number)
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
			x: Int(self.view.frame.width * 0.125) ,
			y: Int(self.view.frame.height * 0.25) + (counter * 50),
			width: Int(self.view.frame.width * 0.75),
			height: 40
			))
		
		background.backgroundColor = trophyColor
		background.layer.cornerRadius = 10
		self.view.addSubview(background)
		
	}
}
