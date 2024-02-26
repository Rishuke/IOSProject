//
//  DetailRecipeIngredientTableViewCell.swift
//  iosFrontApp
//
//  Created by Cedric Ait sahel on 11/02/2024.
//

import UIKit

class DetailRecipeIngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var measureLabel: UILabel!
    @IBOutlet weak var ingredientLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reload(with ingredient:Ingredient){
        self.measureLabel.text = ingredient.measure
        self.ingredientLabel.text = ingredient.ingredient
    }
    
}
