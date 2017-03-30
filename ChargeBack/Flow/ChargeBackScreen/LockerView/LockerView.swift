//
//  LockerView.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 21/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit
import NibDesignable

class LockerView: NibDesignable {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = .nuTitle
        }
    }
    var clickOnLock: ((Void) -> Void)!
    var cardBlockState: CardBlockState? {
        didSet {
            guard let cardBlockState = cardBlockState else {
                return
            }
            switch cardBlockState {
            case .loading: updateForLoading()
            case .locked: updateForLocked()
            case .unlocked: updateForNotLocked()

            }
        }
    }
    @IBOutlet weak var lockerButton: UIButton!
    @IBOutlet weak var lockerImage: UIImageView!
    @IBAction func didClickOnLockerButton(_ sender: Any) {
        if let clickOnLock = clickOnLock {
            clickOnLock()
        }
    }

    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.text = ""
            messageLabel.textColor = .nuRed
        }
    }

    private func updateForLoading() {
        lockerButton.isEnabled = false
        lockerImage.image = nil
        activityIndicator.startAnimating()
        messageLabel.text = "Atualizando..."
    }

    private func updateForLocked() {
        lockerButton.isEnabled = true
        activityIndicator.stopAnimating()
        lockerImage.image = UIImage(named: "ic_chargeback_lock", in: ChargeBackInstance.bundle(), compatibleWith: nil)
        messageLabel.text = "Bloqueamos preventivamente o seu cartão"
    }

    private func updateForNotLocked() {
        lockerButton.isEnabled = true
        activityIndicator.stopAnimating()
        lockerImage.image = UIImage(named: "ic_chargeback_unlock", in: ChargeBackInstance.bundle(), compatibleWith: nil)
        messageLabel.text = "Cartão desbloqueado, recomendamos manté-lo bloqueado."

    }
}
