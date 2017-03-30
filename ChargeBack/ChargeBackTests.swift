//
//  ChargeBackTests.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 28/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import XCTest
@testable import ChargeBack

class ChargeBackTests: XCTestCase {

    var viewController: UIViewController!

    override func setUp() {
        super.setUp()
        self.viewController = UIViewController()
        UIApplication.shared.keyWindow!.rootViewController = viewController
        RunLoop.current.run(until: Date())
    }

    override func tearDown() {
        self.viewController = nil
        super.tearDown()
    }

    func testLoadingChargeBack() {

        let asyncExpectation = expectation(description: "presentingChargeBack")
        ChargeBackInstance.presentChargeBack(viewController: viewController) {
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: 5) { (_) in
            print("error")
        }
    }
}
