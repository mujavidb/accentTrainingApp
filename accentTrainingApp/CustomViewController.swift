//
//  CustomViewController.swift
//  neaterDifferent
//
//  Created by HochinKazuma on 18/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation
import UIKit


class CustomViewController: UIViewController{
	
	let appColors = [
		"practice" : UIColor(red: 90/255, green: 160/255, blue: 1, alpha: 1),
		"timetrial" : UIColor(red: 180/255, green: 110/255, blue: 210/255, alpha: 1),
		"highscores": UIColor(red: 240/255, green: 190/255, blue: 10/255, alpha: 1),
		
		"white": UIColor.whiteColor(),
		"darkGrey": UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1),
		"lightGrey": UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1),
		"incorrectRed": UIColor(red: 225/255, green: 75/255, blue: 95/255, alpha: 1),
		"correctGreen": UIColor(red: 100/255, green: 225/255, blue: 140/255, alpha: 1),
		"timetrialLight": UIColor(red: 215/255, green: 190/255, blue: 230/255, alpha: 1),
		
		"gold": UIColor(red: 255/255, green: 210/255, blue: 0/255, alpha: 1),
		"silver": UIColor(red: 210/255, green: 210/255, blue: 200/255, alpha: 1),
		"bronze": UIColor(red: 210/255, green: 110/255, blue: 15/255, alpha: 1),
		"transparent": UIColor(red: 1, green: 1, blue: 1, alpha: 0),
		"transparent_white": UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
		]
	
	var viewWidth: Double = 500
	var viewHeight: Double = 500
	
    override func viewDidLoad() {
        super.viewDidLoad()
		viewWidth = Double(self.view.frame.width)
		viewHeight = Double(self.view.frame.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func displayLabel(title:String, textColor: UIColor){
        let myLabel = UILabel(frame: CGRect(
			x: Int(self.view.frame.width * 0.1),
			y: 70,
			width: Int(self.view.frame.width * 0.8),
			height: 60
			))
        myLabel.text = title
		myLabel.textAlignment = .Center
        myLabel.font = UIFont.mainFontOfSize(25)
        myLabel.textColor = UIColor.whiteColor()
        myLabel.tag = 1
        self.view.addSubview(myLabel)
    }
    
	//delay function - http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift
	func delay(time:Double, closure:() -> Void) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(time * Double(NSEC_PER_SEC))),dispatch_get_main_queue(), closure)
	}
	
	//fades views out
	func removeViews(tag: Int){
		var viewsToFade = [UIView]()
		self.view.subviews.forEach({ if $0.tag == tag { viewsToFade.append($0) }})
		UIView.animateWithDuration(
			0.25,
			animations: {
				viewsToFade.forEach({ $0.alpha = 0 })
			},
			completion: {
				(finished: Bool) -> Void in
				
				self.delay(0.25){
					viewsToFade.forEach({ $0.removeFromSuperview() })
				}
		})
	}
	
	//fade in from button
	func fadeUpInToSubview(target: UIView, delay: Double, completionAction: ((Bool) -> Void)?){
		target.alpha = 0
		target.frame.origin.y += CGFloat(viewHeight * 0.1)
		self.view.addSubview(target)
		UIView.animateWithDuration(
			delay,
			animations: {
				target.alpha = 1
				target.frame.origin.y -= CGFloat(self.viewHeight * 0.1)
			},
			completion: completionAction
		)
	}
	
	////fade in from centre
	func fadeCentreInToSubview(target: UIView, delay: Double, completionAction: ((Bool) -> Void)?){
		let currentFrame = target.frame
		target.alpha = 0
		target.frame = CGRect(
			x: currentFrame.origin.x + (currentFrame.origin.x * 0.25),
			y: currentFrame.origin.y + (currentFrame.origin.y * 0.25),
			width: currentFrame.width * 0.5,
			height: currentFrame.height * 0.5
		)
		self.view.addSubview(target)
		UIView.animateWithDuration(
			delay,
			animations: {
				target.alpha = 1
				target.frame = currentFrame
			},
			completion: completionAction
		)
	}
	
	//hides status bar
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
}