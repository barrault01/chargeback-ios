//
//  NoticeViewTests.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 24/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import XCTest
@testable import ChargeBack

class NoticeViewTests: XCTestCase {

    let noticeView = NoticeView()

    func testConfiguringNoticeView() {
        //given
        let firstAction = ActionInNotice(title: "Continue", action: "action_next")
        let secondAction = ActionInNotice(title: "Cancel", action: "action_cancel")
        let notice = Notice(title: "title",
                            description: "description",
                            primaryAction: firstAction,
                            secondaryAction: secondAction,
                            nextAction: .chargeback)

        //when
        noticeView.configure(with: notice)

        //then
        let title = noticeView.title.text
        XCTAssert(title == "title")
        let description = noticeView.textView.text
        XCTAssert(description == "description")
        let continueBtnText = noticeView.continueButton.titleLabel?.text
        XCTAssert(continueBtnText == firstAction.title.uppercased())
        let cancelButtonText = noticeView.cancelButton.titleLabel?.text
        XCTAssert(cancelButtonText == secondAction.title.uppercased())
    }

    func testClickOnFirstActionButton() {
        //given
        var clicked = false
        noticeView.clickOnFirstActionButton = {
            clicked = true
        }
        //when
        noticeView.didClickOnFirstAction(self.noticeView.continueButton)
        //then
        XCTAssert(clicked)
    }

    func testClickOnSecondActionButton() {
        //given
        var clicked = false
        noticeView.clickOnSecondActionButton = {
            clicked = true
        }
        //when
        noticeView.didClickOnSecondAction(self.noticeView.cancelButton)
        //then
        XCTAssert(clicked)
    }

}
