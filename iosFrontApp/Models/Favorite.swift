//
//  Favorite.swift
//  iosFrontApp
//
//  Created by Cedric Ait sahel on 11/02/2024.
//

import Foundation

class Favorite:CustomStringConvertible {
    var description: String {
        return "Favorite"
    }
    
    var favoriteRecipeId:Int
    var favoriteId:String
    var updatedAt:String
    var userId:String
    var createdAt:String
    init(favoriteRecipeId: Int,userId:String,createdAt:String,updatedAt:String,favoriteId:String) {
        self.favoriteRecipeId = favoriteRecipeId
        self.createdAt = createdAt
        self.userId = userId
        self.updatedAt = updatedAt
        self.favoriteId = favoriteId
        
    }
    
    
    static func fromJSON(dict: [String:Any]) -> Favorite? {
        guard let favoriteDict = dict as? [String: Any] else {
            return nil
        }
        let favoriteId = favoriteDict["favoriteId"]
        let createdAt = favoriteDict["createdAt"]
        let updatedAt = favoriteDict["updatedAt"]
        let userId = favoriteDict["userId"]
        if((favoriteDict["favoriteRecipeId"] as? String) != nil) {
            let favoriteRecipeId = Int(favoriteDict["favoriteRecipeId"] as! String)
            return Favorite(favoriteRecipeId: favoriteRecipeId! , userId: userId as! String, createdAt: createdAt as! String, updatedAt: updatedAt as! String, favoriteId: favoriteId as! String)
        } else {
            let favoriteRecipeId = favoriteDict["favoriteRecipeId"] as! Int
            return Favorite(favoriteRecipeId: favoriteRecipeId , userId: userId as! String, createdAt: createdAt as! String, updatedAt: updatedAt as! String, favoriteId: favoriteId as! String)
        }

    }
    
}
