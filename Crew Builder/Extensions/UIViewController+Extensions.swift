//
//  UIViewController+Extensions.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.

import SafariServices
import UIKit

private var containerView: UIView!

extension UIViewController {
    func presentCBAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = CBAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
