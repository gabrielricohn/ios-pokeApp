//
//  Session.swift
//  PokeApp
//
//  Created by Gabriel Rico on 23/2/21.
//

import Foundation
import UIKit
import GoogleSignIn

class Session {
    class func expired() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.synchronize()
        
        GIDSignIn.sharedInstance()?.signOut()
        
        DispatchQueue.main.async(execute: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let splashVC = storyboard.instantiateViewController(withIdentifier: "SignInController")
            let rootNaviVC: UINavigationController = UINavigationController(rootViewController: splashVC)
            let window = UIApplication.shared.keyWindow
            window?.rootViewController = rootNaviVC
        })
    }
}
