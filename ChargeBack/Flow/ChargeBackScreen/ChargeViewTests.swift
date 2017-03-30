//
//  ChargeViewTests.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 28/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import XCTest
@testable import ChargeBack

class ChargeViewTests: XCTestCase {

    let chargeBackView = ChargeBackView()
    var viewModel: ChargeBackViewModel?

    override func setUp() {
        viewModel = ChargeBackViewModel(view: chargeBackView, dissmissMethod: { (_) in

        })
    }

    func fakeChargeBack() -> ChargeBack {
        var reasons = [Reason]()
        let reason1 = Reason(reasonId: "reason_id_1", title: "reason_title_1")
        let reason2 = Reason(reasonId: "reason_id_2", title: "reason_title_2")
        reasons.append(reason1)
        reasons.append(reason2)
        // swiftlint:disable:next syntactic_sugar
        let actions: [ChargeBackAPI.Actions] = Array<ChargeBackAPI.Actions>()
        let chargeBack = ChargeBack(comment: "comment",
                                    id: "charge_back_id",
                                    title: "title",
                                    autoblock: true,
                                    reasons: reasons,
                                    actions: actions)
        return chargeBack
    }

    func testConfiguringNoticeView() {
        //given
        let chargeBack = fakeChargeBack()

        //when
        chargeBackView.configure(with: chargeBack)

        //then
        let title = chargeBackView.title.text
        XCTAssert(title == "TITLE")
        let description = chargeBackView.placeholderTextInputView.text
        XCTAssert(description == "comment")

        let continueBtnText = chargeBackView.acceptButton.titleLabel?.text
        XCTAssert(continueBtnText == "CONTESTAR")
        let cancelButtonText = chargeBackView.cancelButton.titleLabel?.text
        XCTAssert(cancelButtonText == "CANCELAR")
    }

    func verifyIfLockerViewIsCorrect(blockState: CardBlockState, lockTextToCompare: String, imageLocker: UIImage?) {
        let lockState = chargeBackView.lockerView.cardBlockState
        XCTAssertNotNil(lockState)
        XCTAssert(blockState == lockState)

        let lockText = chargeBackView.lockerView.messageLabel.text
        XCTAssert(lockTextToCompare == lockText)

        let lockImage = chargeBackView.lockerView.lockerImage.image
        XCTAssert(imageLocker == lockImage)

    }
    func testChangingLockerWhenIsLock() {

        //given
        let blockState: CardBlockState = .locked
        let lockTextToCompare = "Bloqueamos preventivamente o seu cartão"
        let imageLocker = UIImage(named: "ic_chargeback_lock", in: ChargeBackInstance.bundle(), compatibleWith: nil)
        //when
        chargeBackView.changeCardBlockState(state: blockState)
        //then
        verifyIfLockerViewIsCorrect(blockState: blockState,
                                    lockTextToCompare: lockTextToCompare,
                                    imageLocker: imageLocker)
    }

    func testChangingLockerWhenIsUnLock() {

        //given
        let blockState: CardBlockState = .unlocked
        let lockTextToCompare = "Cartão desbloqueado, recomendamos manté-lo bloqueado."
        let imageLocker = UIImage(named: "ic_chargeback_unlock", in: ChargeBackInstance.bundle(), compatibleWith: nil)
        //when
        chargeBackView.changeCardBlockState(state: blockState)
        //then
        verifyIfLockerViewIsCorrect(blockState: blockState,
                                    lockTextToCompare: lockTextToCompare,
                                    imageLocker: imageLocker)
    }

    func testChangingLockerWhenIsLoading() {

        //given
        let blockState: CardBlockState = .loading

        //when
        chargeBackView.changeCardBlockState(state: blockState)
        //then
        let lockState = chargeBackView.lockerView.cardBlockState
        XCTAssertNotNil(lockState)
        XCTAssert(blockState == lockState)
    }

    func testThatContinueButtonIsDisabledWithTest() {
        //given
        var textEntered = ""
        chargeBackView.updateText = { text in
            textEntered = text
        }

        //when
        chargeBackView.textInputView.insertText("")

        //then
        XCTAssert(chargeBackView.acceptButton.isEnabled == false)
        XCTAssert(textEntered == "")
        XCTAssert(self.chargeBackView.textInputView.backgroundColor == .clear)
    }

    func testThatContinueButtonIsEnabledIfWePutText() {
        //given

        //when
        chargeBackView.textInputView.insertText("inserted text")

        //then
        XCTAssert(chargeBackView.acceptButton.isEnabled)
        XCTAssert(viewModel?.explicationText == "inserted text")
        XCTAssert(self.chargeBackView.textInputView.backgroundColor != .clear)
    }

    func testClickOnFirstActionButton() {
        //given
        var clicked = false
        chargeBackView.clickedOnContinue = { _ in
            clicked = true
        }
        //when
        self.chargeBackView.acceptButton.sendActions(for: .touchUpInside)
        //then
        XCTAssert(clicked)
    }

    func testClickOnSecondActionButton() {
        //given
        var clicked = false
        chargeBackView.clickedOnCancel = {
            clicked = true
        }
        //when
        self.chargeBackView.cancelButton.sendActions(for: .touchUpInside)
        //then
        XCTAssert(clicked)
    }

    func testConstraintForSwitchesViewWhenCollapse() {

        //given
        let chargeBack = fakeChargeBack()
        chargeBackView.configure(with: chargeBack)
        //when
        chargeBackView.collapseView()
        //then
        XCTAssert(chargeBackView.heightForSwitchesConstraint.constant == 0)
    }

    func testConstraintForSwitchesViewWhenExpand() {

        //given
        let chargeBack = fakeChargeBack()
        let exeptedHeight: CGFloat = 40.0 * CGFloat(chargeBack.reasons.count)
        chargeBackView.configure(with: chargeBack)
        //when
        chargeBackView.expandView()
        //then
        XCTAssert(chargeBackView.heightForSwitchesConstraint.constant == exeptedHeight)

    }

}
