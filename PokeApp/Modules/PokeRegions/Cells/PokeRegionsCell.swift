//
//  PokeRegionsCell.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation
import UIKit

class PokeRegionsCell: BaseTableViewCell {
    var cellBackgroundView: UIView = UIView()
    var pokeballBackgroundView: UIImageView = UIImageView()
    var regionLabel: UILabel = UILabel()
    
    override func setup() {
        removeAutoConstraintsFromView(vs: [cellBackgroundView, pokeballBackgroundView, regionLabel])
        
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cellBackgroundView.heightAnchor.constraint(equalToConstant: contentView.bounds.height/0.5).isActive = true
        cellBackgroundView.widthAnchor.constraint(equalToConstant: contentView.bounds.width/0.95).isActive = true
        cellBackgroundView.backgroundColor = Colors.pokeRed
        cellBackgroundView.layer.cornerRadius = 20
        
        cellBackgroundView.addSubview(pokeballBackgroundView)
        pokeballBackgroundView.contentMode = .scaleAspectFit
        pokeballBackgroundView.image = UIImage(named: "pokeball_clear")
        pokeballBackgroundView.clipsToBounds = true
        pokeballBackgroundView.tintColor = Colors.pokeWhite.withAlphaComponent(0.2)
        pokeballBackgroundView.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor, constant: 0).isActive = true
        pokeballBackgroundView.centerXAnchor.constraint(equalTo: cellBackgroundView.centerXAnchor, constant: 0).isActive = true
        pokeballBackgroundView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10).isActive = true
        
        
        cellBackgroundView.addSubview(regionLabel)
        regionLabel.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor, constant: 0).isActive = true
        regionLabel.centerXAnchor.constraint(equalTo: cellBackgroundView.centerXAnchor, constant: 0).isActive = true
        regionLabel.numberOfLines = 0
        regionLabel.font = UIFont(name: Fonts.bold, size: 24)
        regionLabel.textColor = Colors.pokeWhite
    }
    
    func configureCellInfo(pokeRegion: PokeRegionsResults) {
        regionLabel.text = pokeRegion.name
    }
}
