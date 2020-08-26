//
//  AuthVC.swift
//  sendReceiveParcel
//
//  Created by Федот Евсеев on 27.08.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {
    var signed = true {
        willSet {
            if newValue {
                titleLabel.text = "Регистрация"
                nameField.isHidden = false
                button.setTitle("Зарегистрироваться", for: .normal)
            } else {
                titleLabel.text = "Войти"
                nameField.isHidden = true
                button.setTitle("Авторизоваться", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        view.backgroundColor = .green
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        signed = !signed
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Введите все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension AuthVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     let name = nameField.text!
     let email = emailField.text!
     let password = passwordField.text!
     
        if(signed){
            if(!name.isEmpty && !email.isEmpty && !password.isEmpty){
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            
                            let reference = Database.database().reference().child("users")
                            reference.child(result.user.uid).updateChildValues(["name" : name, "email" : email])
                            
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            } else {
                showAlert()
            }
        } else if (!email.isEmpty && !password.isEmpty) {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                showAlert()
            }
        return true
        }
        
    
    
}
