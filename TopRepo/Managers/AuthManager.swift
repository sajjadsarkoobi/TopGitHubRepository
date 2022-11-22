//
//  AuthManager.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 12.11.2022.
//

import Foundation

final class AuthManager {
    
    public static var shared: AuthManager = AuthManager()
    
    private init(){
        //Singleton class init should be private
    }
    
    //Just faking it as all the Auth methods passed
    var isLoggedIn: Bool = true
}
