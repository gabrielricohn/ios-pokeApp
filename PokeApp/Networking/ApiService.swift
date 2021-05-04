//
//  ApiService.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation

class ApiService {
    func getPokeApiInfo(completion:@escaping (Result<PokeRegions, Error>) -> ()) {
        
        let urlString = "https://pokeapi.co/api/v2/region"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let pokeData = try JSONDecoder().decode(PokeRegions.self, from: data)
                completion(.success(pokeData))
            } catch {
                print("Failed to decode: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getPokemonsFromRegionApi(pokeUrl: String, completion:@escaping (Result<PokemonsFromRegion, Error>) -> ()) {
        
        let urlString = pokeUrl
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let pokeData = try JSONDecoder().decode(PokemonsFromRegion.self, from: data)
                print(pokeData)
                completion(.success(pokeData))
            } catch {
                print("Failed to decode: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getCompletePokemonListApi(pokeUrl: String, completion:@escaping (Result<Pokemons, Error>) -> ()) {
        
        let urlString = pokeUrl
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let pokeData = try JSONDecoder().decode(Pokemons.self, from: data)
                print(pokeData)
                completion(.success(pokeData))
            } catch {
                print("Failed to decode: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getPokemonDetailsApi(pokeName: String, completion:@escaping (Result<PokemonDetails, Error>) -> ()) {
        
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(pokeName)"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let pokeData = try JSONDecoder().decode(PokemonDetails.self, from: data)
                print(pokeData)
                completion(.success(pokeData))
            } catch {
                print("Failed to decode: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
