//
//  ViewController.swift
//  neaterDifferent
//
//  Created by HochinKazuma on 18/03/2016.
//  Copyright © 2016 k. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.whiteColor()
    }
    
	//allows moving back to MainVC
	@IBAction func unwindToMVC(segue: UIStoryboardSegue){}
}

