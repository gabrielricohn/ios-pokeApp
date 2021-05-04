//
//  PokemonDetailsPresenter.swift
//  PokeApp
//
//  Created by Gabriel Rico on 23/2/21.
//

import Foundation

class PokemonDetailsPresenter: BasePresenter {
    typealias View = PokemonDetailsView
    var pokemonDetailsView: PokemonDetailsView?
    
    fileprivate let pokeApiService : ApiService
    
    init(apiService: ApiService) {
        self.pokeApiService = apiService
    }
    
    func attachView(view: PokemonDetailsView) {
        self.pokemonDetailsView = view
    }
    
    func detachView() {
        
    }
    
    func destroy() {
        
    }
    
    func getPokemonDetailsFromApi(pokeName: String) {
        pokeApiService.getPokemonDetailsApi(pokeName: pokeName, completion: { response in
            switch response {
            case .success(let pokeDetails):
                self.pokemonDetailsView?.loadPokemonDetailsFromApi(pokeDetails: pokeDetails)
                break
            case .failure(let error):
                print("error in API call: ", error)
            }
        })
    }
    
    

}
