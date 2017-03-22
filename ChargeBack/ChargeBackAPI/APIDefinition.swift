//
//  APIDefinition.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 15/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

public struct ChargeBackAPI {

    internal enum Actions: CustomStringConvertible {
        static var actionsUrls: [Actions: String] = [.entry: "https://nu-mobile-hiring.herokuapp.com"]

        case entry, notice, chargeback, card_block, card_unblock

        init?(string: String) {
            switch string {
            case "notice": self = .notice
            case "chargeback": self = .chargeback
            case "block_card": self = .card_block
            case "unblock_card": self = .card_unblock
            default: return nil
            }
        }

        var description: String {
            switch self {
            case .entry: return "entry"
            case .notice: return "notice"
            case .chargeback: return "chargeback"
            case .card_block: return "card_block"
            case .card_unblock: return "card_unblock"
            }
        }
        var httpMethods: [String] {
            switch self {
            case .entry, .notice: return ["GET"]
            case .chargeback: return ["GET", "POST"]
            case .card_block, .card_unblock: return ["POST"]
            }

        }
        func endpoint() -> String? {
             return Actions.actionsUrls[self]
        }
    }
}
