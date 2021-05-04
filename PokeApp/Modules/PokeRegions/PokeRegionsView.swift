//
//  PokeRegionsView.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation

protocol PokeRegionsView {
    func callRegionsFromApi()
    func loadRegionsFromApi(pokeRegions: PokeRegions)
    func showSignOutAlert()
}
