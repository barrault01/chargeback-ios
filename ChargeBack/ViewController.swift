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
        loadChargeBack(viewController: self)
    }

}

func loadChargeBack(viewController: UIViewController) {

    HUD.show(.progress)
    let navigationCtrl = Storyboards.ChargeBack.instantiateInitialViewController()
    if let chargeBack = navigationCtrl.viewControllers.first as? NoticeViewController {
        let entryPoint = EntryPointRequester(action: .entry)
        entryPoint.completion = { action in
            chargeBack.action = action
            chargeBack.rootViewController = viewController
            DispatchQueue.main.async {
                HUD.hide()
                viewController.present(chargeBack, animated: true, completion: nil)
            }
        }
        let _ = entryPoint.doGet()
    }

}
