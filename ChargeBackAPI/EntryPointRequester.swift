//
//  EntryPointRequester.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 16/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

class EntryPointRequester: EndpointRequester {

    var currentTask: URLSessionTask?
    var action: ChargeBackAPI.Actions
    var completion: ((ChargeBackAPI.Actions) -> Void)?
    init(action: ChargeBackAPI.Actions) {
        self.action = action
    }

    func parseJson(json: [String: Any]) {
        guard let links = json["links"] as? [String: Any] else { return }
        let actions = parseLinks(json: links)
        guard let nextAction = actions.first else { return }
        if let completion = completion {
            completion(nextAction)
        }
    }

}
