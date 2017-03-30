//
//  ResultViewModel.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 21/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit

class ResultViewModel: ModelRequester {
    internal var result: ChargeBack?
    typealias Requester = ChargebackRequester
    typealias ViewForModel = ResultView

    internal var modelView: ViewForModel
    required init(view: ViewForModel, dissmissMethod: @escaping ((Void) -> Void)) {
        modelView = view
        modelView.clickedOnCloseButton = dissmissMethod
    }
}

extension ResultView: ConfigurableView {

    typealias ConfigurableObject = ChargeBack
    func configure(with data: ConfigurableObject) {

    }
}
