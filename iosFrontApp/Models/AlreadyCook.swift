//
//  AlreadyCook.swift
//  iosFrontApp
//
//  Created by Cedric Ait sahel on 11/02/2024.
//

import Foundation

class AlreadyCook {
    
    var alreadyCookedRecipeId : Int?
    var cookedTime : Int?
    var alreadyCookedId:String?
    
    init(alreadyCookedRecipeId: Int? = nil, cookedTime: Int? = nil,alreadyCookedId:String? = nil) {
        self.alreadyCookedRecipeId = alreadyCookedRecipeId
        self.cookedTime = cookedTime
        self.alreadyCookedId = alreadyCookedId
    }
    
    static func fromJSON(dict: [String:Any]) -> AlreadyCook?{
        guard let alreadyCookedId = (dict["AlreadyCookedId"] as? String),
              let recipeId = (dict["alreadyCookedRecipeId"] as? Int) else{
            return nil
        }
        
        
        return AlreadyCook(alreadyCookedRecipeId: recipeId,alreadyCookedId: alreadyCookedId)
    }
}
