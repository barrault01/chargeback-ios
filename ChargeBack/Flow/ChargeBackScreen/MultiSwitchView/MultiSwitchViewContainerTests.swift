//
//  MultiSwitchViewContainerTests.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 30/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import XCTest
@testable import ChargeBack

class MultiSwitchViewContainerTests: XCTestCase {

    func testForHeightFor0Reasons() {
        //given
        let numberOfReasons = 0
        let view = MultiSwitchViewContainer()
        //when
        let heightFor3Reasons = view.heightForView(for: numberOfReasons)
        //then
        XCTAssert(heightFor3Reasons == 0)
    }

    func testForHeightFor1Reasons() {
        //given
        let numberOfReasons = 1
        let view = MultiSwitchViewContainer()
        //when
        let heightFor3Reasons = view.heightForView(for: numberOfReasons)
        //then
        XCTAssert(heightFor3Reasons == 40)
    }

    func testForHeightFor3Reasons() {
        //given
        let numberOfReasons = 3
        let view = MultiSwitchViewContainer()
        //when
        let heightFor3Reasons = view.heightForView(for: numberOfReasons)
        //then
        XCTAssert(heightFor3Reasons == 120)
    }

}
