//
//  NoticeRequester.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 17/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

class NoticeRequester: EndpointRequester {

    typealias DataReturnedInRequest = Notice
    var currentTask: URLSessionTask?
    var action: ChargeBackAPI.Actions
    var completion: ((DataReturnedInRequest?, String?) -> Void)?
    var postCompletion: ((Bool, String?) -> Void)?

    required init(action: ChargeBackAPI.Actions) {
        self.action = action
    }

    func parseJson(json: [String: Any]) {
        guard let links = json["links"] as? [String: Any] else { return }
        let possibleActions = parseLinks(json: links)
        guard let nextAction = possibleActions.first else { return }
        guard let notice = parseNotice(json: json, nextAction: nextAction) else { return }
        if let completion = completion {
            completion(notice, nil)
        }
    }

    func parseNotice(json: [String: Any], nextAction: ChargeBackAPI.Actions) -> Notice? {
        guard let title = json["title"] as? String  else { return nil }
        guard let description = json["description"] as? String  else { return nil }
        guard let primary_action_json = json["primary_action"] as? [String: Any] else { return nil }
        guard let primary_action = parseInViewAction(json: primary_action_json) else { return nil }
        guard let secondary_action_json = json["secondary_action"] as? [String: Any] else { return nil }
        guard let secondary_action = parseInViewAction(json: secondary_action_json) else { return nil }
        let primaryActionNotice = ActionInNotice(title: primary_action.title, action: primary_action.action)
        let secondaryActionNotice = ActionInNotice(title: secondary_action.title, action: secondary_action.action)
        let notice = Notice(title: title, description: description,
                            primaryAction: primaryActionNotice,
                            secondaryAction: secondaryActionNotice,
                            nextAction: nextAction)
        return notice

    }

    func parseInViewAction(json: [String: Any]) -> (title: String, action: String)? {
        guard let title = json["title"] as? String  else { return nil }
        guard let action = json["action"] as? String  else { return nil }
        return (title, action)
    }
}
