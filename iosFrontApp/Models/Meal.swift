//
//  Meal.swift
//  iosFrontApp
//
//  Created by Cedric Ait sahel on 11/02/2024.
//

import Foundation

class Meal {
    
    var strYoutube: String;
    var idMeal: Int
    var strMeal: String
    var strMealThumb: String
    var strArea: String
    var strInstructions: String
    var strSource: String?
    var dateModified: String?
    var strImageSource: String?
    var strCategory: String?
    var strDrinkAlternate: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    
    
    
    
    
    init(strYoutube: String,
         idMeal:Int, strMeal:String,
         strMealThumb:String,strArea:String,
         strInstructions:String,
         strSource:String? = nil,
         dateModified:String? = nil,
         strImageSource:String? = nil,
         strCategory:String? = nil,
         strDrinkAlternate:String? = nil,
         strIngredient1:String? = nil,
         strIngredient2:String? = nil,
         strIngredient3:String? = nil,
         strIngredient4:String? = nil,
         strIngredient5:String? = nil,
         strIngredient6:String? = nil,
         strIngredient7:String? = nil,
         strIngredient8:String? = nil,
         strIngredient9:String? = nil,
         strIngredient10:String? = nil,
         strIngredient11:String? = nil,
         strIngredient12:String? = nil,
         strIngredient13:String? = nil,
         strIngredient14:String? = nil,
         strIngredient15:String? = nil,
         strIngredient16:String? = nil,
         strIngredient17:String? = nil,
         strIngredient18:String? = nil,
         strIngredient19:String? = nil,
         strIngredient20:String? = nil,
         strMeasure1:String? = nil,
         strMeasure2:String? = nil,
         strMeasure3:String? = nil,
         strMeasure4:String? = nil,
         strMeasure5:String? = nil,
         strMeasure6:String? = nil,
         strMeasure7:String? = nil,
         strMeasure8:String? = nil,
         strMeasure9:String? = nil,
         strMeasure10:String? = nil,
         strMeasure11:String? = nil,
         strMeasure12:String? = nil,
         strMeasure13:String? = nil,
         strMeasure14:String? = nil,
         strMeasure15:String? = nil,
         strMeasure16:String? = nil,
         strMeasure17:String? = nil,
         strMeasure18:String? = nil,
         strMeasure19:String? = nil,
         strMeasure20:String? = nil
         
         
    ) {
        self.strYoutube = strYoutube
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strSource = strSource
        self.dateModified = dateModified
        self.strImageSource = strImageSource
        self.strCategory = strCategory
        self.strDrinkAlternate = strDrinkAlternate
        self.strIngredient1 = strIngredient1
        self.strIngredient2 = strIngredient2
        self.strIngredient3 = strIngredient3
        self.strIngredient4 = strIngredient4
        self.strIngredient5 = strIngredient5
        self.strIngredient6 = strIngredient6
        self.strIngredient7 = strIngredient7
        self.strIngredient8 = strIngredient8
        self.strIngredient9 = strIngredient9
        self.strIngredient10 = strIngredient10
        self.strIngredient11 = strIngredient11
        self.strIngredient12 = strIngredient12
        self.strIngredient13 = strIngredient13
        self.strIngredient14 = strIngredient14
        self.strIngredient15 = strIngredient15
        self.strIngredient16 = strIngredient16
        self.strIngredient17 = strIngredient17
        self.strIngredient18 = strIngredient18
        self.strIngredient19 = strIngredient19
        self.strIngredient20 = strIngredient20
        self.strMeasure1 = strMeasure1
        self.strMeasure2 = strMeasure2
        self.strMeasure3 = strMeasure3
        self.strMeasure4 = strMeasure4
        self.strMeasure5 = strMeasure5
        self.strMeasure6 = strMeasure6
        self.strMeasure7 = strMeasure7
        self.strMeasure8 = strMeasure8
        self.strMeasure9 = strMeasure9
        self.strMeasure10 = strMeasure10
        self.strMeasure11 = strMeasure11
        self.strMeasure12 = strMeasure12
        self.strMeasure13 = strMeasure13
        self.strMeasure14 = strMeasure14
        self.strMeasure15 = strMeasure15
        self.strMeasure16 = strMeasure16
        self.strMeasure17 = strMeasure17
        self.strMeasure18 = strMeasure18
        self.strMeasure19 = strMeasure19
        self.strMeasure20 = strMeasure20
    }
    
    func getIngredient() -> [Ingredient] {
        var ingredientsString : [String?] = [
            self.strIngredient1,
            self.strIngredient2,
            self.strIngredient3,
            self.strIngredient4,
            self.strIngredient5,
            self.strIngredient6,
            self.strIngredient7,
            self.strIngredient8,
            self.strIngredient9,
            self.strIngredient10,
            self.strIngredient11,
            self.strIngredient12,
            self.strIngredient13,
            self.strIngredient14,
            self.strIngredient15,
            self.strIngredient16,
            self.strIngredient17,
            self.strIngredient18,
            self.strIngredient19,
            self.strIngredient20,
        ]
        
        var measureString : [String?] = [
            self.strMeasure1,
            self.strMeasure2,
            self.strMeasure3,
            self.strMeasure4,
            self.strMeasure5,
            self.strMeasure6,
            self.strMeasure7,
            self.strMeasure8,
            self.strMeasure9,
            self.strMeasure10,
            self.strMeasure11,
            self.strMeasure12,
            self.strMeasure13,
            self.strMeasure14,
            self.strMeasure15,
            self.strMeasure16,
            self.strMeasure17,
            self.strMeasure18,
            self.strMeasure19,
            self.strMeasure20,
        ]
        
        var ingredients: [Ingredient] = []
        
        for i in 1...19 {
            if(!ingredientsString[i]!.isEmpty) {
                var ingredient = Ingredient(ingredient: ingredientsString[i]!, measure: measureString[i]!)
                ingredients.append(ingredient)
            }

        }
        
        
        return ingredients
    }
    
}
