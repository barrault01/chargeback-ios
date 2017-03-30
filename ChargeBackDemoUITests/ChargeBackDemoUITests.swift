//
//  ChargeBackDemoUITests.swift
//  ChargeBackDemoUITests
//
//  Created by Antoine Barrault on 22/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import XCTest

class ChargeBackDemoUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        app.launchEnvironment["stub_endpoints"] = "true"
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        app.terminate()
    }
    func testShowingFirstScreenAndClose() {
        app.buttons["ChargeBack"].tap()
        app.buttons["FECHAR"].tap()

    }

    func testFullFlux() {
        app.buttons["ChargeBack"].tap()
        app.buttons["CONTINUAR"].tap()
    }

}
