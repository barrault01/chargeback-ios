//
//  EntryPointRequester.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 16/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

class EntryPointRequester: EndpointRequester {

    typealias DataReturnedInRequest = ChargeBackAPI.Actions
    var currentTask: URLSessionTask?
    var action: ChargeBackAPI.Actions
    var completion: ((DataReturnedInRequest?, String?) -> Void)?
    var postCompletion: ((Bool, String?) -> Void)?

    required init(action: ChargeBackAPI.Actions) {
        self.action = action
    }

    func parseJson(json: [String: Any]) {
        guard let links = json["links"] as? [String: Any] else { return }
        let actions = parseLinks(json: links)
        guard let nextAction = actions.first else {
            self.failingGetWithMessage(error: .invalidJsonParsing)
            return
        }
        if let completion = completion {
            completion(nextAction, nil)
        }
    }

}
