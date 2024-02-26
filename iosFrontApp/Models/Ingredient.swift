//
//  Ingredient.swift
//  iosFrontApp
//
//  Created by Cedric Ait sahel on 11/02/2024.
//

import Foundation

class Ingredient:CustomStringConvertible {
    var ingredient:String
    var measure:String
    var description: String {
        return "Ingredient(\(self.measure),\(self.ingredient))"
    }
    
    init(ingredient: String, measure: String) {
        self.ingredient = ingredient
        self.measure = measure
    }
}
