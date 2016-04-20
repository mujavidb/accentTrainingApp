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
        layer.cornerRadius = 10
    }
	
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
    }
}