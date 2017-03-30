//
//  SwitchViewTests.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 30/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import XCTest
@testable import ChargeBack

class SwitchViewTests: XCTestCase {

    func testingUpdatingSwitchValueOn() {
        let switchView =  SwitchView()
        switchView.reasonId = "first_reason_id"
        switchView.updateSwitchValue = { isOn in
            XCTAssert(isOn.1 == true)
            XCTAssert(isOn.0 == "first_reason_id")
        }
        switchView.updateSwitchValue(isOn: true)
        XCTAssert(switchView.label.textColor == UIColor.nuGreen)
    }

    func testingUpdatingSwitchValueOff() {
        let switchView =  SwitchView()
        switchView.reasonId = "first_reason_id"
        switchView.updateSwitchValue = { isOn in
            XCTAssert(isOn.1 == false)
            XCTAssert(isOn.0 == "first_reason_id")
        }
        switchView.updateSwitchValue(isOn: false)
        XCTAssert(switchView.label.textColor == UIColor.nuText)
    }

}
