//
//  LoginViewController.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 20/2/23.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signIn: UIButton!
    
    let loginViewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func signInTapped(_ sender: UIButton) {
        
        let userEmail = emailText.text
        let password = passwordText.text
        
        loginViewModel.login(userEmail: userEmail, password: password){ [weak self] result in
            if result != .success {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: result.rawValue, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    self?.present(alert, animated: true, completion: nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    self?.dismiss(animated: true)
                }
            }
        }
        
    }
    
    
}
