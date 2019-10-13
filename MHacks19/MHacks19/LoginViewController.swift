//
//  LoginViewController.swift
//  MHacks19
//
//  Created by Sam Jaehnig on 10/12/19.
//  Copyright © 2019 Sam Jaehnig. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
        var validationErrors = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keyboard when tapping outside of text fields
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
        
        //make this controller the degelate of the text fields
        self.emailField.delegate = self as? UITextFieldDelegate
        self.passwordField.delegate = self as? UITextFieldDelegate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
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
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        if self.validateFields() {
            print("Congratulations! You entered correct values.")
                  Auth.auth().signIn(withEmail: self.emailField.text!, password:
                  self.passwordField.text!) { (user, error) in
                    if let _ = user {
                        self.performSegue(withIdentifier: "List", sender: self)
                    } else {
                        self.reportError(msg: (error?.localizedDescription)!)
                        self.passwordField.text = ""
                        self.passwordField.becomeFirstResponder()
                    }
            }
        } else {
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


