//
//  NoticeView.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 20/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit
import NibDesignable

class NoticeView: NibDesignable {

    var clickOnFirstActionButton: ((Void) -> Void)!
    var clickOnSecondActionButton: ((Void) -> Void)!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = UIColor.nuTitle
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
    @IBOutlet weak var separatorBetweenButtonView: UIView! {
        didSet {
            separatorBetweenButtonView.alpha = 0
            separatorBetweenButtonView.backgroundColor = UIColor.nuDisabledGray
        }
    }

    @IBOutlet weak var separatorOnTopOfFirstButtonView: UIView! {
        didSet {
            separatorOnTopOfFirstButtonView.alpha = 0
            separatorOnTopOfFirstButtonView.backgroundColor = UIColor.nuDisabledGray
        }
    }

    @IBOutlet weak var title: UILabel! {
        didSet {
            title.textColor = UIColor.nuTitle
            title.text = "carregando".uppercased()
        }
    }
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.textColor = UIColor.nuText
            textView.text = ""
        }
    }

    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.tintColor = UIColor.nuEnabledPurple
            continueButton.alpha = 0
        }
    }
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.tintColor = UIColor.nuCloseGray
            cancelButton.alpha = 0
        }
    }
    @IBAction func didClickOnFirstAction(_ sender: Any) {
        clickOnFirstActionButton()
    }

    @IBAction func didClickOnSecondAction(_ sender: Any) {
        clickOnSecondActionButton()
    }

}

extension NoticeView: ConfigurableView {

    typealias ConfigurableObject = Notice

    func configure(with data: ConfigurableObject) {
        separatorOnTopOfFirstButtonView.alpha = 1
        separatorBetweenButtonView.alpha = 1
        cancelButton.alpha = 1
        continueButton.alpha = 1
        activityIndicator.stopAnimating()
        title.text = data.title.uppercased()
        textView.text = data.description
        continueButton.setTitle(data.primaryAction.title.uppercased(), for: .normal)
        cancelButton.setTitle(data.secondaryAction.title.uppercased(), for: .normal)
    }

}
