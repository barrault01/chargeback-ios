//
//  ResultView.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 21/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit
import NibDesignable

class ResultView: NibDesignable {

    var clickedOnCloseButton: ((Void) -> Void)!

    @IBOutlet weak var title: UILabel! {
        didSet {
            title.textColor = UIColor.nuTitle
        }
    }

    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = UIColor.nuViewBackground
        }
    }
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.backgroundColor = UIColor.nuBackground
        }
    }
    @IBOutlet weak var descrptionTextView: UITextView! {
        didSet {
            descrptionTextView.textColor = UIColor.nuText
        }

    }

    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.tintColor = UIColor.nuCloseGray
        }
    }

    @IBAction func didClickOnCloseButton(_ sender: Any) {
        clickedOnCloseButton()
    }
}

extension ResultView: ConfigurableView {

    typealias ConfigurableObject = ChargeBack
    func configure(with data: ChargeBack) {

    }
}
