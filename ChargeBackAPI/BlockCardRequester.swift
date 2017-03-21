//
//  BlockUnBlockCardRequester.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 21/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

class BlockUnBlockCardRequester: EndpointRequester {

    typealias DataReturnedInRequest = ChargeBackAPI.Actions
    var currentTask: URLSessionTask?
    var action: ChargeBackAPI.Actions
    var completion: ((DataReturnedInRequest) -> Void)?
    var postCompletion: ((Bool) -> Void)?
    required init(action: ChargeBackAPI.Actions) {
        self.action = action
    }

    func parseJson(json: [String: Any]) {
        //no need of parse because is a post
    }

}
