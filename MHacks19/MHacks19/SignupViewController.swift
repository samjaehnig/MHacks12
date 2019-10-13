//
//  SignupViewController.swift
//  MHacks19
//
//  Created by Sam Jaehnig on 10/12/19.
//  Copyright © 2019 Sam Jaehnig. All rights reserved.
//

import UIKit
import FirebaseAuth
class SignupViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var validationErrors = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func validateFields() -> Bool {
        let pwOk = self.isEmptyOrNil(password: self.passwordField.text)
        if !pwOk {
            self.validationErrors += "Password cannot be blank. "
        }
        let emailOk = self.isValidEmail(emailStr: self.emailField.text)
        if !emailOk {
            self.validationErrors += "Invalid email address."
        }
        return emailOk && pwOk
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        if self.validateFields() {
            Auth.auth().createUser(withEmail: self.emailField.text!, password:
            self.passwordField.text!) { (user, error) in
                if let  _ = user {
                    self.performSegue(withIdentifier: "List", sender: self)
                } else {
                    self.reportError(msg: (error?.localizedDescription)!)
                }
            }
        } else {
            self.passwordField.text = ""
            self.passwordField.becomeFirstResponder()
            self.reportError(msg: self.validationErrors)
        }
    }
}

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


