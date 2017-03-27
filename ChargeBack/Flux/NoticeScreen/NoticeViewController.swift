//
//  NoticeViewController.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 20/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController, GoBackProtocol {

    @IBOutlet var theView: NoticeView!
    var action: ChargeBackAPI.Actions!
    var rootViewController: UIViewController!

    var nextSegueIdentifier: String {
        return Segue.presentChargeBack.identifier!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }

    func configureViewModel() {
        let viewModel = NoticeViewModel(view: theView, dissmissMethod: quitChargeBackProcess)
        viewModel.continueBlock = presentChargeBack
        viewModel.configureAction(action: .notice)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func presentChargeBack(nextAction: ChargeBackAPI.Actions) {
        if let identifier = Segue.presentChargeBack.identifier {
            self.performSegue(withIdentifier: identifier, sender: nextAction)
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue == Segue.presentChargeBack {
            if let vc = segue.destination as? ChargeBackViewController,
                let nextAction = sender as? ChargeBackAPI.Actions {
                vc.rootViewController = self.rootViewController
                vc.action = nextAction
            }
        }
    }
}
