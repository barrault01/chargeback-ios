//
//  ChargebackRequesterTests.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 20/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import XCTest
@testable import ChargeBack

class ChargebackRequesterTests: XCTestCase {

    func testChargeBackParser() {

        let noticeRequester = ChargebackRequester(action: .chargeback)
        noticeRequester.completion = { chargeback in

            let comment = "Nos conte <strong>em detalhes</strong> o que aconteceu com a sua compra em Transaction..."
            XCTAssert(chargeback.comment == comment)
            XCTAssert(chargeback.id == "fraud")
            XCTAssert(chargeback.title == "Não reconheço esta compra")
            XCTAssert(chargeback.autoblock == true)
            XCTAssert(chargeback.actions.count ==  3)
            XCTAssert(chargeback.actions[0] ==  .card_unblock)
            XCTAssert(chargeback.actions[1] ==  .card_block)
            XCTAssert(chargeback.actions[2] ==  .chargeback)

            XCTAssert(chargeback.reasons.count ==  2)
            XCTAssert(chargeback.reasons[0].reasonId ==  "merchant_recognized")
            XCTAssert(chargeback.reasons[0].title ==  "Reconhece o estabelecimento?")
            XCTAssert(chargeback.reasons[1].reasonId ==  "card_in_possession")
            XCTAssert(chargeback.reasons[1].title ==  "Está com o cartão em mãos?")

        }
        noticeRequester.doGet(mockedFileName: "chargeback")
    }
}
