//
//  Auth.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import Foundation
import Firebase

class Auth  {
    static let inst = Auth()
    
    func signupUser(withEmail email:String,andPassword password:String,completion: @escaping (_ res:Bool,_ error:Error?)->()){
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { (dataRes, error) in
            guard let user = dataRes?.user else{
                completion(false,error)
                return
            }
            let data = ["provider":user.providerID,"email":user.email]
            FirebaseStore.inst.createDBUser(uid: user.uid, data: data as Dictionary<String, Any>)
            completion(true,nil)
        }
    }
    
    func signinUser(withEmail email:String,andPassword password:String,completion: @escaping (_ res:Bool,_ error:Error?)->()){
        Firebase.Auth.auth().signIn(withEmail: email, password: password) { (dataRes, error) in
            guard (dataRes?.user) != nil else {
                completion(false,error)
                return
            }
            completion(true,nil)
        }
    }
    
    
    
    func logout(){
        do{
            try Firebase.Auth.auth().signOut()
        }catch{
            debugPrint(error.localizedDescription)
        }
    }
}
