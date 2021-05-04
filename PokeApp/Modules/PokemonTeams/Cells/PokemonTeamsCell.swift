//
//  PokemonTeamsCell.swift
//  PokeApp
//
//  Created by Gabriel Rico on 24/2/21.
//

import Foundation
import UIKit

class PokemonTeamsCell: BaseTableViewCell {
    var cellBackgroundView: UIView = UIView()
    var pokeballBackgroundView: UIImageView = UIImageView()
    var pokemonNameLabel: UILabel = UILabel()
    var pokemonRegionLabel: UILabel = UILabel()
    var pokemonCountLabel: UILabel = UILabel()
    
    var pokemonsArray = [String]()
    
    override func setup() {
        removeAutoConstraintsFromView(vs: [cellBackgroundView, pokeballBackgroundView, pokemonNameLabel, pokemonRegionLabel, pokemonCountLabel])
        
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 1.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = Colors.pokeBlack.cgColor
        
        cellBackgroundView.layer.cornerRadius = 15
        
        cellBackgroundView.layer.borderWidth = 1
        
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cellBackgroundView.heightAnchor.constraint(equalToConstant: contentView.bounds.height/0.5).isActive = true
        cellBackgroundView.widthAnchor.constraint(equalToConstant: contentView.bounds.width/0.85).isActive = true
        cellBackgroundView.backgroundColor = Colors.pokeBlue
        cellBackgroundView.layer.cornerRadius = 20
        
        cellBackgroundView.addSubview(pokeballBackgroundView)
        pokeballBackgroundView.contentMode = .scaleAspectFit
        pokeballBackgroundView.image = UIImage(named: "pokeball_clear")
        pokeballBackgroundView.clipsToBounds = true
        pokeballBackgroundView.tintColor = Colors.pokeYellow.withAlphaComponent(0.2)
        pokeballBackgroundView.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor, constant: 0).isActive = true
        pokeballBackgroundView.centerXAnchor.constraint(equalTo: cellBackgroundView.centerXAnchor, constant: 0).isActive = true
        pokeballBackgroundView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10).isActive = true
        
        
        cellBackgroundView.addSubview(pokemonNameLabel)
        pokemonNameLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10).isActive = true
        pokemonNameLabel.centerXAnchor.constraint(equalTo: cellBackgroundView.centerXAnchor, constant: 0).isActive = true
        pokemonNameLabel.numberOfLines = 0
        pokemonNameLabel.font = UIFont(name: Fonts.bold, size: 24)
        pokemonNameLabel.textColor = Colors.pokeWhite
        
        cellBackgroundView.addSubview(pokemonRegionLabel)
        pokemonRegionLabel.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 10).isActive = true
        pokemonRegionLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 10).isActive = true
        pokemonRegionLabel.numberOfLines = 0
        pokemonRegionLabel.font = UIFont(name: Fonts.regular, size: 16)
        pokemonRegionLabel.textColor = Colors.pokeWhite
        pokemonRegionLabel.text = "Región"
        
        cellBackgroundView.addSubview(pokemonCountLabel)
        pokemonCountLabel.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 10).isActive = true
        pokemonCountLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -10).isActive = true
        pokemonCountLabel.numberOfLines = 0
        pokemonCountLabel.font = UIFont(name: Fonts.regular, size: 16)
        pokemonCountLabel.textColor = Colors.pokeWhite
        pokemonCountLabel.text = "Pokemons"
    }
    
    func configureTeamsCellInfo(pokemonData: [String : Any]) {
        if let pokemonsDict = pokemonData["pokemons"] as? NSArray {
            for item in pokemonsDict {
                pokemonsArray.append(item as! String)
            }
        }
        pokemonNameLabel.text = pokemonData["team_name"] as? String
        pokemonRegionLabel.text = "Región: \(pokemonData["region"] as? String ?? "")"
        pokemonCountLabel.text = "\(pokemonsArray.count) Pokemons"
    }
}
