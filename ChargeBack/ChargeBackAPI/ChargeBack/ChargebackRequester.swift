//
//  ChargebackRequester.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 17/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

class ChargebackRequester: EndpointRequester {

    typealias DataReturnedInRequest = ChargeBack
    var currentTask: URLSessionTask?
    var action: ChargeBackAPI.Actions
    var completion: ((DataReturnedInRequest?, String?) -> Void)?
    var postCompletion: ((Bool, String?) -> Void)?
    var chargeBackParameters: (reasons: [String: Bool], message: String)?
    required init(action: ChargeBackAPI.Actions) {
        self.action = action
    }

    func sendChargeBack(reasons: [String: Bool], message: String) {
        chargeBackParameters = (reasons: reasons, message: message)
        doPost()
    }

    func parameters() -> [String : Any]? {
        if let chargeBackParameters = self.chargeBackParameters {
            let message = chargeBackParameters.message
            var params = [String: Any]()
            params["comment"] = message
            var reasons = [[String: Any]]()
            for reason in chargeBackParameters.reasons {
                var reasonToAdd = [String: Any]()
                reasonToAdd["id"] = reason.0
                reasonToAdd["response"] = reason.1
                reasons.append(reasonToAdd)
            }
            params["reason_details"] = reasons
            return params
        }

        return nil
    }

    func parseJson(json: [String: Any]) {
        guard let links = json["links"] as? [String: Any] else { return }
        let possibleActions = parseLinks(json: links)
        guard possibleActions.count > 0 else { return }
        guard let chargeBack = parseChargeBack(json: json, nextActions: possibleActions) else { return }
        if let completion = completion {
            completion(chargeBack, nil)
        }
    }

    func parseChargeBack(json: [String: Any], nextActions: [ChargeBackAPI.Actions]) -> ChargeBack? {

        guard let title = json["title"] as? String  else { return nil }
        guard let comment = json["comment_hint"] as? String  else { return nil }
        guard let id = json["id"] as? String  else { return nil }
        guard let autoblock = json["autoblock"] as? Bool else { return nil }
        guard let reasons = parseReasonDetails(json: json) else { return nil }

       let chargeBack = ChargeBack(comment: comment,
                   id: id,
                   title: title,
                   autoblock: autoblock,
                   reasons: reasons,
                   actions: nextActions)
        return chargeBack
    }

    func parseReasonDetails(json: [String: Any]) -> [Reason]? {
        var reasons = [Reason]()
        guard let reasonDetails = json["reason_details"] as? [[String: Any]] else { return nil }
        for element in reasonDetails {
            guard let reasonId = element["id"] as? String else { return nil }
            guard let title = element["title"] as? String else { return nil }
            let reason = Reason(reasonId: reasonId, title: title)
            reasons.append(reason)
        }
        return reasons
    }
}
