//
//  PokemonsPresenter.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation

class PokemonsPresenter: BasePresenter {
    
    typealias View = PokemonsView
    var pokemonsView: PokemonsView?
    
    fileprivate let pokeApiService : ApiService
    
    init(apiService: ApiService) {
        self.pokeApiService = apiService
    }
    
    func attachView(view: PokemonsView) {
        self.pokemonsView = view
    }
    
    func detachView() {
    }
    
    func destroy() {
    }
    
    func getPokemonsFromRegionApi(pokeUrl: String) {
        pokeApiService.getPokemonsFromRegionApi(pokeUrl: pokeUrl, completion: { response in
            switch response {
            case .success(let pokemonsFromRegion):
                self.getCompletePokemonList(pokeRegionUrl: pokemonsFromRegion.pokedexes[0].url)
            case .failure(let error):
                print("error in API call: ", error)
            }
        })
    }
    
    func getCompletePokemonList(pokeRegionUrl: String) {
        pokeApiService.getCompletePokemonListApi(pokeUrl: pokeRegionUrl, completion: { response in
            switch response {
            case .success(let pokemons):
                self.pokemonsView?.loadPokemonsFromApi(pokemonsData: pokemons)
                break
            case .failure(let error):
                print("error in API call: ", error)
            }
        })
    }
}
