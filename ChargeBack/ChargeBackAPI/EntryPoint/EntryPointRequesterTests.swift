//
//  EntryPointRequesterTests.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 16/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import XCTest
@testable import ChargeBack

class EntryPointRequesterTests: XCTestCase {

    func testEndpointRequester() {

        let noticeRequester = EntryPointRequester(action: .entry)
        noticeRequester.completion = { nextAction in
            XCTAssert(nextAction == .notice)
        }
        noticeRequester.doGet(mockedFileName: "entry")
    }
}
