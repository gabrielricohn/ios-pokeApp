//
//  PokeRegionsController.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation
import UIKit

class PokeRegionsController: UIViewController {
    @IBOutlet weak var pokeRegionsTableView: UITableView!
    @IBOutlet weak var signOutButton: UIButton!
    
    var pokeRegionsPresenter: PokeRegionsPresenter!
    
    var pokeRegionsCount: Int = 0
    var pokeResults = [PokeRegionsResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        pokeRegionsPresenter = PokeRegionsPresenter(apiService: ApiService())
        pokeRegionsPresenter.attachView(view: self)
        
        callRegionsFromApi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Pokemon Region"
        self.navigationController?.navigationBar.barTintColor = Colors.pokeRed
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.pokeWhite, NSAttributedString.Key.font: UIFont(name: Fonts.bold, size: 20)!]
    }
    
    func setupUI() {
        
        pokeRegionsTableView.separatorStyle = .none
        pokeRegionsTableView.delegate = self
        pokeRegionsTableView.dataSource = self
        pokeRegionsTableView.register(PokeRegionsCell.self, forCellReuseIdentifier: "PokeRegionsCell")
        
        signOutButton.setImage(UIImage(systemName: "return"), for: .normal)
        signOutButton.tintColor = Colors.pokeWhite
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        showSignOutAlert()
    }
}

extension PokeRegionsController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeRegionsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PokeRegionsCell = tableView.dequeueReusableCell(withIdentifier: "PokeRegionsCell") as! PokeRegionsCell
        cell.configureCellInfo(pokeRegion: pokeResults[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "PokemonsController") as! PokemonsController
        vc.selectedRegionString = pokeResults[indexPath.row].name
        vc.selectedRegionUrl = pokeResults[indexPath.row].url
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension PokeRegionsController : PokeRegionsView {
    func showSignOutAlert() {
        let alert = UIAlertController(title: "Cerrar sesión", message: "¿Desea cerrar sesión?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Cerrar sesión", style: .default, handler: { action in
            Session.expired()
        })
        alert.addAction(ok)
        
        let cancel = UIAlertAction(title: "Volver", style: .cancel, handler: { action in
        })
        alert.addAction(cancel)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    func loadRegionsFromApi(pokeRegions: PokeRegions) {
        pokeRegionsCount = pokeRegions.count
        pokeResults = pokeRegions.results
        DispatchQueue.main.async {
            self.pokeRegionsTableView.reloadData()
        }
    }
    
    func callRegionsFromApi() {
        pokeRegionsPresenter.getPokeRegionsFromApi()
    }
}
