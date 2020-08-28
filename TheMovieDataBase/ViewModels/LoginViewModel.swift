//
//  LoginViewModel.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 27/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    //MARK:- Initialization
    init() {
        initiateLoginProcess()
    }
    
    private func initiateLoginProcess() {
        
        URLSession.shared.dataTask(with: MovieServices.requestToken) { (data, response, error) in
            
            if let error = error {
                print("Token error \(error.localizedDescription)")
            } else if let data = data {
                print("token response \(data.count)")
            }
        }
    }
}
