//
//  SwitchView.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 23/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit
import NibDesignable
import SevenSwitch

class SwitchView: NibDesignable {

    var updateSwitchValue: ((String, Bool) -> Void)!
    var reasonId: String!

    @IBOutlet weak var isSelectedSwitch: SevenSwitch! {
        didSet {
            isSelectedSwitch.on = false
            isSelectedSwitch.onTintColor = .nuGreen
            isSelectedSwitch.inactiveColor = .nuCloseGray
            isSelectedSwitch.offLabel.text = "sim"
            isSelectedSwitch.onLabel.text = "não"

        }
    }

    @IBOutlet weak var label: UILabel! {
        didSet {
            label.textColor = .nuGreen
        }
    }

    @IBAction func didChangeValue(_ sender: SevenSwitch) {
        let isOn = sender.isOn()
        updateInterface(switchIsOn: isOn)
        updateSwitchValue(reasonId, isOn)

    }

    private func updateInterface(switchIsOn: Bool) {
        label.textColor = switchIsOn ?  .nuGreen : .nuText
    }

    func configure(with reason: Reason) {
        label.text = reason.title
        reasonId = reason.reasonId
    }

    func addHeightConstrant(_ height: CGFloat) {

        let height = NSLayoutConstraint(item: self,
                                        attribute: .height, relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0, constant: height)
        height.priority = 750

        let miniHeight = NSLayoutConstraint(item: self,
                                        attribute: .height, relatedBy: .greaterThanOrEqual,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0, constant: 0.0)

        self.addConstraints([height, miniHeight])
    }

    func constraintsForSwitchView(in superview: UIView, viewOnTop otherSwitch: UIView?) -> [NSLayoutConstraint] {
        let top: NSLayoutConstraint

        if let otherSwitch = otherSwitch {
            top = NSLayoutConstraint(item: self,
                                     attribute: .top, relatedBy: .equal,
                                     toItem: otherSwitch,
                                     attribute: .bottom,
                                     multiplier: 1.0, constant: 0.0)

        } else {
            top = NSLayoutConstraint(item: self,
                                         attribute: .top, relatedBy: .equal,
                                         toItem: superview,
                                         attribute: .top,
                                         multiplier: 1.0, constant: 0.0)

        }

        let leading = NSLayoutConstraint(item: self,
                                         attribute: .leading, relatedBy: .equal,
                                         toItem: superview,
                                         attribute: .leading,
                                         multiplier: 1.0, constant: 0.0)

        let trailing = NSLayoutConstraint(item: self,
                                          attribute: .trailing, relatedBy: .equal,
                                          toItem: superview,
                                          attribute: .trailing,
                                          multiplier: 1.0, constant: 0.0)
        return [top, leading, trailing]
    }

    func stickToBottom(of superview: UIView) {
        let bottom = NSLayoutConstraint(item: self,
                                         attribute: .bottom, relatedBy: .equal,
                                         toItem: superview,
                                         attribute: .bottom,
                                         multiplier: 1.0, constant: 0.0)
        superview.addConstraint(bottom)

    }
}
