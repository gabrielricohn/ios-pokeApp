//
//  SignInView.swift
//  PokeApp
//
//  Created by Gabriel Rico on 22/2/21.
//

import Foundation

protocol SignInView {
    func checkForPreviousSignIn()
    func showErrorAlert(message: String)
}
