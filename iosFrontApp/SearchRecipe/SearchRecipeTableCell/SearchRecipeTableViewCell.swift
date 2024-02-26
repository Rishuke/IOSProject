//
//  SearchRecipeTableViewCell.swift
//  iosFrontApp
//
//  Created by Cedric Ait sahel on 11/02/2024.
//

import UIKit

class SearchRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
                
                self.imageCell.image = image
            }
        }
        
        dataTask.resume()
    }
    
    func reload(with recipe:Recipe){
        self.recipeTitleLabel.text = "\(recipe.meal.strMeal)"
        getImage(recipe: recipe)
    }
    
}
