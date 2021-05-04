//
//  PokemonsController.swift
//  PokeApp
//
//  Created by Gabriel Rico on 21/2/21.
//

import Foundation
import UIKit
import GoogleSignIn

let createTeamNotification = "com.PokeApp.createTeam"

class PokemonsController: UIViewController {
    @IBOutlet weak var pokemonsCollectionView: UICollectionView!
    @IBOutlet weak var createTeamButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    
    var selectedRegionString: String = ""
    var selectedRegionUrl: String = ""
    
    var pokemonsPresenter: PokemonsPresenter!
    
    var pokemonsList = [PokemonSpecies]()
    var selectedPokemonsArray = [String]()
    
    var isInPokemonTeamSelectionMode: Bool = false
    
    let createTeamNotify = Notification.Name(rawValue: createTeamNotification)
    
    var teamNameString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerNotifications()
        
        pokemonsPresenter = PokemonsPresenter(apiService: ApiService())
        pokemonsPresenter.attachView(view: self)
        
        callPokemonsFromApi()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterNotifications()
        selectedPokemonsArray.removeAll()
    }
    
    func setupUI() {
        pokemonsCollectionView.delegate = self
        pokemonsCollectionView.dataSource = self
        pokemonsCollectionView.register(PokemonsCollectionCell.self, forCellWithReuseIdentifier: "PokemonsCollectionCell")
        pokemonsCollectionView.allowsMultipleSelection = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        pokemonsCollectionView.setCollectionViewLayout(layout, animated: true)
        
        self.navigationController?.navigationBar.barTintColor = Colors.pokeRed
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.pokeWhite, NSAttributedString.Key.font: UIFont(name: Fonts.bold, size: 16)!]
        
        createTeamButton.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        returnButton.addTarget(self, action: #selector(changeReturnButtonFunction), for: .touchUpInside)
        
        self.title = "Pokemons"
        createTeamButton.setImage(UIImage(systemName: "chart.bar.doc.horizontal"), for: .normal)
        returnButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        
        createTeamButton.tintColor = Colors.pokeWhite
        returnButton.tintColor = Colors.pokeWhite
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didTapCreateTeam(notification:)), name: createTeamNotify, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: createTeamNotify, object: nil)
    }
    
    @objc func changeReturnButtonFunction() {
        if isInPokemonTeamSelectionMode {
            pokemonsCollectionView.deselectAllItems(animated: true)
            selectedPokemonsArray.removeAll()
            self.title = "Seleccionados: \(selectedPokemonsArray.count)/6"
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func didTapCreateTeam(notification: NSNotification) {
        isInPokemonTeamSelectionMode = true
        self.pokemonsCollectionView.allowsMultipleSelection = true
        self.title = "Seleccionados: \(selectedPokemonsArray.count)/6"
        createTeamButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        returnButton.setImage(UIImage(systemName: "clear"), for: .normal)
    }
    
    @objc func showMenu() {
        
        if isInPokemonTeamSelectionMode {
            guard selectedPokemonsArray.count > 2 else {
                showErrorAlert(title: "Insuficientes Pokemons", message: "Para crear un equipo, se requieren mínimo 3 Pokemons. Selecciona hasta 6 Pokemons")
                return
            }
                    
            DatabaseManager.shared.insertPokemonTeam(with: SelectedPokemons(teamName: teamNameString, region: selectedRegionString, pokemons: selectedPokemonsArray))
            
            isInPokemonTeamSelectionMode = false
            
            self.title = "Pokemons"
            createTeamButton.setImage(UIImage(systemName: "chart.bar.doc.horizontal"), for: .normal)
            returnButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
            
            pokemonsCollectionView.deselectAllItems(animated: true)
            selectedPokemonsArray.removeAll()
            
            showErrorAlert(title: "¡Equipo creado!", message: "\(teamNameString) ha sido creado con éxito.")
        } else {
            showMainMenu()
        }
        
    }
    
}

extension PokemonsController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PokemonsCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonsCollectionCell", for: indexPath) as! PokemonsCollectionCell
        cell.configureCellInfo(pokemonData: pokemonsList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isInPokemonTeamSelectionMode {
            selectedPokemonsArray.append(pokemonsList[indexPath.row].pokemon_species.name)
            self.title = "Seleccionados: \(selectedPokemonsArray.count)/6"
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier: "PokemonDetailsController") as! PokemonDetailsController
            vc.selectedPokemon = pokemonsList[indexPath.row].pokemon_species.name
            self.navigationController?.pushViewController(vc,animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isInPokemonTeamSelectionMode {
            selectedPokemonsArray = selectedPokemonsArray.filter { $0 != "\(pokemonsList[indexPath.row].pokemon_species.name)" }
            self.title = "Seleccionados: \(selectedPokemonsArray.count)/6"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let shouldSelect = collectionView.indexPathsForSelectedItems!.count < 6;
        if !shouldSelect {
            print("mas de 6 seleccionados")
        }
        return shouldSelect
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 3 - lay.minimumInteritemSpacing
        return CGSize(width:widthPerItem, height:50)
    }
    
    
}

extension PokemonsController : PokemonsView {
    func callPokemonsFromApi() {
        pokemonsPresenter.getPokemonsFromRegionApi(pokeUrl: selectedRegionUrl)
    }
    
    func loadPokemonsFromApi(pokemonsData: Pokemons) {
        pokemonsList = pokemonsData.pokemon_entries
        DispatchQueue.main.async {
            self.pokemonsCollectionView.reloadDataWithAutoSizingCellWorkAround()
        }
    }
    
    func showCreateTeamAlert() {
        let alert = UIAlertController(title: "Crear equipo", message: "Bienvenido a la creacion de equipo! Ponle un nombre a tu equipo, luego elige 3-6 Pokemons y prepárate para la batalla!", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Ingresa el nombre de tu equipo"
        }
        
        let ok = UIAlertAction(title: "Comenzar", style: .default, handler: { action in
            self.teamNameString = alert.textFields![0].text!
            let notificationName = Notification.Name(createTeamNotification)
            NotificationCenter.default.post(name: notificationName, object: nil)
        })
        alert.addAction(ok)
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: { action in })
        alert.addAction(cancel)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    func showMainMenu() {
        let alert = UIAlertController(title: "Menú principal", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Crear equipo", style: .default , handler:{ (UIAlertAction) in
            self.showCreateTeamAlert()
        }))
        
        alert.addAction(UIAlertAction(title: "Mis equipos", style: .default , handler:{ (UIAlertAction) in
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier: "PokemonTeamsController") as! PokemonTeamsController
            self.navigationController?.pushViewController(vc,animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cerrar sesión", style: .destructive , handler:{ (UIAlertAction) in
            Session.expired()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel , handler: nil))
        
        self.present(alert, animated: true, completion: {})
    }
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Listo", style: .default, handler: nil)
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
