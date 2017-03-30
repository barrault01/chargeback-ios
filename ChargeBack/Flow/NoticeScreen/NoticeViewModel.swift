//
//  NoticeViewModel.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 20/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit

class NoticeViewModel: ModelRequester {

    var continueBlock: ((ChargeBackAPI.Actions) -> Void)!
    var result: Notice?

    typealias Requester = NoticeRequester
    typealias ViewForModel = NoticeView
    internal var modelView: ViewForModel
    required init(view: ViewForModel, dissmissMethod: @escaping ((Void) -> Void)) {
        modelView = view
        modelView.clickOnFirstActionButton = goNextStep
        modelView.clickOnSecondActionButton = dissmissMethod
    }

    func goNextStep() {
        if let result = result {
            continueBlock(result.nextAction)
        }
    }
}
