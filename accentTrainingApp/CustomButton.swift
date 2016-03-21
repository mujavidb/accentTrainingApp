//
//  CustomButton.swift
//  neaterDifferent
//
//  Created by HochinKazuma on 18/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
	
	init(){
        super.init(frame: CGRectZero)
        setUp()
    }
	
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
	
    func setUp(){
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(red: 90/255, green: 158/255, blue: 1, alpha: 1)
        self.tintColor = UIColor.whiteColor()
    }
}