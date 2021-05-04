//
//  Constants.swift
//  PokeApp
//
//  Created by Gabriel Rico on 20/2/21.
//

import Foundation
import UIKit

// MARK: Fonts
/**  Referencia a todos las fuentes  del proyecto
 
    ### Usage Example: ###
        let myFont = Fonts.regular
    
*/
class Fonts {
    static var fontFamily: String = "Lato"
    static var black: String = "\(fontFamily)-Black"
    static var blackItalic: String = "\(fontFamily)-BlackItalic"
    static var bold: String = "\(fontFamily)-Bold"
    static var boldItalic: String = "\(fontFamily)-BoldItalic"
    static var italic: String = "\(fontFamily)-Italic"
    static var light: String = "\(fontFamily)-Light"
    static var lightItalic: String = "\(fontFamily)-LightItalic"
    static var regular: String = "\(fontFamily)-Regular"
    static var thin: String = "\(fontFamily)-Thin"
    static var thinItalic: String = "\(fontFamily)-ThinItalic"
}

// MARK: Colors
/**  Referencia a todos los colores del proyecto
 
    ### Usage Example: ###
        let myFont = Colors.pokeBlue
    
*/

class Colors {
    static var pokeBlue: UIColor = UIColor(named: "PokeBlue")!
    static var pokeRed: UIColor = UIColor(named: "PokeRed")!
    static var pokeWhite: UIColor = UIColor(named: "PokeWhite")!
    static var pokeBlack: UIColor = UIColor(named: "PokeBlack")!
    static var pokeYellow: UIColor = UIColor(named: "PokeYellow")!
}
