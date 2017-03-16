//
//  ChargeBack.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 17/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

struct ChargeBack {
    var comment: String
    var id: String
    var title: String
    var autoblock: Bool
    var reasons: [Reason]
    var actions: [ChargeBackAPI.Actions]

}

struct Reason {
    var reasonId: String
    var title: String
}
