//
//  PokemonUser.swift
//  PokeApp
//
//  Created by Gabriel Rico on 24/2/21.
//

import Foundation

struct PokemonUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
