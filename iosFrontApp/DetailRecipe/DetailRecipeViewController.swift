//
//  DetailRecipeViewController.swift
//  iosFrontApp
//
//  Created by Cedric Ait sahel on 10/02/2024.
//

import UIKit

class DetailRecipeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.recipe.meal.getIngredient().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = self.recipe.meal.getIngredient()[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "INGREDIENT_CELL_ID", for: indexPath) as! DetailRecipeIngredientTableViewCell
        cell.reload(with: ingredient)
        return cell
    }
    
    
    var recipe: Recipe!

    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var favorite: UISwitch!
    @IBOutlet weak var alreadyCook: UISwitch!
    @IBOutlet weak var ingredientTable: UITableView!
    
    @IBAction func favoriteHandler(_ sender: Any) {
        if(self.favorite.isOn == true) {
            createFavoris()
        } else {
            deleteFavorite()
        }
    }
    
    @IBAction func alreadyCookHandler(_ sender: Any) {
        if(self.alreadyCook.isOn == true ){
            addToAlreadyCook()
        } else {
            removeAlreadyCook()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage(recipe: self.recipe)
        self.recipeTitle.text = self.recipe.meal.strMeal
        self.sourceLabel.text = self.recipe.meal.strArea
        let cellNib = UINib(nibName: "DetailRecipeIngredientTableViewCell", bundle: nil)
        self.ingredientTable.register(cellNib, forCellReuseIdentifier: "INGREDIENT_CELL_ID")
        self.ingredientTable.dataSource = self
        self.ingredientTable.delegate = self
        self.instructionLabel.text = self.recipe.meal.strInstructions
        if(self.recipe.favorite != nil){
            self.favorite.isOn = true
        } else {
            self.favorite.isOn = false
        }
        
        if(self.recipe.alreadyCooked != nil){
            self.alreadyCook.isOn = true
        } else {
            self.alreadyCook.isOn = false
        }
    }
    
    
    static func newInstance(recipe:Recipe) -> DetailRecipeViewController {
        let detailRecipeViewController = DetailRecipeViewController()
        detailRecipeViewController.recipe = recipe
        return detailRecipeViewController
    }
    
    
    func getImage(recipe:Recipe){
        let imgUrl = URL(string:recipe.meal.strMealThumb)
        let request = URLRequest(url: imgUrl!)
        
        let dataTask = URLSession.shared.dataTask(with: request){
            data,res,err in
            guard err == nil, let downloadedData = data else {
                return
            }
            
            let image = UIImage(data: downloadedData)
            DispatchQueue.main.async {
                
                self.imageRecipe.image = image
            }
        }
        dataTask.resume()
    }
    
    
    
    func createFavoris() {
        self.favorite.isEnabled = false;
        let url = URL(string: "http://localhost:3000/favorites")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let body = ["favoriteRecipeId":self.recipe.meal.idMeal]
        
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        guard let json = try? JSONSerialization.data(withJSONObject: body) else
        {
            return
        }
        
        request.httpBody = json
        
        request.setValue("BEARER eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5MjVmOWZhNS1lMjAzLTQ4NDUtYjIzYS1iM2Q2ODMzMWU5MjciLCJpYXQiOjE3MDc5MTk2ODcsImV4cCI6MTcwNzkzNzY4N30.wNKicJ-QlXljaEwB3JI-DPY9Oa2TEgLH0q5chAvWS3c", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data) else {
                return
            }
            
            guard let recipeFromJson = json as? [String:Any] else {
                return
            }
            
            
            let favorite = Favorite.fromJSON(dict:recipeFromJson)
            self.recipe.favorite = favorite
            
            
            
            DispatchQueue.main.async {
                self.favorite.isEnabled = true
            }
            
        }

        task.resume()
    }
    
    
    func deleteFavorite() {
        self.favorite.isEnabled = false;
        
        let url = URL(string: "http://localhost:3000/favorites/\(self.recipe.favorite?.favoriteId as! String)")
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        
        request.setValue("BEARER eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5MjVmOWZhNS1lMjAzLTQ4NDUtYjIzYS1iM2Q2ODMzMWU5MjciLCJpYXQiOjE3MDc5MTk2ODcsImV4cCI6MTcwNzkzNzY4N30.wNKicJ-QlXljaEwB3JI-DPY9Oa2TEgLH0q5chAvWS3c", forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            guard let json = try? JSONSerialization.jsonObject(with: data) else {
                return
            }
            
            let response = json as? [String:String]
            
            if(response!["message"] == "Recette supprimé de vos favoris") {
                self.recipe.favorite = nil
            }
            
            DispatchQueue.main.async {
                self.favorite.isEnabled = true
            }
            
        }
        
        task.resume()
        
        
    }
    
    
    func addToAlreadyCook(){
        self.alreadyCook.isEnabled = false;
        let url = URL(string: "http://localhost:3000/alreadyCooked")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let body = ["alreadyCookedRecipeId":self.recipe.meal.idMeal]
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.setValue("BEARER eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5MjVmOWZhNS1lMjAzLTQ4NDUtYjIzYS1iM2Q2ODMzMWU5MjciLCJpYXQiOjE3MDc5MTk2ODcsImV4cCI6MTcwNzkzNzY4N30.wNKicJ-QlXljaEwB3JI-DPY9Oa2TEgLH0q5chAvWS3c", forHTTPHeaderField: "Authorization")
        
        guard let json = try? JSONSerialization.data(withJSONObject: body) else
        {
            self.alreadyCook.isEnabled = true;
            return
        }
        
        request.httpBody = json
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                self.alreadyCook.isEnabled = true;
                return
            }
            
            
            guard let json = try? JSONSerialization.jsonObject(with: data) else {
                self.favorite.isEnabled = true;
                self.alreadyCook.isEnabled = true;
                return
            }
            
            guard let alreadyCookFromJson = json as? [String:Any] else {
                self.favorite.isEnabled = true;
                self.alreadyCook.isEnabled = true;
                return
            }
            
            
            let alreadyCook = AlreadyCook.fromJSON(dict: alreadyCookFromJson)
            
            if(alreadyCook != nil ) {
                self.recipe.alreadyCooked = alreadyCook
            }
            
            DispatchQueue.main.async {
                self.alreadyCook.isEnabled = true
            }
            
        }
        
        task.resume()
    }
    
    
    func removeAlreadyCook() {
        self.alreadyCook.isEnabled = false;
        
        let url = URL(string: "http://localhost:3000/alreadyCooked/\(self.recipe.alreadyCooked?.alreadyCookedId as! String)")
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.setValue("BEARER eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5MjVmOWZhNS1lMjAzLTQ4NDUtYjIzYS1iM2Q2ODMzMWU5MjciLCJpYXQiOjE3MDc5MTk2ODcsImV4cCI6MTcwNzkzNzY4N30.wNKicJ-QlXljaEwB3JI-DPY9Oa2TEgLH0q5chAvWS3c", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                self.alreadyCook.isEnabled = true
                return
            }
            
            
            guard let json = try? JSONSerialization.jsonObject(with: data) else {
                self.alreadyCook.isEnabled = true
                return
            }
            
            let response = json as? [String:String]
            
            print(response)
            
            if(response!["message"] == "Recette supprimé de \'Recette déja cuisiné\'") {
                self.recipe.alreadyCooked = nil
            }
            
            DispatchQueue.main.async {
                self.alreadyCook.isEnabled = true
            }
            
        }
        
        task.resume()
    }
    
    
    
}
