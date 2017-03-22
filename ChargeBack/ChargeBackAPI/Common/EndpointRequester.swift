//
//  EndpointRequester.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 17/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

protocol EndpointRequester: class {

    associatedtype DataReturnedInRequest
    var currentTask: URLSessionTask? { get set }
    var action: ChargeBackAPI.Actions { get set }
    var completion: ((DataReturnedInRequest) -> Void)? { get set }

    var postCompletion: ((Bool) -> Void)? { get set }
    func parseJson(json: [String: Any])
    func parsePostJson(json: [String: Any])
    func parameters() -> [String: Any]?
    init(action: ChargeBackAPI.Actions)
}

extension EndpointRequester {

    func doGet() {
        doGet(mockedFileName: nil)
    }

    func doGet(mockedFileName: String?) {

        if let mockedFileName = mockedFileName {
            Requester.mockedEnpoint(jsonName: mockedFileName, parser: self.parseJson)
            return
        }
        guard let endpoint = action.endpoint() else {
            assertionFailure("this sould not be called because we don't know this endpoint yet")
            return
        }
        currentTask = Requester.makingGettRequest(urlInString: endpoint, parser: self.parseJson)
    }

    func doPost() {
        doPost(mockedFileName: nil)
    }

    func doPost(mockedFileName: String?) {

        if let mockedFileName = mockedFileName {
            Requester.mockedEnpoint(jsonName: mockedFileName, parser: self.parsePostJson)
            return
        }
        guard let endpoint = action.endpoint() else {
            assertionFailure("this sould not be called because we don't know this endpoint yet")
            return
        }
        currentTask = Requester.makingPostRequest(urlInString: endpoint,
                                                  params: self.parameters(),
                                                  parser: self.parsePostJson)
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

    func parsePostJson(json: [String: Any]) {
        guard let status = json["status"] as? String  else { return }
        if let postCompletion = postCompletion {
            postCompletion(status == "Ok")
        }
    }

     func parameters() -> [String: Any]? {
        return nil
    }
}
