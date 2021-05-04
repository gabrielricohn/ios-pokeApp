//
//  PokemonTitleCell.swift
//  PokeApp
//
//  Created by Gabriel Rico on 23/2/21.
//

import Foundation
import UIKit

class PokemonTitleCell: BaseTableViewCell {
    var selectedPokemonName: String = ""
    var selectedPokemonWeight: Int = 0
    var selectedPokemonImage: String = ""
    
    var pokeImage: AsyncImage = AsyncImage()
    var pokeNameLabel: UILabel = UILabel()
    var pokeWeightLabel: UILabel = UILabel()
    
    override func setup() {
        removeAutoConstraintsFromView(vs: [pokeImage, pokeNameLabel, pokeWeightLabel])
        
        contentView.addSubview(pokeImage)
        pokeImage.image = UIImage(systemName: "person.crop.circle")
        pokeImage.contentMode = .scaleAspectFill
        pokeImage.layer.cornerRadius = 50
        pokeImage.clipsToBounds = true
        pokeImage.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        pokeImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        pokeImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        pokeImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        contentView.addSubview(pokeNameLabel)
        pokeNameLabel.topAnchor.constraint(equalTo: pokeImage.bottomAnchor, constant: 10).isActive = true
        pokeNameLabel.centerXAnchor.constraint(equalTo: pokeImage.centerXAnchor, constant: 0).isActive = true
        pokeNameLabel.font = UIFont(name: Fonts.bold, size: 24)
        pokeNameLabel.textColor = Colors.pokeBlack
        
        contentView.addSubview(pokeWeightLabel)
        pokeWeightLabel.topAnchor.constraint(equalTo: pokeNameLabel.bottomAnchor, constant: 10).isActive = true
        pokeWeightLabel.centerXAnchor.constraint(equalTo: pokeNameLabel.centerXAnchor, constant: 0).isActive = true
        pokeWeightLabel.font = UIFont(name: Fonts.regular, size: 18)
        pokeWeightLabel.textColor = Colors.pokeBlack
    }
    
    func configureCellInfo() {
        let modifiedWeight = selectedPokemonWeight/10
        pokeImage.loadAsyncFrom(url: selectedPokemonImage, placeholder: UIImage(systemName: "person.crop.circle"), onCompletion: { success in }, onError: {})
        pokeNameLabel.text = selectedPokemonName
        pokeWeightLabel.text = String("Peso: \(modifiedWeight) Kg.")
    }
}
