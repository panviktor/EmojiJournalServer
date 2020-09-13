import CredentialsHTTP
import SwiftKueryORM

public struct UserAuth: Model {
  public var id: String
  private let password: String
}

extension UserAuth: TypeSafeHTTPBasic {
  
  public static let authenticate =
    ["John": "12345", "Mary": "ABCDE"]
  
  public static func verifyPassword(username: String,
    password: String, callback: @escaping (UserAuth?) -> Void) {
    
    UserAuth.find(id: username) { userAuth, error in
      
      if let userAuth = userAuth {
        if password == userAuth.password {
          callback(userAuth)
          return
        }
      }
        
      callback(nil)
    }
  }
}
