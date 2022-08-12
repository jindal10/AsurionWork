//
//  UIAlertControllerExtension.swift
//  AsurionCodingWork
//
//  Created by Gaurav Jindal on 03/08/22.
//

import UIKit

extension UIAlertController {
    class func show(_ message: String, from controller: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.modalPresentationStyle = .fullScreen
        alert.addAction(UIAlertAction(title: StringConstant.okay, style: .default))
        controller.present(alert, animated: true)
    }
}
