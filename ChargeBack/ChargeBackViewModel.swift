//
//  ChargeBackViewModel.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 21/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit
import PKHUD

class ChargeBackViewModel: ModelRequester {

    var continueBlock: ((Void) -> Void)!
    var result: ChargeBack? {
        didSet {
            if let result = result {
                if result.autoblock == true {
                    blockCard()
                }
            }
        }
    }

    var cardLockState: CardBlockState = .unlocked {
        didSet {
            self.modelView.changeCardBlockState(state: cardLockState)
        }
    }

    typealias Requester = ChargebackRequester
    typealias ViewForModel = ChargeBackView
    internal var modelView: ViewForModel

    required init(view: ViewForModel, dissmissMethod: @escaping ((Void) -> Void)) {
        modelView = view
        modelView.clickedOnContinue = goNextStep
        modelView.clickedOnCancel = dissmissMethod
        modelView.updateLocker = {
            if self.cardLockState == .locked {
                self.unlockCard()
            } else {
                self.blockCard()
            }

        }
    }

    func goNextStep(reasons: [(String, Bool)], message: String) {
        let req = ChargebackRequester(action: .chargeback)
        req.postCompletion = { sucess in
            DispatchQueue.main.async {
                HUD.hide()
                if sucess {
                    if let continueBlock = self.continueBlock {
                        continueBlock()
                    }
                }
            }
        }
        HUD.show(.progress)
        let _ = req.sendChargeBack(reasons: reasons, message: message)

    }

    func blockCard() {
        self.modelView.changeCardBlockState(state: .loading)
        let req = BlockUnBlockCardRequester(action: .card_block)
        req.postCompletion = { results in
            DispatchQueue.main.async {
                self.cardLockState = .locked
            }
        }
        let _ = req.doPost()
    }

    func unlockCard() {
        self.modelView.changeCardBlockState(state: .loading)
        let req = BlockUnBlockCardRequester(action: .card_unblock)
        req.postCompletion = { results in
            DispatchQueue.main.async {
            self.cardLockState = .unlocked
            }
        }
        let _ = req.doPost()
    }
}
