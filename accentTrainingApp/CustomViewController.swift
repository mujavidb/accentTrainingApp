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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayButtons(buttonLabelSet: [String], nextFunction: Selector){
        displayButtons(
			buttonLabelSet,
			nextFunction: nextFunction,
			buttonX:0,
			buttonY:0,
			buttonW:0,
			buttonH:0
		)
    }
    
    func displayButtons(buttonLabelSet: [String], nextFunction: Selector, buttonX: Int, buttonY: Int,buttonW: Int, buttonH:Int){
		var posX: Int
		var posY: Int
		var counter = 0
		
		//select (x, y, width, height) based on actual view dimensions
		let viewHeight = Float(self.view.frame.height);
		let viewWidth = Float(self.view.frame.width);
		let gutterWidth: Float = 20;
		let buttonWidth: Float = (viewWidth - (3 * gutterWidth))/2
		
		//get 70% of height, remove gutter space and divide remaining area by 3
		let buttonHeight = (((viewHeight) * 0.75) - (4 * gutterWidth)) / 3
		print("viewHeight: \(viewHeight) viewWidth: \(viewWidth) gutterWidth: \(gutterWidth) buttonWidth: \(buttonWidth) buttonHeight: \(buttonHeight)")
		
        for label in buttonLabelSet {
            
            posX = Int(gutterWidth + (gutterWidth + buttonWidth) * Float(counter % 2))
            posY = Int((gutterWidth + buttonHeight) * Float( 1 + counter / 2))
			
            let customButton = CustomButton(
				frame: CGRect(x: posX, y: posY, width: Int(buttonWidth), height: Int(buttonHeight))
			)
			print("Buttons displayed \(counter): (\(posX), \(posY))")
            customButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            customButton.setTitle(label, forState: UIControlState.Normal)
            customButton.titleLabel!.font = UIFont(name: "Arial", size: 23)
            customButton.addTarget(self, action: nextFunction, forControlEvents: .TouchUpInside)
			customButton.backgroundColor = UIColor.redColor()
            self.view.addSubview(customButton)
            customButton.tag = 1
            counter = counter + 1
        }
    }
    
    func displayLabel(title:String, posX:Int, posY:Int){
        let myLabel = UILabel(frame: CGRect(x:posX,y:posY,width:240,height:60))
        myLabel.text = title
        myLabel.font = UIFont.boldSystemFontOfSize(15)
        myLabel.font = UIFont.systemFontOfSize(25)
        myLabel.textColor = UIColor.whiteColor()
        myLabel.tag = 1
        self.view.addSubview(myLabel)
    }
    
    func displayLabel(title:String){
        displayLabel(title, posX:50, posY:70)
    }
	
	func removeViews(tag: Int){
		self.view.subviews.forEach({ if $0.tag == tag { $0.removeFromSuperview(); }})
	}
}