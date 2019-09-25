//
//  KeyBoardHideListerner.swift
//  ShoppingApp
//
//  Created by Aruna Lakmal2 on 9/25/19.
//  Copyright © 2019 Chamali Nirasha. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}
