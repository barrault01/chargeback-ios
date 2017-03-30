//
//  ChargeBack.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 22/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit
import PKHUD

public struct ChargeBackInstance {

    public static func presentChargeBack(viewController: UIViewController, onComplete: ((Void) -> Void)? = nil) {

        DispatchQueue.main.async {
            HUD.show(.progress)
            let navigationCtrl = Storyboards.ChargeBack.instantiateInitialViewController()
            if let chargeBack = navigationCtrl.viewControllers.first as? NoticeViewController {
                let entryPoint = EntryPointRequester(action: .entry)
                entryPoint.completion = { action, errorString in
                    guard let action = action else {
                        showErrorAlert(errorString: errorString)
                        return
                    }
                    chargeBack.action = action
                    chargeBack.rootViewController = viewController
                    DispatchQueue.main.async {
                        HUD.hide()
                        viewController.present(chargeBack, animated: false) {
                            if let onComplete = onComplete {
                                onComplete()
                            }
                        }
                    }
                }
                entryPoint.doGet()
            }
        }
    }

    static func bundle() -> Bundle {
        let bundle = Bundle(for: ChargebackRequester.self)
        return bundle
    }

}

func showErrorAlert(errorString: String?) {

    DispatchQueue.main.async {
        let string = errorString ?? "Alguma coisa deu errado"
        HUD.show(.labeledError(title: nil, subtitle: string))
        PKHUD.sharedHUD.hide(afterDelay: 2.0)
    }

}
