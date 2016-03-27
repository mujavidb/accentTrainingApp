//
//  HighscoresController.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 26/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit

class HighscoresController: CustomViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.view.backgroundColor = appColors["highscores"]
		
		let scores = [
			"Mujavid",
			"Freddie Merc.",
			"Led",
			"M",
			"Efumiiii",
			"Jess",
			"Beccs",
			"Muhammad"
		]
		
		displayScores(scores)
		
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
			y: Int(self.view.frame.height * 0.15) + (counter * 50),
			width: Int(self.view.frame.width * 0.75),
			height: 40
			))
		
		background.backgroundColor = trophyColor
		background.layer.cornerRadius = 10
		self.view.addSubview(background)
		
	}
	
	func displayScores(scores: Array<String>){
		
		var counter = 0
		let viewWidth = self.view.frame.width
		let viewHeight = self.view.frame.height
		
		for name in scores {
			
			switch counter {
				case 0: labelBackground(counter)
				case 1: labelBackground(counter)
				case 2: labelBackground(counter)
				default: break
			}
			
			let label = UILabel(frame: CGRect(
				x: Int(viewWidth * 0.15) ,
				y: Int(viewHeight * 0.15) + (counter * 50),
				width: Int(viewWidth * 0.5),
				height: 40
				))
			label.text = "\(counter + 1). \(name)"
			label.font = UIFont.systemFontOfSize(CGFloat(viewWidth / 16))
			label.textColor = UIColor.whiteColor()
			label.tag = 1
			self.view.addSubview(label)
			
			let number = UILabel(frame: CGRect(
				x: Int(viewWidth * 0.65),
				y: Int(viewHeight * 0.15) + (counter * 50),
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
}
