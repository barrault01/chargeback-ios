//
//  ChargeBackViewController.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 20/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit

class ChargeBackViewController: UIViewController, GoBackProtocol {

    @IBOutlet var theView: ChargeBackView!
    var action: ChargeBackAPI.Actions!
    var rootViewController: UIViewController!

    var nextSegueIdentifier: String {
        return Segue.presentResult.identifier!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }

    func configureViewModel() {
        let viewModel = ChargeBackViewModel(view: theView, dissmissMethod: quitChargeBackProcess)
        viewModel.configureAction(action: action)
        viewModel.continueBlock = presentResultScreen
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func presentResultScreen() {
        if let identifier = Segue.presentResult.identifier {
            self.performSegue(withIdentifier: identifier, sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue == Segue.presentResult {
            if let vc = segue.destination as? ResultViewController {
                vc.rootViewController = self.rootViewController
            }
        }
    }

}
