//
//  GetUserViewController.swift
//  iosFrontApp
//
//  Created by Etudiant on 12/02/2024.
//

import UIKit

class GetUserViewController: UIViewController {
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var dateCreation: UILabel!
    
    var token : String?
    
    func getUser(){
        let url = URL(string: "http://51.91.10.19:2666/users")!
        
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        self.token = appdelegate.token
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("BEARER \(self.token!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            print(dataIsNotNull)
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let answerSuccess = json as? [String:Any] else{return}
            
            guard let resSuccess = ParseGetUser.fromJSON(dict: answerSuccess) else {return}
            
            guard let userParse = ParseUser.fromJSON(dict: resSuccess.user) else{return}
            
            DispatchQueue.main.async {
                self.firstName.text = "Prénom : \(userParse.firstName)"
                self.lastName.text = "Nom : \(userParse.name)"
                self.email.text = "Email : \(userParse.email)"
                self.dateCreation.text = "Vous êtes membre depuis le \(String(userParse.createdAt.prefix(10)))"
            }
        }
        task.resume()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
    }

    
    

    @IBAction func GoToModifcation(_ sender: Any) {
        self.navigationController?.pushViewController(PatchUserViewController(), animated: true)
    }
    @IBAction func GoToAcceuil(_ sender: Any) {
    }
}
