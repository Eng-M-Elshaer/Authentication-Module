//
//  Manger.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import Foundation

struct UserDefultsManger {
    
    static let shared = UserDefultsManger()
    let defaults = UserDefaults.standard

    func setUserDefaults(user:User){
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            defaults.set(encoded, forKey: "User")
        }
    }
    
    func getUserDefaults() -> User? {
        
        if let savedUser = defaults.object(forKey: "User") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                print(loadedUser.name ?? "N/A")
                return loadedUser
            }
        }
        return nil
    }
}
