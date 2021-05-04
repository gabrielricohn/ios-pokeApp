//
//  PokemonDetailsView.swift
//  PokeApp
//
//  Created by Gabriel Rico on 23/2/21.
//

import Foundation

protocol PokemonDetailsView {
    func callPokemonDetailsFromApi(pokeName: String)
    func loadPokemonDetailsFromApi(pokeDetails: PokemonDetails)
}
