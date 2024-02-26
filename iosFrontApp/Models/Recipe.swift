//
//  Recipe.swift
//  iosFrontApp
//
//  Created by Cedric Ait sahel on 10/02/2024.
//

import Foundation

class Recipe: CustomStringConvertible {
    var meal:Meal

    var alreadyCooked:AlreadyCook? = nil
    var favorite: Favorite? = nil
    var description: String {
        return "\nMeal(\nid: \(self.meal.idMeal),\n strMeal: \(self.meal.strMeal),\n strMealThumb: \(self.meal.strMealThumb),\n strYoutube: \(self.meal.strYoutube)\n strArea: \(self.meal.strArea),\n strInstructions: \(self.meal.strInstructions),\n strSource: \(self.meal.strSource),\n dateModified: \(self.meal.dateModified),\n strImageSource:\(self.meal.strImageSource),\n strCategory:\(self.meal.strCategory),\n strDrinkAlternate: \(self.meal.strDrinkAlternate),\n strIngredient1: \(self.meal.strIngredient1),\n strIngredient2: \(self.meal.strIngredient2),\n strIngredient3: \(self.meal.strIngredient3),\n strIngredient4: \(self.meal.strIngredient4),\n strIngredient5: \(self.meal.strIngredient5),\n strIngredient6: \(self.meal.strIngredient6),\n strIngredient7: \(self.meal.strIngredient7),\n strIngredient8: \(self.meal.strIngredient8),\n strIngredient9: \(self.meal.strIngredient9),\n strIngredient10: \(self.meal.strIngredient10),\n strIngredient11: \(self.meal.strIngredient11),\n strIngredient12: \(self.meal.strIngredient13),\n strIngredient14: \(self.meal.strIngredient14),\n strIngredient15: \(self.meal.strIngredient15),\n strIngredient16: \(self.meal.strIngredient16),\n strIngredient17: \(self.meal.strIngredient17),\n strIngredient18: \(self.meal.strIngredient18),\n strIngredient19: \(self.meal.strIngredient19),\n strIngredient20: \(self.meal.strIngredient20),\n strMeasure1: \(self.meal.strMeasure1),\n strMeasure2: \(self.meal.strMeasure2),\n strMeasure3: \(self.meal.strMeasure3),\n strMeasure4: \(self.meal.strMeasure4),\n strMeasure5: \(self.meal.strMeasure5),\n strMeasure6: \(self.meal.strMeasure6),\n strMeasure7: \(self.meal.strMeasure7),\n strMeasure8: \(self.meal.strMeasure8),\n strMeasure9: \(self.meal.strMeasure9),\n strMeasure10: \(self.meal.strMeasure10),\n strMeasure11: \(self.meal.strMeasure11),\n strMeasure12: \(self.meal.strMeasure12),\n strMeasure13: \(self.meal.strMeasure13),\n strMeasure14: \(self.meal.strMeasure14),\n strMeasure15: \(self.meal.strMeasure15),\n strMeasure16: \(self.meal.strMeasure16),\n strMeasure17: \(self.meal.strMeasure17),\n strMeasure18: \(self.meal.strMeasure18),\n strMeasure19: \(self.meal.strMeasure19),\n strMeasure20: \(self.meal.strMeasure20)\n),\n favorite: \(self.favorite)\n)\n"
    }
    
    
    init(meal: Meal,favorite:Favorite? = nil) {
        self.meal = meal
        //self.alreadyCooked = alreadyCooked?
        self.favorite = favorite
    }
    
