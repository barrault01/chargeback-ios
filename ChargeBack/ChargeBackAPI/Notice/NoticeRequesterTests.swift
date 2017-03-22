//
//  NoticeRequesterTests.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 20/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

import XCTest
@testable import ChargeBack

class NoticeRequesterTests: XCTestCase {

    func testNoticeParser() {

        let noticeRequester = NoticeRequester(action: .notice)
        noticeRequester.completion = { notice in

            XCTAssert(notice.title == "Antes de continuar")
            let noticeDescription = "<p>Estamos com você nesta! Certifique-se dos pontos abaixo, são muito importantes:<br/><strong>• Você pode <font color=\"#6e2b77\">procurar o nome do estabelecimento no Google</font>. Diversas vezes encontramos informações valiosas por lá e elas podem te ajudar neste processo.</strong><br/><strong>• Caso você reconheça a compra, é muito importante pra nós que entre em contato com o estabelecimento e certifique-se que a situação já não foi resolvida.</strong></p>"
            // swiftlint:disable:previous line_length
            XCTAssert(notice.description == noticeDescription)
            XCTAssert(notice.nextAction == .chargeback)
            XCTAssert(notice.primaryAction.action == "continue")
            XCTAssert(notice.primaryAction.title == "Continuar")
            XCTAssert(notice.secondaryAction.action == "cancel")
            XCTAssert(notice.secondaryAction.title == "Fechar")

        }
        noticeRequester.doGet(mockedFileName: "notice")

    }
}
