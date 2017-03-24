//
//  MultiSwitchViewContainer.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 23/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit

fileprivate let heightForOneReason: CGFloat = 40.0

class MultiSwitchViewContainer: UIView {

    var switchViews: [SwitchView] = [SwitchView]()

    func configure(with reasons: [Reason], updateBlock: @escaping ((String, Bool) -> Void)) -> [String: Bool] {
        var reasonsState = [String: Bool]()
        for reason in reasons {
            let swithView = SwitchView()
            swithView.configure(with: reason)
            addSwitchViewToContainer(switchView: swithView)
            reasonsState[reason.reasonId] = false
            swithView.updateSwitchValue = updateBlock
        }
        if switchViews.count > 0 {
            let lastSwitch  = switchViews[switchViews.count - 1]
            lastSwitch.stickToBottom(of: self)
        }
        return reasonsState
    }

    func addSwitchViewToContainer(switchView: SwitchView) {
        let theSwitchViewOnTop: SwitchView?
        if switchViews.count > 0 {
           theSwitchViewOnTop  = switchViews[switchViews.count - 1]
        } else {
            theSwitchViewOnTop = nil
        }
        switchView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(switchView)
        let constraints = switchView.constraintsForSwitchView(in: self, viewOnTop: theSwitchViewOnTop)
        self.addConstraints(constraints)
        switchView.addHeightConstrant(heightForOneReason)
        self.switchViews.append(switchView)
    }

    func heightForView(for numberOfReasons: Int) -> CGFloat {
        if numberOfReasons == 0 {
            return 0.0
        }
        return heightForOneReason * CGFloat(numberOfReasons)
    }
}
