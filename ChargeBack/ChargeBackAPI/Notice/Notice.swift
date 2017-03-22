//
//  Notice.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 17/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

struct ActionInNotice {
    var title: String
    var action: String
}

public struct Notice {
    var title: String
    var description: String
    var primaryAction: ActionInNotice
    var secondaryAction: ActionInNotice
    var nextAction: ChargeBackAPI.Actions
}