    static func fromJSON(dict: [String:Any]) -> Recipe? {
        
        
        guard let mealDict = dict["meal"] as? [String: Any] else {
            print("ERR")
            return nil
        }
        
        
        let favoriteDict = dict["favorite"] as? [String:Any]
        var favorite: Favorite? = nil
    
        
        
        guard let singleObjectArray = dict["favorite"] as? [Any] else {
            return nil;
        }
        
        var test:(Any)? = nil
        if(singleObjectArray.count != 0){
            test = singleObjectArray[0] as? [String:Any]
        }
        
        
        //print(test!["userId"] as! String)
        
        
        
        if(test != nil){
            favorite = Favorite.fromJSON(dict:test as! [String : Any])
        }
        
        let strYoutube = mealDict["strYoutube"] as! String
        let idMeal = Int(mealDict["idMeal"]! as! String)!
        let strMeal = mealDict["strMeal"]! as! String
        let strMealThumb = mealDict["strMealThumb"]! as! String
        let strArea  = mealDict["strArea"]! as! String
        let strInstructions = mealDict["strInstructions"]! as! String
        let strSource = mealDict["strSource"] as? String
        let dateModified = mealDict["dateModified"]! as? String
        let strImageSource = mealDict["strImageSource"]! as? String
        let strCategory = mealDict["strCategory"]! as? String
        let strDrinkAlternate = mealDict["strDrinkAlternate"]! as? String
        let strIngredient1 = mealDict["strIngredient1"]! as? String
        let strIngredient2 = mealDict["strIngredient2"]! as? String
        let strIngredient3 = mealDict["strIngredient3"]! as? String
        let strIngredient4 = mealDict["strIngredient4"]! as? String
        let strIngredient5 = mealDict["strIngredient5"]! as? String
        let strIngredient6 = mealDict["strIngredient6"]! as? String
        let strIngredient7 = mealDict["strIngredient7"]! as? String
        let strIngredient8 = mealDict["strIngredient8"]! as? String
        let strIngredient9 = mealDict["strIngredient9"]! as? String
        let strIngredient10 = mealDict["strIngredient10"]! as? String
        let strIngredient11 = mealDict["strIngredient11"]! as? String
        let strIngredient12 = mealDict["strIngredient12"]! as? String
        let strIngredient13 = mealDict["strIngredient13"]! as? String
        let strIngredient14 = mealDict["strIngredient14"]! as? String
        let strIngredient15 = mealDict["strIngredient15"]! as? String
        let strIngredient16 = mealDict["strIngredient16"]! as? String
        let strIngredient17 = mealDict["strIngredient17"]! as? String
        let strIngredient18 = mealDict["strIngredient18"]! as? String
        let strIngredient19 = mealDict["strIngredient19"]! as? String
        let strIngredient20 = mealDict["strIngredient20"]! as? String
        let strMeasure1 = mealDict["strMeasure1"]! as? String
        let strMeasure2 = mealDict["strMeasure2"]! as? String
        let strMeasure3 = mealDict["strMeasure3"]! as? String
        let strMeasure4 = mealDict["strMeasure4"]! as? String
        let strMeasure5 = mealDict["strMeasure5"]! as? String
        let strMeasure6 = mealDict["strMeasure6"]! as? String
        let strMeasure7 = mealDict["strMeasure7"]! as? String
        let strMeasure8 = mealDict["strMeasure8"]! as? String
        let strMeasure9 = mealDict["strMeasure9"]! as? String
        let strMeasure10 = mealDict["strMeasure10"]! as? String
        let strMeasure11 = mealDict["strMeasure11"]! as? String
        let strMeasure12 = mealDict["strMeasure12"]! as? String
        let strMeasure13 = mealDict["strMeasure13"]! as? String
        let strMeasure14 = mealDict["strMeasure14"]! as? String
        let strMeasure15 = mealDict["strMeasure15"]! as? String
        let strMeasure16 = mealDict["strMeasure16"]! as? String
        let strMeasure17 = mealDict["strMeasure17"]! as? String
        let strMeasure18 = mealDict["strMeasure18"]! as? String
        let strMeasure19 = mealDict["strMeasure19"]! as? String
        let strMeasure20 = mealDict["strMeasure20"]! as? String
    
        

        let meal = Meal(strYoutube: strYoutube,
                        idMeal: idMeal,
                        strMeal: strMeal,
                        strMealThumb: strMealThumb,
                        strArea: strArea,
                        strInstructions: strInstructions,
                        strSource: strSource,
                        dateModified: dateModified,
                        strImageSource: strImageSource,
                        strCategory: strCategory,
                        strDrinkAlternate: strDrinkAlternate,
                        strIngredient1: strIngredient1,
                        strIngredient2: strIngredient2,
                        strIngredient3: strIngredient3,
                        strIngredient4: strIngredient4,
                        strIngredient5: strIngredient5,
                        strIngredient6: strIngredient6,
                        strIngredient7: strIngredient7,
                        strIngredient8: strIngredient8,
                        strIngredient9: strIngredient9,
                        strIngredient10: strIngredient10,
                        strIngredient11: strIngredient11,
                        strIngredient12: strIngredient12,
                        strIngredient13: strIngredient13,
                        strIngredient14: strIngredient14,
                        strIngredient15: strIngredient15,
                        strIngredient16: strIngredient16,
                        strIngredient17: strIngredient17,
                        strIngredient18: strIngredient18,
                        strIngredient19: strIngredient19,
                        strIngredient20: strIngredient20,
                        strMeasure1: strMeasure1,
                        strMeasure2: strMeasure2,
                        strMeasure3: strMeasure3,
                        strMeasure4: strMeasure4,
                        strMeasure5: strMeasure5,
                        strMeasure6: strMeasure6,
                        strMeasure7: strMeasure7,
                        strMeasure8: strMeasure8,
                        strMeasure9: strMeasure9,
                        strMeasure10: strMeasure10,
                        strMeasure11: strMeasure11,
                        strMeasure12: strMeasure12,
                        strMeasure13: strMeasure13,
                        strMeasure14: strMeasure14,
                        strMeasure15: strMeasure15,
                        strMeasure16: strMeasure16,
                        strMeasure17: strMeasure17,
                        strMeasure18: strMeasure18,
                        strMeasure19: strMeasure19,
                        strMeasure20: strMeasure20
                        
                        
                        
        )
        
        return Recipe(meal: meal,favorite:favorite)
        
    }
}
