//
//  PokemonDetailsController.swift
//  PokeApp
//
//  Created by Gabriel Rico on 23/2/21.
//

import Foundation
import UIKit

class PokemonDetailsController: UIViewController {
    
    @IBOutlet weak var pokemonDetailsTableView: UITableView!
    @IBOutlet weak var returnButton: UIButton!
    
    var selectedPokemon: String = ""
    
    var pokemonDetailsPresenter: PokemonDetailsPresenter!
    
    var pokeImage: String = ""
    var pokeName: String = ""
    var pokeWeight: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonDetailsTableView.delegate = self
        pokemonDetailsTableView.dataSource = self
        pokemonDetailsTableView.register(PokemonTitleCell.self, forCellReuseIdentifier: "PokemonTitleCell")
        pokemonDetailsTableView.separatorStyle = .none
        
        pokemonDetailsPresenter = PokemonDetailsPresenter(apiService: ApiService())
        pokemonDetailsPresenter.attachView(view: self)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.pokeWhite, NSAttributedString.Key.font: UIFont(name: Fonts.bold, size: 20)!]
        
        returnButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        returnButton.tintColor = Colors.pokeWhite
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pokemonDetailsPresenter.getPokemonDetailsFromApi(pokeName: selectedPokemon)
    }
    
    @IBAction func returnButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension PokemonDetailsController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PokemonTitleCell = tableView.dequeueReusableCell(withIdentifier: "PokemonTitleCell") as! PokemonTitleCell
        cell.selectionStyle = .none
        cell.selectedPokemonName = pokeName
        cell.selectedPokemonWeight = pokeWeight
        cell.selectedPokemonImage = pokeImage
        cell.configureCellInfo()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension PokemonDetailsController : PokemonDetailsView {
    func callPokemonDetailsFromApi(pokeName: String) {
        pokemonDetailsPresenter.getPokemonDetailsFromApi(pokeName: pokeName)
    }
    
    func loadPokemonDetailsFromApi(pokeDetails: PokemonDetails) {
        self.pokeName = pokeDetails.name
        self.pokeWeight = pokeDetails.weight
        self.pokeImage = pokeDetails.sprites.front_default
        
        DispatchQueue.main.async {
            self.title = "\(self.pokeName)"
            self.pokemonDetailsTableView.reloadData()
        }
    }
}
