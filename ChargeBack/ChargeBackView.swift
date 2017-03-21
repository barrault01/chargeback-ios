//
//  ChargeBackView.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 21/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit
import NibDesignable

enum CardBlockState {
    case locked, unlocked, loading
}

class ChargeBackView: NibDesignable {

    @IBOutlet weak var lockerView: LockerView! {
        didSet {
            lockerView?.clickOnLock = updateLocker
        }
    }
    var clickedOnContinue: (([(String, Bool)], String) -> Void)!
    var clickedOnCancel: ((Void) -> Void)!
    var updateLocker: ((Void) -> Void)! {
        didSet {
            lockerView?.clickOnLock = updateLocker
        }
    }

    @IBOutlet weak var title: UILabel! {
        didSet {
            title.textColor = UIColor.nuText
        }
    }
    @IBOutlet weak var heightForBlockAndSwitchConstraints: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = UIColor.nuViewBackground
        }
    }
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.backgroundColor = UIColor.nuBackground
        }
    }
    @IBOutlet weak var acceptButton: UIButton! {
        didSet {
            acceptButton.isEnabled = true
            acceptButton.tintColor = UIColor.nuBackground
            acceptButton.setTitleColor(UIColor.nuDisabledGray, for: .disabled)
        }
    }
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.tintColor = UIColor.nuCloseGray
        }
    }

    func changeCardBlockState(state: CardBlockState) {
         lockerView?.cardBlockState = state
    }

    @IBOutlet weak var separatorBetweenSwitchesAndTitle: UIView! {
        didSet {
            separatorBetweenSwitchesAndTitle.backgroundColor = UIColor.nuDisabledGray
        }
    }
    @IBOutlet weak var blockCardAndSwitchContainer: UIView!
    @IBOutlet weak var separatorBetweenTextInputAndSwitches: UIView! {
        didSet {
            separatorBetweenTextInputAndSwitches.backgroundColor = UIColor.nuDisabledGray
        }
    }
    @IBOutlet weak var textInputView: UITextView! {
        didSet {
            textInputView.textColor = UIColor.nuText
        }
    }

    @IBOutlet weak var placeholderTextInputView: UITextView! {
        didSet { placeholderTextInputView.textColor = UIColor.nuHint
        }
    }

    @IBAction func didClickOnContinueButton(_ sender: Any) {
        clickedOnContinue([(String, Bool)](), "")
    }

    @IBAction func didClickOnCancel(_ sender: Any) {
        clickedOnCancel()
    }
}

extension ChargeBackView: ConfigurableView {

    typealias ConfigurableObject = ChargeBack

    func configure(with data: ChargeBack) {
        title.text = data.title.uppercased()
        placeholderTextInputView.text = data.comment
    }
}
