//
//  ParseUserCreationError.swift
//  iosFrontApp
//
//  Created by Etudiant on 27/01/2024.
//

import Foundation

class ParseMessageErrorInscription{
    var email : String? = nil
    var password : String? = nil
    var firstName : String? = nil
    var name : String? = nil
    
    init(email : String?,password:String?,firstName:String?,name:String?){
        self.email = email
        self.password = password
        self.firstName = firstName
        self.name = name
    }
    
    static func fromJSON(dict:[String:Any])->ParseMessageErrorInscription?{
        var email:String? = nil
        var password:String? = nil
        var firstName:String? = nil
        var name:String? = nil
        if let emailError = dict["email"]{
            email = emailError as? String
        }
        if let passwordError = dict["password"]{
            password = passwordError as? String
        }
        if let firstNameError = dict["firstName"]{
            firstName = firstNameError as? String
        }
        if let nameError = dict["name"]{
            name = nameError as? String
        }
        return ParseMessageErrorInscription(email: email, password: password, firstName: firstName, name: name)
    }
}

class ParseUserCreationError{
    var message: [String:Any]
    
    init(message:[String:Any]){
        self.message = message
    }
    
    static func fromJSON(dict:[String:Any])->ParseUserCreationError?{
        guard let messageRes = dict["message"] as? [String:Any] else{return nil}
        
        return ParseUserCreationError(message: messageRes)
    }
}

class ParseUserSucces{
    let message: String
    let token:String
    let user:[String:Any]
    
    init(message:String,token:String,user:[String:Any]){
        self.message = message
        self.token = token
        self.user = user
    }
    
    static func fromJSON(dict:[String:Any])->ParseUserSucces?{
        guard let message = dict["message"] as? String,
              let token = dict["token"] as? String,
              let user = dict["user"] as? [String:Any] else{return nil}
        
        return ParseUserSucces(message: message, token: token, user: user)
    }
}

class ParseUser{
    let userId : String
    let name: String
    let firstName: String
    let email : String
    let password : String
    let createdAt : String
    let updatedAt: String
    
    init(userId:String,name:String,firstName:String,email:String,passwd:String,crea:String,update:String){
        self.userId = userId
        self.name = name
        self.firstName = firstName
        self.email = email
        self.password = passwd
        self.createdAt = crea
        self.updatedAt = update
    }
    
    static func fromJSON(dict:[String:Any])->ParseUser?{
        guard let userId = dict["userId"] as? String,
              let name = dict["name"] as? String,
              let firstName = dict["firstName"] as? String,
              let email = dict["email"] as? String,
              let passwd = dict["password"] as? String,
              let crea = dict["createdAt"] as? String,
              let upda = dict["updatedAt"] as? String else{return nil}
        
        return ParseUser(userId: userId, name: name, firstName: firstName, email: email, passwd: passwd, crea: crea, update: upda)
    }
}

class ParseGetUser{
    let message : String
    let user : [String:Any]
    
    init(message:String,user:[String:Any]){
        self.message = message
        self.user = user
    }
    
    static func fromJSON(dict:[String:Any])->ParseGetUser?{
        guard let userRes = dict["user"] as? [String:Any],
        let messageRes = dict["message"] as? String else{return nil}
        
        return ParseGetUser(message: messageRes, user: userRes)
    }

}
