//
//  NoticeViewTests.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 24/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import XCTest
@testable import ChargeBack

func == (lhs: (String, String), rhs: (String, String)) -> Bool {
    return lhs.0 == rhs.0 && lhs.1 == rhs.1
}

func == (lhs: [(String, String)], rhs: [(String, String)]) -> Bool {

    let equal = zip(lhs, rhs).map {$0.0 == $0.1}.filter {$0 == true}
    return lhs.count == rhs.count && equal.count == lhs.count
}

class NoticeViewTests: XCTestCase {

    func testExtratingColorsWithOneColor() {

        let initialString = "Você pode <font color=\"#6e2b77\">procurar o nome do estabelecimento no Google</font>. "
        let result = initialString.extractColorList()
        let resultString = [("6e2b77", "customcolor1")]

        XCTAssert(resultString == result)

    }

    func testExtratingColorsWithMultiplesColors() {

        // swiftlint:disable:next line_length
        let initialString = "Você pode <font color=\"#6e2b77\">procurar o nome do estabelecimento no Google</font> <font color=\"#656b77\">procurar o nome do estabelecimento no Google</font> some other thing <font color=\"#789477\">procurar o nome do estabelecimento no Google</font> "
        let result = initialString.extractColorList()

        let resultString = [("6e2b77", "customcolor1"), ("656b77", "customcolor2"), ("789477", "customcolor3")]
        XCTAssertTrue(result.count == 3, "result is equal at \(result.count) should be 3")
        XCTAssert(resultString == result)

    }

    func testExtratingColorsWithMultiplesColorsWithRepeatedColors() {
        // swiftlint:disable:next line_length
        let initialString = "Você pode <font color=\"#6e2b77\">procurar o nome do estabelecimento no Google</font> <font color=\"#656b77\">procurar o nome do estabelecimento no Google</font> some other thing <font color=\"#656b77\">procurar o nome do estabelecimento no Google</font> "
        let result = initialString.extractColorList()

        let resultString = [("6e2b77", "customcolor1"), ("656b77", "customcolor2")]
        XCTAssertTrue(result.count == 2, "result is equal at \(result.count) should be 2")
        XCTAssert(resultString == result)
    }

    func testReplaceOneColor() {
        let initialString = "Você pode <font color=\"#6e2b77\">procurar o nome do estabelecimento no Google</font>. "
        let result = initialString.replace(color: ("6e2b77", "customcolor1"))
        let resultString = "Você pode <customcolor1>procurar o nome do estabelecimento no Google</customcolor1>. "
        XCTAssert(resultString == result)
    }

    func testReplactingAllColors() {
        // swiftlint:disable:next line_length
        let initialString = "Você pode <font color=\"#6e2b77\">procurar o nome do estabelecimento no Google</font> <font color=\"#656b77\">procurar o nome do estabelecimento no Google</font> some other thing <font color=\"#656b77\">procurar o nome do estabelecimento no Google</font> "

        let result = initialString.replaceColors()

        // swiftlint:disable:next line_length
        let resultString = "Você pode <customcolor1>procurar o nome do estabelecimento no Google</customcolor1> <customcolor2>procurar o nome do estabelecimento no Google</customcolor2> some other thing <customcolor2>procurar o nome do estabelecimento no Google</customcolor2> "

        XCTAssert(resultString == result)
    }

    func testReplactingAllColorsWithRepeatedColors() {
        // swiftlint:disable:next line_length
        let initialString = "Você pode <font color=\"#6e2b77\">procurar o nome do estabelecimento no Google</font> <font color=\"#656b77\">procurar o nome do estabelecimento no Google</font> some other thing <font color=\"#656b77\">procurar o nome do estabelecimento no Google</font> "

        let result = initialString.replaceColors()

        // swiftlint:disable:next line_length
        let resultString = "Você pode <customcolor1>procurar o nome do estabelecimento no Google</customcolor1> <customcolor2>procurar o nome do estabelecimento no Google</customcolor2> some other thing <customcolor2>procurar o nome do estabelecimento no Google</customcolor2> "

        XCTAssert(resultString == result)
    }
}
