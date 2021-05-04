//
//  SignInController.swift
//  PokeApp
//
//  Created by Gabriel Rico on 20/2/21.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

class SignInController: UIViewController {
    
    @IBOutlet weak var signInGoogleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        checkForPreviousSignIn()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func googleButtonAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
}

extension SignInController : SignInView {
    func checkForPreviousSignIn() {
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String, email != ""{
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier: "PokeRegionsController") as! PokeRegionsController
            self.navigationController?.pushViewController(vc,animated: true)
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error de sesión", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Listo", style: .default, handler: nil)
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}

extension SignInController : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil && user.authentication != nil {
            let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
            
            let userEmail = user.profile.email ?? ""
            let userFirstName = user.profile.givenName ?? ""
            let userLastName = user.profile.familyName ?? ""
            
            DatabaseManager.shared.userExists(with: userEmail, completion: { exists in
                guard !exists else {
                    self.showErrorAlert(message: "Ya existe este correo electrónico en el servidor")
                    return
                }
                
                Auth.auth().signIn(with: credential, completion: { (result, error) in
                    
                    if result == result, error == nil {
                        
                        let defaults = UserDefaults.standard
                        defaults.setValue(userEmail, forKey: "email")
                        defaults.synchronize()
                        
                        DatabaseManager.shared.insertUser(with: PokemonUser(firstName: userFirstName,
                                                                            lastName: userLastName,
                                                                            emailAddress: userEmail))
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let vc = storyboard.instantiateViewController(withIdentifier: "PokeRegionsController") as! PokeRegionsController
                        self.navigationController?.pushViewController(vc,animated: true)
                        
                    } else {
                        
                        self.showErrorAlert(message: "Hubo un problema al iniciar sesión. Intente nuevamente iniciar sesión")
                        
                    }
                    
                })
            })
        }
    }
}

