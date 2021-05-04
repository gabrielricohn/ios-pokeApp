//
//  DatabaseManager.swift
//  PokeApp
//
//  Created by Gabriel Rico on 22/2/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

extension DatabaseManager {
    func userExists(with email: String, completion: @escaping((Bool) -> Void)) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    func insertUser(with user: PokemonUser) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName,
        ])
    }
    
    func userPokemonTeamExists(with email: String, teamName: String, completion: @escaping((Bool) -> Void)) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).child("teams").observeSingleEvent(of: .value, with: { snapshot in
            
            for child in snapshot.children {
                let planSnap = child as! DataSnapshot
                let planDict = planSnap.value as! [String: Any]
                let title = planDict["region"] as! String
                print(title)
            }
            
            if snapshot.value as? String == "\(teamName)" {
                completion(true)
            } else {
                completion(false)
            }
        })
        
    }
    
    func insertPokemonTeam(with team: SelectedPokemons) {
        let userDefaults = UserDefaults.standard
        let email = userDefaults.string(forKey: "email")
        
        var safeEmail = email!.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).child("teams").childByAutoId().setValue([
            "team_name": team.teamName,
            "region": team.region,
            "pokemons": team.pokemons
        ])
    }
    
    func getPokemonTeams(completion:@escaping (Bool, [[String:Any]]) -> ()) {
        var teamsArray = [[String: Any]]()
        
        let userDefaults = UserDefaults.standard
        let email = userDefaults.string(forKey: "email")
        
        var safeEmail = email!.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).child("teams").observeSingleEvent(of: .value, with: { snapshot in
            for item in snapshot.children {
                if let itemDict = (item as! DataSnapshot).value as? [String:Any]{
                    teamsArray.append(itemDict)
                }
            }
            completion(true, teamsArray)
        })
    }
    
    func deletePokemonTeam(teamToDelete: String, completion:@escaping (Bool) -> ()) {
        
        let userDefaults = UserDefaults.standard
        let email = userDefaults.string(forKey: "email")
        
        var safeEmail = email!.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).child("teams").queryOrdered(byChild: "team_name").queryEqual(toValue: teamToDelete).observe(.value, with: { (snapshot) in
            if let team = snapshot.value as? [String: [String: AnyObject]] {
                for (key, _) in team  {
                    self.database.child(safeEmail).child("teams").child(key).removeValue()
                }
            }
        })
    }
}
