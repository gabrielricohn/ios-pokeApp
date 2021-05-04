//
//  Pokemons.swift
//  PokeApp
//
//  Created by Gabriel Rico on 23/2/21.
//

import Foundation

struct Pokemons : Codable {
    var pokemon_entries: [PokemonSpecies]
}

struct PokemonSpecies : Codable {
    var pokemon_species: PokemonResults
}

struct PokemonResults : Codable {
    var name: String
    var url: String
}
