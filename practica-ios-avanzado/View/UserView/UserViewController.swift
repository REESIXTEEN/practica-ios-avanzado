//
//  UserViewController.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import UIKit

class UserViewController: UIViewController {

    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    
    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLabel.text = userViewModel.readData()
    }
    
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        userViewModel.logOut()
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(loginViewController, animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let yesAction = UIAlertAction(title: "Yes", style: .default){_ in
            self.userViewModel.deleteUserData()
        }
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
