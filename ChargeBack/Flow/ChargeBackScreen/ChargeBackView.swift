//
//  ChargeBackView.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 21/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit
import NibDesignable
import Atributika

enum CardBlockState {
    case locked, unlocked, loading
}

class ChargeBackView: NibDesignable {

    var clickedOnContinue: (([String: Bool]) -> Void)!
    var clickedOnCancel: ((Void) -> Void)!
    var updateText: ((String) -> Void)!
    var updateLocker: ((Void) -> Void)! {
        didSet {
            lockerView?.clickOnLock = updateLocker
        }
    }

    let heightForTitleConstant: CGFloat = 76.0
    var reasons: [String: Bool] = [String: Bool]()
    @IBOutlet weak var lockerView: LockerView! {
        didSet {
            lockerView.clickOnLock = updateLocker
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
            lockerView.addGestureRecognizer(tapRecognizer)
        }
    }
    @IBOutlet weak var heightForSwitchesConstraint: NSLayoutConstraint! {
        didSet {
            heightForSwitchesConstraint.constant = 0.0
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
    @IBOutlet weak var separatorBetweenSwitchesAndTitle: UIView! {
        didSet {
            separatorBetweenSwitchesAndTitle.backgroundColor = .nuDisabledGray
        }
    }
    @IBOutlet weak var switchesContainer: MultiSwitchViewContainer!
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
        clickedOnContinue(self.reasons)
    }

    @IBAction func didClickOnCancel(_ sender: Any) {
        self.endEditing(true)
        clickedOnCancel()
    }

    func changeCardBlockState(state: CardBlockState) {
         lockerView?.cardBlockState = state
    }

    func collapseView() {
        self.heightForSwitchesConstraint.constant = 0
    }

    func expandView() {
        self.heightForSwitchesConstraint.constant = self.switchesContainer.heightForView(for: self.reasons.values.count)
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
        placeholderTextInputView.attributedText = attributedStringForComment(string: data.comment)
        self.reasons = switchesContainer.configure(with: data.reasons, updateBlock: { reasonId, value in
                self.reasons[reasonId] = value
        })
        self.heightForSwitchesConstraint.constant = switchesContainer.heightForView(for: data.reasons.count)
    }

    func attributedStringForComment(string: String) -> NSAttributedString {

        let b = Style("strong").font(.boldSystemFont(ofSize: 14))
        let str = string.style(tags: b)
            .styleAll(Style.font(.systemFont(ofSize: 14)).foregroundColor(.nuHint))
            .attributedString
        return str

    }
}
