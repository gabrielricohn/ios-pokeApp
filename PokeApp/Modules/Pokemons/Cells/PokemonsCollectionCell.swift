//
//  PokemonsCollectionCell.swift
//  PokeApp
//
//  Created by Gabriel Rico on 23/2/21.
//

import Foundation
import UIKit

class PokemonsCollectionCell: UICollectionViewCell {
    var pokemonNameLabel: UILabel = UILabel()
    var pokeballBackgroundView: UIImageView = UIImageView()
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderColor = self.isSelected ? Colors.pokeBlue.cgColor : Colors.pokeWhite.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeAutoConstraintsFromView(vs: Array<UIView>){
        for v in vs{v.translatesAutoresizingMaskIntoConstraints=false}
    }
    
    func setup() {
        removeAutoConstraintsFromView(vs: [pokeballBackgroundView, pokemonNameLabel])
        
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 1.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = Colors.pokeBlack.cgColor
        
        contentView.layer.cornerRadius = 15
        
        contentView.backgroundColor = Colors.pokeYellow
        contentView.layer.borderWidth = 2
        
        contentView.addSubview(pokeballBackgroundView)
        pokeballBackgroundView.contentMode = .scaleAspectFit
        pokeballBackgroundView.image = UIImage(named: "pokeball_clear")
        pokeballBackgroundView.clipsToBounds = true
        pokeballBackgroundView.tintColor = Colors.pokeBlue.withAlphaComponent(0.2)
        pokeballBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        pokeballBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        pokeballBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        contentView.addSubview(pokemonNameLabel)
        pokemonNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        pokemonNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        pokemonNameLabel.font = UIFont(name: Fonts.regular, size: 14)
        pokemonNameLabel.textColor = Colors.pokeBlack
        pokemonNameLabel.numberOfLines = 0
    }
    
    func configureCellInfo(pokemonData: PokemonSpecies) {
        pokemonNameLabel.text = pokemonData.pokemon_species.name
    }
}
