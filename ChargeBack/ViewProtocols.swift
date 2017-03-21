//
//  ViewProtocols.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 21/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit

protocol ConfigurableView {
    associatedtype ConfigurableObject
    func configure(with data: ConfigurableObject)
}

protocol GoBackProtocol {
    func quitChargeBackProcess()
    var rootViewController: UIViewController! { set get }
}

extension GoBackProtocol where Self : UIViewController {
    func quitChargeBackProcess() {
        rootViewController.dismiss(animated: true, completion: nil)
    }

}
