//
//  SearchRecipeViewController.swift
//  iosFrontApp
//
//  Created by Cedric Ait sahel on 10/02/2024.
//

import UIKit

class SearchRecipeViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {

    
    var recipes: [Recipe] = []
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var recipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchField.placeholder = "recherche"
        self.searchField.delegate = self
        
        let cellNib = UINib(nibName: "SearchRecipeTableViewCell", bundle: nil)
        self.recipeTableView.register(cellNib, forCellReuseIdentifier: "RECIPE_CELL_ID")
        self.recipeTableView.dataSource = self
        self.recipeTableView.delegate = self
        
        // Do any additional setup after loading the view.
        fetchRecipe()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if(self.searchField.text!.count > 0) {
            fetchRecipe(name: self.searchField.text)
        } else {
            fetchRecipe()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = self.recipes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RECIPE_CELL_ID",for: indexPath) as! SearchRecipeTableViewCell
        cell.reload(with: recipe)
        return cell
    }
    
    
    func fetchRecipe(name:String? = nil) -> Void {
        let url = URL(string: "http://localhost:3000/meals")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var test = name != nil ? name! : "a"
        let body = ["option":"name","value":"\(test)"]
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        guard let json = try? JSONSerialization.data(withJSONObject: body) else
        {
            return
        }

        request.httpBody = json
        request.setValue("BEARER eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5MjVmOWZhNS1lMjAzLTQ4NDUtYjIzYS1iM2Q2ODMzMWU5MjciLCJpYXQiOjE3MDc4Mzc3MTYsImV4cCI6MTcwNzg1NTcxNn0.p_6ghFfzL---kArPyRBz-g8VuIKN0BOeE7xy3DJpbeA", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            guard let json = try? JSONSerialization.jsonObject(with: data) else {
                
                return
            }
            
            guard let arrayMeal = json as? [[String:Any]] else {
                self.recipes = []
                DispatchQueue.main.async {
                    self.recipeTableView.reloadData()
                }
                return
            }
            

            
            
            
            self.recipes = arrayMeal.compactMap(Recipe.fromJSON(dict:))
            DispatchQueue.main.async {
                self.recipeTableView.reloadData()
            }
            
        }
        
        task.resume()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(self.meals[indexPath.row])
        self.navigationController?.pushViewController(DetailRecipeViewController.newInstance(recipe: self.recipes[indexPath.row]), animated: true)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
