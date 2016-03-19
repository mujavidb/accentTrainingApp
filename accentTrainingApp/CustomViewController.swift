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
        self.view.backgroundColor = UIColor(red: 90/255, green: 158/255, blue: 1, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayButtons(buttonLabelSet: [String], nextFunction: Selector){
        displayButtons(buttonLabelSet, nextFunction: nextFunction,buttonX:20,buttonY:210,buttonW:140,buttonH:75)
    }
    
    func removeViews(tag: Int){
        for view in self.view.subviews{
            if view.tag == tag{
                view.removeFromSuperview()
            }
        }
    }
    
    func displayButtons(buttonLabelSet: [String], nextFunction: Selector,buttonX:Int, buttonY:Int,buttonW:Int, buttonH:Int){
        var counter = 0
        var posX: Int
        var posY: Int
        for label in buttonLabelSet{
            
            posX = buttonX+150*(counter%2)
            posY = buttonY+100*(counter/2)
            let customButton = CustomButton(frame: CGRect(x: posX, y: posY, width: buttonW, height:buttonH))
            customButton.setTitleColor(UIColor(red: 90/255, green: 158/255, blue: 1, alpha: 1), forState: .Normal)
            customButton.setTitle(label, forState: UIControlState.Normal)
            customButton.titleLabel!.font = UIFont(name: "Arial",size:23)
            customButton.addTarget(self, action: nextFunction, forControlEvents: .TouchUpInside)
            self.view.addSubview(customButton)
            customButton.tag = 1
            counter = counter + 1
        }
    }
    
    func displayLabel(title:String,posX:Int,posY:Int){
        let myLabel = UILabel(frame: CGRect(x:posX,y:posY,width:240,height:60))
        myLabel.text = title
        myLabel.font = UIFont.boldSystemFontOfSize(15)
        myLabel.font = UIFont.systemFontOfSize(25)
        myLabel.textColor = UIColor.whiteColor()
        myLabel.tag = 1
        self.view.addSubview(myLabel)
    }
    
    func displayLabel(title:String){
        displayLabel(title,posX:50,posY:70)
    }
}