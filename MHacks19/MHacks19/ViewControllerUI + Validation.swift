//
//  ViewControllerUI + Validation.swift
//  MHacks19
//
//  Created by Sam Jaehnig on 10/13/19.
//  Copyright © 2019 Sam Jaehnig. All rights reserved.
//

import UIKit
extension UIViewController {
    func isValidPassword(password: String?) -> Bool
    {
        guard let s = password, s.lowercased().range(of: "traxy") != nil else {
            return false
        }
        return true
    }
    func isEmptyOrNil(password: String?) -> Bool
    {
        guard let s = password, s != "" else {
            return false
        }
        return true
    }
    func isValidEmail(emailStr : String? ) -> Bool
    {
        var emailOk = false
        if let email = emailStr {
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", regex)
            emailOk = emailPredicate.evaluate(with: email)
        }
        return emailOk
    }
    func reportError(msg: String) {
        let alert = UIAlertController(title: "Failed", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
