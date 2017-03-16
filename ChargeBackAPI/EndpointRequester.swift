//
//  EndpointRequester.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 17/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

protocol EndpointRequester: class {

    var currentTask: URLSessionTask? { get set }
    var action: ChargeBackAPI.Actions { get set }

    func parseJson(json: [String: Any])
    func parameters() -> [String: Any]?
}

extension EndpointRequester {

    func doGet() {
        guard let endpoint = action.endpoint() else {
            assertionFailure("this sould not be called because we don't know this endpoint yet")
            return
        }
        currentTask = Requester.makingGettRequest(urlInString: endpoint, parser: self.parseJson)
    }

    func doPost() {
        guard let endpoint = action.endpoint() else {
            assertionFailure("this sould not be called because we don't know this endpoint yet")
            return
        }
        currentTask = Requester.makingPostRequest(urlInString: endpoint,
                                                  params: self.parameters(),
                                                  parser: self.parseJson)
    }

    func parseLinks(json: [String: Any]) -> [ChargeBackAPI.Actions] {
        // swiftlint:disable:next syntactic_sugar
        var actions: [ChargeBackAPI.Actions] = Array<ChargeBackAPI.Actions>()
        for (key, value) in json {
            var currentKey = key
            if currentKey == "self" {
                currentKey = self.action.description
            }
            if let action = ChargeBackAPI.Actions(string: currentKey) {
                if let value = value as? [String: Any],
                    let href = value["href"] as? String {
                    actions.append(action)
                    ChargeBackAPI.Actions.actionsUrls[action] = href
                }
            }
        }
        return actions
    }

    func parameters() -> [String: Any]? {
        return nil
    }
}
