//
//  LoadingMockedJSONTests.swift
//  ChargeBackAPITests
//
//  Created by Antoine Barrault on 15/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import XCTest
@testable import ChargeBack

class LoadingMockedJSONTests: XCTestCase {

    let fileThatExisted = "entry"
    let fileThatNotExisted = "unknow"

    func testBundleLoading() {
        let value = ChargeBackInstance.bundle()
        XCTAssertNotNil(value)
    }

    func testPathForFileInBundle() {
        let value = Requester.pathForJsonFile(with: fileThatExisted)
        XCTAssertNotNil(value)
    }

    func testPathForFileInBundleFileWithFileThatNotExisted() {
        let value = Requester.pathForJsonFile(with: fileThatNotExisted)
        XCTAssertNil(value)
    }

    func testUrlForFileInBundle() {
        let value = Requester.urlForPathOfJsonFile(with: fileThatExisted)
        XCTAssertNotNil(value)
    }

    func testUrlForFileInBundleFileWithFileThatNotExisted() {
        let value = Requester.urlForPathOfJsonFile(with: fileThatNotExisted)
        XCTAssertNil(value)
    }

    func testDataFromJSONFile () {
        let value = Requester.mockedJSON(with: fileThatExisted)
        XCTAssertNotNil(value)
    }

    func testDataFromJSONFileWithFileThatNotExisted() {
        let value = Requester.mockedJSON(with: fileThatNotExisted)
        XCTAssertNil(value)
    }

    func testThatEntryJSONValidate() {
        validateFile(with: "entry")
    }

    func testThatNoticeJSONValidate() {
        validateFile(with: "notice")
    }

    func testThatChargeBackJSONValidate() {
        validateFile(with: "chargeback")
    }

    func validateFile(with name: String) {
        let value = Requester.mockedJSON(with: name)
        XCTAssertNotNil(value)
        let jsonResult = try? JSONSerialization.jsonObject(with: value!, options: .allowFragments)
        XCTAssertNotNil(jsonResult)

    }

}
