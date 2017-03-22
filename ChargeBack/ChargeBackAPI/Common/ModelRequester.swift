//
//  ModelRequester.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 21/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

protocol ModelRequester: class {

    associatedtype ViewForModel: ConfigurableView
    associatedtype Requester: EndpointRequester
    var result: Requester.DataReturnedInRequest? { get set }
    var modelView: ViewForModel { get set }
    init(view: ViewForModel, dissmissMethod: @escaping ((Void) -> Void))
    func configureView(with data: Requester.DataReturnedInRequest)
    func configureAction(action: ChargeBackAPI.Actions)

}

extension ModelRequester {

    func configureAction(action: ChargeBackAPI.Actions) {
        let req = Requester(action: action)
        req.completion = self.configureView
        let _ = req.doGet()
    }

    func applyToView<T: ConfigurableView>(view: T, object: Requester.DataReturnedInRequest) {
        result = object
        if let object = object as? T.ConfigurableObject {
            view.configure(with: object)
        }
    }

    func configureView(with data: Requester.DataReturnedInRequest) {
        DispatchQueue.main.async {
            self.applyToView(view: self.modelView, object: data)
        }
    }

}
