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

    let minimumExplicationSize = 5
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

    var explicationText: String = ""

    required init(view: ViewForModel, dissmissMethod: @escaping ((Void) -> Void)) {
        modelView = view
        modelView.clickedOnContinue = goNextStep
        modelView.updateText = { text in
            self.explicationText = text
            let continueIsOn = text.characters.count >= self.minimumExplicationSize
            self.modelView.continueButton(isEnabled: continueIsOn)
        }
        modelView.clickedOnCancel = dissmissMethod
        modelView.updateLocker = {
            if self.cardLockState == .locked {
                self.unlockCard()
            } else {
                self.blockCard()
            }
        }

        let selectorForShowingKeyboard = #selector(self.keyboardWasShown(notification:))
        let selectorForHiddingKeyboard = #selector(self.keyboardWasHide(notification:))
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector:selectorForShowingKeyboard ,
                           name:NSNotification.Name.UIKeyboardWillShow,
                           object: nil)
        center.addObserver(self,
                           selector: selectorForHiddingKeyboard ,
                           name:NSNotification.Name.UIKeyboardWillHide,
                           object: nil)

    }

    func goNextStep(reasons: [String: Bool]) {
        guard  explicationText.characters.count >= minimumExplicationSize else {
            return
        }
        let req = ChargebackRequester(action: .chargeback)
        req.postCompletion = { sucess, error in
            DispatchQueue.main.async {
                HUD.hide()
                if sucess {
                    if let continueBlock = self.continueBlock {
                        continueBlock()
                    }
                } else {
                    showErrorAlert(errorString: error)
                }
            }
        }
        HUD.show(.progress)
        let _ = req.sendChargeBack(reasons: reasons, message: explicationText)

    }

    func blockCard() {
        self.modelView.changeCardBlockState(state: .loading)
        let req = BlockUnBlockCardRequester(action: .card_block)
        req.postCompletion = { sucess, error in
            DispatchQueue.main.async {
                self.cardLockState = sucess ? .locked : .unlocked
            }
        }
        let _ = req.doPost()
    }

    func unlockCard() {
        self.modelView.changeCardBlockState(state: .loading)
        let req = BlockUnBlockCardRequester(action: .card_unblock)
        req.postCompletion = { sucess, error in
            DispatchQueue.main.async {
                self.cardLockState = sucess ? .unlocked : .locked
            }
        }
        let _ = req.doPost()
    }
}

extension ChargeBackViewModel: KeyboardShowAndHideProtocol {

    @objc func keyboardWasShown(notification: Notification) {

        guard let info = (notification as NSNotification).userInfo else { return }
        let frame = info[UIKeyboardFrameBeginUserInfoKey] as? NSValue
        guard let keyboardFrame: CGRect = frame?.cgRectValue else { return }
        guard let animationDurationObject = info[UIKeyboardAnimationDurationUserInfoKey] as? NSValue else { return }
        var animationDuration = 0.0

        animationDurationObject.getValue(&animationDuration)

        self.constraint().constant = keyboardFrame.size.height
        self.modelView.collapseView()
        UIView.animate(withDuration: animationDuration, animations: {
            self.viewToApplyAutoLayout().layoutIfNeeded()
        })
    }

    @objc func keyboardWasHide(notification: Notification) {
        self.constraint().constant =  0
        guard let info = (notification as NSNotification).userInfo else { return }
        if let animationDurationObject = info[UIKeyboardAnimationDurationUserInfoKey] as? NSValue {
            var animationDuration = 0.0
            animationDurationObject.getValue(&animationDuration)
            self.modelView.expandView()
            UIView.animate(withDuration: animationDuration, animations: {
                self.viewToApplyAutoLayout().layoutIfNeeded()
            })

        }
    }

    func constraint () -> NSLayoutConstraint {
        return self.modelView.bottomOfScrollView
    }

    func viewToApplyAutoLayout() -> UIView {
        return self.modelView
    }
}
