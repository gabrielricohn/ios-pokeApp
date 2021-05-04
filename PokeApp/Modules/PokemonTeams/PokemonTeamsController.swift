//
//  PokemonTeamsController.swift
//  PokeApp
//
//  Created by Gabriel Rico on 24/2/21.
//

import Foundation
import UIKit

class PokemonTeamsController : UIViewController {
    @IBOutlet weak var pokemonTeamsTableView: UITableView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var noPokemonsStackView: UIStackView!
    @IBOutlet weak var noPokemonsImageView: UIImageView!
    @IBOutlet weak var noPokemonsLabel: UILabel!
    
    var pokemonTeamItemsArray = [[String : Any]]()
    
    var pokemonTeamsPresenter: PokemonTeamsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callTeamsFromFirebase()
    }
    
    func setupUI() {
        noPokemonsImageView.tintColor = Colors.pokeRed
        noPokemonsLabel.text = "Parece que no tienes equipos creados. ¡Adelante, crea tus equipos!"
        
        pokemonTeamsTableView.delegate = self
        pokemonTeamsTableView.dataSource = self
        pokemonTeamsTableView.register(PokemonTeamsCell.self, forCellReuseIdentifier: "PokemonTeamsCell")
        pokemonTeamsTableView.separatorStyle = .none
        
        pokemonTeamsPresenter = PokemonTeamsPresenter()
        pokemonTeamsPresenter.attachView(view: self)
        
        returnButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        returnButton.tintColor = Colors.pokeWhite
        
        self.title = "Mis equipos"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.pokeWhite, NSAttributedString.Key.font: UIFont(name: Fonts.bold, size: 16)!]
    }
    
    @IBAction func returnButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PokemonTeamsController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonTeamItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PokemonTeamsCell = tableView.dequeueReusableCell(withIdentifier: "PokemonTeamsCell") as! PokemonTeamsCell
        cell.selectionStyle = .none
        cell.configureTeamsCellInfo(pokemonData: pokemonTeamItemsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let teamToDelete = pokemonTeamItemsArray[indexPath.row]
            let team = teamToDelete["team_name"] as? String ?? ""
            
            pokemonTeamItemsArray.remove(at: indexPath.row)
            pokemonTeamsTableView.deleteRows(at: [indexPath], with: .automatic)
            
            DatabaseManager.shared.deletePokemonTeam(teamToDelete: team, completion: { success in
                if success {
                    self.callTeamsFromFirebase()
                }
            })
        }
    }
}

extension PokemonTeamsController : PokemonTeamsView {
    func callTeamsFromFirebase() {
        DatabaseManager.shared.getPokemonTeams(completion: { response, teamsArray  in
            if response {
                self.pokemonTeamItemsArray = teamsArray
                self.pokemonTeamsTableView.reloadData()
                
                if self.pokemonTeamItemsArray.isEmpty {
                    self.pokemonTeamsTableView.isHidden = true
                    self.noPokemonsStackView.isHidden = false
                } else {
                    self.pokemonTeamsTableView.isHidden = false
                    self.noPokemonsStackView.isHidden = true
                }
            }
        })
    }
}


