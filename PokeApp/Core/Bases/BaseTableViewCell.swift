//
//  BaseTableViewCell.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation
import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {}
    
    //MARK: - Funciones Personalizadas de la Celda
    public func removeAutoConstraintsFromView(vs: Array<UIView>){
        for v in vs{v.translatesAutoresizingMaskIntoConstraints=false}
    }
}
