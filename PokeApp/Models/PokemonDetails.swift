//
//  PokemonDetails.swift
//  PokeApp
//
//  Created by Gabriel Rico on 23/2/21.
//

import Foundation

struct PokemonDetails : Codable {
    let name: String
    let sprites: PokemonSprites
    let weight: Int
}

struct PokemonSprites : Codable {
    let front_default: String
}

struct PokeDetailsFromApi {
    let name: String = ""
    let sprites: String = ""
    let weight: Int = 0
    let picture: String = ""
}
