//
//  PokeRegions.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation

struct PokeRegions: Codable {
    var count: Int
    var results: [PokeRegionsResults]
}

struct PokeRegionsResults: Codable {
    var name: String
    var url: String
}

struct PokemonsFromRegion : Codable {
    var pokedexes: [PokemonsFromRegionResults]
}

struct PokemonsFromRegionResults : Codable {
    var name: String
    var url: String
}
