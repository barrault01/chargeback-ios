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

    var clickedOnContinue: (([(String, Bool)]) -> Void)!
    var clickedOnCancel: ((Void) -> Void)!
    var updateText: ((String) -> Void)!
    var updateLocker: ((Void) -> Void)! {
        didSet {
            lockerView?.clickOnLock = updateLocker
        }
    }

    let heightForTitleConstant: CGFloat = 76.0
    let heightForBlockAndSwitchConstant: CGFloat = 200.0

    @IBOutlet weak var lockerView: LockerView! {
        didSet {
            lockerView?.clickOnLock = updateLocker
        }
    }
    @IBOutlet weak var heightForBlockAndSwitchConstraint: NSLayoutConstraint! {
        didSet {
            heightForBlockAndSwitchConstraint.constant = heightForBlockAndSwitchConstant
        }
    }
    @IBOutlet weak var heightForTitleConstraint: NSLayoutConstraint! {
        didSet {
            heightForTitleConstraint.constant = heightForTitleConstant
        }
    }

    @IBOutlet weak var bottomOfScrollView: NSLayoutConstraint!

    @IBOutlet weak var title: UILabel! {
        didSet {
            title.textColor = .nuText
            title.text = "carregando".uppercased()
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
            title.addGestureRecognizer(tapRecognizer)
        }
    }

    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .nuViewBackground
        }
    }
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.backgroundColor = .nuBackground
        }
    }
    @IBOutlet weak var acceptButton: UIButton! {
        didSet {
            acceptButton.isEnabled = false
            acceptButton.tintColor = .nuBackground
            acceptButton.setTitleColor(.nuDisabledGray, for: .disabled)
        }
    }
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.tintColor = .nuCloseGray
        }
    }

    func changeCardBlockState(state: CardBlockState) {
         lockerView?.cardBlockState = state
    }

    @IBOutlet weak var separatorBetweenSwitchesAndTitle: UIView! {
        didSet {
            separatorBetweenSwitchesAndTitle.backgroundColor = .nuDisabledGray
        }
    }
    @IBOutlet weak var blockCardAndSwitchContainer: UIView!
    @IBOutlet weak var separatorBetweenTextInputAndSwitches: UIView! {
        didSet {
            separatorBetweenTextInputAndSwitches.backgroundColor = .nuDisabledGray
        }
    }
    @IBOutlet weak var textInputView: UITextView! {
        didSet {
            textInputView.delegate = self
            textInputView.isEditable = false
            textInputView.textColor = .nuText
        }
    }

    @IBOutlet weak var placeholderTextInputView: UITextView! {
        didSet {
            placeholderTextInputView.backgroundColor = .nuViewBackground
            placeholderTextInputView.textColor = .nuHint
        }
    }

    @IBAction func didClickOnContinueButton(_ sender: Any) {
        self.endEditing(true)
        clickedOnContinue([(String, Bool)]())
    }

    @IBAction func didClickOnCancel(_ sender: Any) {
        self.endEditing(true)
        clickedOnCancel()
    }

    func collapseView() {
        self.heightForBlockAndSwitchConstraint.constant = 40 + 12
    }

    func expandView() {
        self.heightForBlockAndSwitchConstraint.constant = heightForBlockAndSwitchConstant
    }

    func hidePlaceHolder(_ isHide: Bool) {
        self.textInputView.backgroundColor = isHide ? .nuViewBackground : .clear

    }
    func continueButton(isEnabled: Bool) {
        self.acceptButton.isEnabled = isEnabled
    }

}

extension ChargeBackView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let hidePlaceHolder = textView.text.characters.count > 0
        self.hidePlaceHolder(hidePlaceHolder)
        self.updateText(textView.text)
    }
}
extension ChargeBackView: ConfigurableView {

    typealias ConfigurableObject = ChargeBack

    func configure(with data: ChargeBack) {
        textInputView.isEditable = true
        title.text = data.title.uppercased()
        placeholderTextInputView.text = data.comment
    }
}
