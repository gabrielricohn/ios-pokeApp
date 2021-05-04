//
//  PokemonsView.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation

protocol PokemonsView {
    func callPokemonsFromApi()
    func loadPokemonsFromApi(pokemonsData: Pokemons)
    func showCreateTeamAlert()
    func showMainMenu()
    func showErrorAlert(title: String, message: String)
}
