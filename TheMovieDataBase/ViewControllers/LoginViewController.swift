//
//  LoginViewController.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 25/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK:-
    var viewModel: LoginViewModel?
    
    //MARK:-
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        debugPrint(viewModel!)
    }
    
    //MARK:- Custom methods
    @IBAction func loginAction(_ sender: Any) {
        
    }
}

