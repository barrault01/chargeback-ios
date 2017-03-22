//
//  ResultViewController.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 21/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, GoBackProtocol {

    @IBOutlet var theView: ResultView!
    var action: ChargeBackAPI.Actions!
    var rootViewController: UIViewController!

    var nextSegueIdentifier: String {
        return ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }

    func configureViewModel() {
        let viewModel = ResultViewModel(view: theView, dissmissMethod: quitChargeBackProcess)
        viewModel.configureAction(action: .notice)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
