//
//  KeyboardShowAndHideProtocol.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 22/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit

public protocol KeyboardShowAndHideProtocol {
    func constraint () -> NSLayoutConstraint
    func viewToApplyAutoLayout() -> UIView
    func keyboardWasShown(notification: Notification)
    func keyboardWasHide(notification: Notification)
}
