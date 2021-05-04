//
//  BasePresenter.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation

protocol BasePresenter {
    associatedtype View
    
    /**
     Esta funcion se utiliza para adjuntar la View en el Presenter
     
     ### Usage Example: ###
     ````
        func attachView(view: View) {
          self.loginView = view
        }
     ````
     */
    func attachView(view : View)
      
    /**
     Esta funcion se utiliza para separar o desinstalar  la View en el Presenter
     
     ### Usage Example: ###
     ````
        func detachView() {
            self.loginView = nil
        }
     ````
     */
    func detachView()
      
    /**
     Esta funcion se utiliza para destruir  la View en el Presenter
     
     ### Usage Example: ###
     ````
        func destroy() {

        }
     ````
     */
    func destroy()
}
