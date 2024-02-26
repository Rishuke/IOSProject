//
//  InscriptionViewController.swift
//  iosFrontApp
//
//  Created by Etudiant on 22/12/2023.
//

import UIKit

class InscriptionViewController: UIViewController {

    @IBOutlet weak var firstNameValue: UITextField!
    @IBOutlet weak var nameValue: UITextField!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    @IBOutlet weak var confirmPasswordValue: UITextField!
    
    
    
    @IBOutlet weak var prenomAPIMessage: UILabel!
    @IBOutlet weak var nomAPIMessage: UILabel!
    @IBOutlet weak var emailAPIMessage: UILabel!
    @IBOutlet weak var passwordAPIMessage: UILabel!
    @IBOutlet weak var confirmPasswordMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prenomAPIMessage.text=""
        nomAPIMessage.text=""
        emailAPIMessage.text=""
        passwordAPIMessage.text=""
        confirmPasswordMessage.text=""
    }
    
    func apiInscription(){
        let url = URL(string: "http://51.91.10.19:2666/users")!
        
        let body = ["email":emailValue.text!,"password":passwordValue.text!,"firstName":firstNameValue.text!,"name":nameValue.text!]
        
        guard let JSONbody = try? JSONSerialization.data(withJSONObject: body) else{return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = JSONbody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else{
                
                guard let answer = json as? [String:Any] else{return}
                
                guard let res = ParseUserCreationError.fromJSON(dict:answer) else{return}
                
                guard let finalAnswer = ParseMessageErrorInscription.fromJSON(dict:res.message) else{return}
                
                
                
                DispatchQueue.main.async{
                    if let firstName = finalAnswer.firstName{
                        self.prenomAPIMessage.text = firstName
                    }
                    else{self.prenomAPIMessage.text = ""}
                    
                    if let name = finalAnswer.name{
                        self.nomAPIMessage.text = name
                    }
                    else{self.nomAPIMessage.text = ""}
                    
                    if let password = finalAnswer.password{
                        self.passwordAPIMessage.text = password
                    }
                    else{self.passwordAPIMessage.text = ""}
                    
                    if let email = finalAnswer.email{
                        self.emailAPIMessage.text = email
                    }
                    else{self.emailAPIMessage.text = ""}
                }
                return
            }
            
            
            guard let answerSuccess = json as? [String : Any] else {return}
            
            guard let resSuccess = ParseUserSucces.fromJSON(dict: answerSuccess) else {return}
            
            //guard let UserRes = ParseUser.fromJSON(dict: resSuccess.user) else{return}
            
            DispatchQueue.main.async {
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                
                appdelegate.token = resSuccess.token
                self.navigationController?.pushViewController(PostNoteViewController(), animated: true)
            }
            
            //cas ou la connexion fonctionne
            //HomePageViewController
        }
        task.resume()
    }
    
    @IBAction func validateInscription(_ sender: Any) {
        emailAPIMessage.text = ""
        prenomAPIMessage.text = ""
        nomAPIMessage.text = ""
        emailAPIMessage.text = ""
        passwordAPIMessage.text = ""
        confirmPasswordMessage.text = ""
        if(self.passwordValue.text != self.confirmPasswordValue.text){
            self.confirmPasswordMessage.text = "Mot de passe non identique"
            return
        }
        else{self.confirmPasswordMessage.text = ""}
        
        apiInscription()
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
