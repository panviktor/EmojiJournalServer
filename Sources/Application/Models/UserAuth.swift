//
//  UserAuth.swift
//  
//
//  Created by Viktor on 13.09.2020.
//

import CredentialsHTTP

public struct UserAuth {
    public var id: String
    private let password: String
}

extension UserAuth: TypeSafeHTTPBasic {
    public static let authenticate = ["John": "12345", "Mary": "ABCDE"]
    
    public static func verifyPassword(username: String,
                                      password: String, callback: @escaping (UserAuth?) -> Void) {
        
        if let storedPassword = authenticate[username], storedPassword == password {
            callback(UserAuth(id: username, password: password))
            return
        }
        callback(nil)
    }
}
