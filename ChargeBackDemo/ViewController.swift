//
//  ViewController.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 15/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit
import ChargeBack

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickOnChargeBack(_ sender: UIButton) {
        ChargeBackInstance.presentChargeBack(viewController: self)
    }

}
