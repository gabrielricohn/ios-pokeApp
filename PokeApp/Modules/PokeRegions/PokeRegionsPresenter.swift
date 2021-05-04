//
//  PokeRegionsPresenter.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation

class PokeRegionsPresenter: BasePresenter {
    typealias View = PokeRegionsView
    var pokeRegionsView: PokeRegionsView?
    
    fileprivate let pokeApiService : ApiService
    
    init(apiService: ApiService) {
        self.pokeApiService = apiService
    }
    
    func attachView(view: PokeRegionsView) {
        self.pokeRegionsView = view
    }
    
    func detachView() {
    }
    
    func destroy() {
    }
    
    func getPokeRegionsFromApi() {
        pokeApiService.getPokeApiInfo(completion: { response in
            switch response {
            case .success(let pokeRegions):
                self.pokeRegionsView?.loadRegionsFromApi(pokeRegions: pokeRegions)
                break
            case .failure(let error):
                print("error in API call: ", error)
            }
        })
    }
    
}
