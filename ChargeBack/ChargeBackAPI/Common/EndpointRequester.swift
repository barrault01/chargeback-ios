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
    var completion: ((DataReturnedInRequest?, String?) -> Void)? { get set }

    var postCompletion: ((Bool, String?) -> Void)? { get set }
    func parseJson(json: [String: Any])
    func parsePostJson(json: [String: Any])
    func parameters() -> [String: Any]?
    init(action: ChargeBackAPI.Actions)
}

extension EndpointRequester {

    func doGet(mockedFileName: String? = nil) {
        var fileName = mockedFileName
        if let stubEndpointsVar = ProcessInfo.processInfo.environment["stub_endpoints"] {
            if stubEndpointsVar == "true" {
                fileName = action.mockedFile()
            }
        }
        if let forceFail = ProcessInfo.processInfo.environment["force_failing"] {
            if forceFail == "true" {
                Requester.mockedFail(failingMethod: self.failingGetWithMessage)
                return
            }
        }

        if let mockedFileName = fileName {
            Requester.mockedEnpoint(jsonName: mockedFileName, parser: self.parseJson)
            return
        }
        guard let endpoint = action.endpoint() else {
            assertionFailure("this sould not be called because we don't know this endpoint yet")
            return
        }
        currentTask = Requester.makingGettRequest(urlInString: endpoint,
                                                  parser: self.parseJson,
                                                  failingMethod: self.failingGetWithMessage)
    }

    func doPost(mockedFileName: String? = nil) {

        var fileName = mockedFileName
        if let stubEndpointsVar = ProcessInfo.processInfo.environment["stub_endpoints"] {
            if stubEndpointsVar == "true" {
                fileName = "post"
            }
        }
        if let forceFail = ProcessInfo.processInfo.environment["force_failing"] {
            if forceFail == "true" {
                Requester.mockedFail(failingMethod: self.failingGetWithMessage)
                return
            }
        }

        if let fileName = fileName {
            Requester.mockedEnpoint(jsonName: fileName, parser: self.parsePostJson)
            return
        }
        guard let endpoint = action.endpoint() else {
            assertionFailure("this sould not be called because we don't know this endpoint yet")
            return
        }
        currentTask = Requester.makingPostRequest(urlInString: endpoint,
                                                  params: self.parameters(),
                                                  parser: self.parsePostJson,
                                                  failingMethod: self.failingPostWithMessage)
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
        let status = json["status"] as? String
        if let postCompletion = postCompletion {
            postCompletion(status == "Ok", nil)
        }
    }

     func parameters() -> [String: Any]? {
        return nil
    }

    func failingPostWithMessage(error: NuError?) {
        if let postCompletion = postCompletion {
            postCompletion(false, error?.messageToPresentToUser())
        }
    }

    func failingGetWithMessage(error: NuError?) {
        if let completion = completion {
            completion(nil, error?.messageToPresentToUser())
        }
    }

}
