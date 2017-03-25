//
//  NoticeView.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 20/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import UIKit
import NibDesignable
import Atributika
import HexColors
class NoticeView: NibDesignable {

    var clickOnFirstActionButton: ((Void) -> Void)!
    var clickOnSecondActionButton: ((Void) -> Void)!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = .nuTitle
        }
    }
    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .nuViewBackground
        }
    }
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.backgroundColor = .nuBackground
        }
    }
    @IBOutlet weak var separatorBetweenButtonView: UIView! {
        didSet {
            separatorBetweenButtonView.alpha = 0
            separatorBetweenButtonView.backgroundColor = .nuDisabledGray
        }
    }

    @IBOutlet weak var separatorOnTopOfFirstButtonView: UIView! {
        didSet {
            separatorOnTopOfFirstButtonView.alpha = 0
            separatorOnTopOfFirstButtonView.backgroundColor = .nuDisabledGray
        }
    }

    @IBOutlet weak var title: UILabel! {
        didSet {
            title.textColor = .nuTitle
            title.text = "carregando"
        }
    }
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = ""
        }
    }

    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.tintColor = .nuEnabledPurple
            continueButton.alpha = 0
        }
    }
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.tintColor = .nuCloseGray
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
        title.text = data.title
        textView.attributedText = attributedStringForNotice(string: data.description)
        continueButton.setTitle(data.primaryAction.title.uppercased(), for: .normal)
        cancelButton.setTitle(data.secondaryAction.title.uppercased(), for: .normal)
    }

    func attributedStringForNotice(string: String) -> NSAttributedString {
        var string = string
        let colorsParsed = string.replacingColors()
        var styles: [Style] = [Style]()
        let b = Style("strong").font(.boldSystemFont(ofSize: 16))
        styles.append(b)
        for color in colorsParsed {
            let style = Style(color.1).font(.systemFont(ofSize: 16)).foregroundColor(UIColor("#\(color.0)")!)
            styles.append(style)
        }
        let str = string.style(tags: styles)
            .styleAll(Style.font(.systemFont(ofSize: 16)).foregroundColor(.nuText))
            .attributedString
        return str

    }

}
