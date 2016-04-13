//
//  ResultsViewController.swift
//  accentTrainingApp
//
//  Created by Mujavid Bukhari on 13/04/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit

class ResultsViewController: CustomViewController {
	
	var result = 400
	let highscores: Int? = nil
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
	var trophyImage = UIImage()
	var trophyImageView = UIImageView()

	@IBOutlet weak var homeButton: CustomButton!
	
	@IBAction func replayButton(sender: AnyObject) {
		//go back to test selection in current mode (practice/time trial)
	}
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupInitialView()
		
		delay(3){
			self.setupHighscoresView()
		}
    }
	
	func setupInitialView() -> Void {
		self.view.backgroundColor = appColors["practice"]
		homeButton.setTitleColor(appColors["practice"], forState: .Normal)
		
		trophyImage = UIImage(named: "gold_trophy")!
		trophyImageView = UIImageView(image: trophyImage)
		trophyImageView.frame = CGRectMake(
			(CGFloat(viewWidth) - trophyImage.size.width) / 2,
			self.view.frame.height - (self.view.frame.height * 0.4),
			trophyImage.size.width,
			trophyImage.size.height
		)
		fadeInToSubview(trophyImageView, delay: 0.25, completionAction: nil)
		
		let scoresLabel = UILabel(frame: CGRect(
			x: self.view.frame.width * 0.1,
			y: self.view.frame.height * 0.38,
			width: self.view.frame.width * 0.8,
			height: self.view.frame.height * 0.2
		))
		
		scoresLabel.text = "\(result)"
		scoresLabel.textAlignment = .Center
		scoresLabel.textColor = appColors["white"]
		scoresLabel.font = UIFont(name: "Arial", size: CGFloat(viewWidth / 4.5))
		scoresLabel.tag = 1
		fadeInToSubview(scoresLabel, delay: 0.25, completionAction: nil)
		
		let scoresInfoLabel = UILabel(frame: CGRect(
			x: self.view.frame.width * 0.1,
			y: self.view.frame.height * 0.2,
			width: self.view.frame.width * 0.8,
			height: self.view.frame.height * 0.15
			))
		
		scoresInfoLabel.text = "Short Quiz \nRandom Accent"
		scoresInfoLabel.numberOfLines = 2
		scoresInfoLabel.textAlignment = .Center
		scoresInfoLabel.textColor = appColors["white"]
		scoresInfoLabel.font = UIFont(name: "Arial", size: CGFloat(viewWidth / 10))
		scoresInfoLabel.tag = 1
		fadeInToSubview(scoresInfoLabel, delay: 0.25, completionAction: nil)
		
	}
	
	func setupHighscoresView() -> Void {
		removeViews(1)
		
		let trophyReductionFactor: CGFloat = 0.6
		
		UIView.animateWithDuration(
			0.25,
			animations: {
				self.trophyImageView.frame = CGRectMake(
					(CGFloat(self.viewWidth) - (self.trophyImage.size.width * trophyReductionFactor)) / 2,
					self.view.frame.height - (self.view.frame.height * 0.2),
					self.trophyImage.size.width * trophyReductionFactor,
					self.trophyImage.size.height * trophyReductionFactor
				)
			},
			completion: nil
		)
		
		let highscoresLabel = UILabel(frame: CGRect(
			x: self.view.frame.width * 0.1,
			y: self.view.frame.height * 0.175,
			width: self.view.frame.width * 0.75,
			height: self.view.frame.height * 0.15
			))
		
		highscoresLabel.text = "Highscores"
		highscoresLabel.textAlignment = .Center
		highscoresLabel.textColor = appColors["white"]
		highscoresLabel.font = UIFont(name: "Arial", size: CGFloat(viewWidth / 10))
		fadeInToSubview(highscoresLabel, delay: 0.25, completionAction: nil)
		
		var counter = 0
		
		for name in scores {
			
			let label = UILabel(frame: CGRect(
				x: 40,
				y: Int(viewHeight * 0.325) + (counter * 30),
				width: Int(viewWidth * 0.5),
				height: 22
				))
			label.text = "\(name)"
			label.font = UIFont.systemFontOfSize(CGFloat(viewWidth / 16))
			label.textColor = UIColor.whiteColor()
			label.tag = 1
			fadeInToSubview(label, delay: 0.25 + (0.05 * Double(counter)), completionAction: nil)
			
			let number = UILabel(frame: CGRect(
				x: Int(viewWidth - 40 - (viewWidth * 0.2)),
				y: Int(viewHeight * 0.325) + (counter * 30),
				width: Int(viewWidth * 0.2),
				height: 22
				))
			number.text = "\(500 - counter * 50)"
			number.font = UIFont.systemFontOfSize(CGFloat(viewWidth / 16))
			number.textColor = UIColor.whiteColor()
			number.textAlignment = .Right
			number.tag = 1
			fadeInToSubview(number, delay: 0.25 + (0.05 * Double(counter)), completionAction: nil)
			counter += 1
		}
		
	}

}
