//
//  UIAlertController+Extension.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 20/7/24.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showQuickSystemAlert(target: UIViewController? = UIViewController.top(),
                                     title: String? = nil,
                                     message: String? = nil,
                                     cancelButtonTitle: String = "OK",
                                     handler: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { _ in
            handler?()
        }))
        target?.present(alertVC, animated: true)
    }
}
