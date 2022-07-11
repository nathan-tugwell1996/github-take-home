//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 11/07/2022.
//

import UIKit

extension UIViewController {
    func presentNTAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = NTAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
