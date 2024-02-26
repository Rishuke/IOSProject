//
//  PatchUserViewController.swift
//  iosFrontApp
//
//  Created by Etudiant on 12/02/2024.
//

import UIKit
import UserNotifications

class PatchUserViewController: UIViewController {
    
    @IBOutlet weak var firstNameValue: UITextField!
    @IBOutlet weak var lastNameValue: UITextField!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var confirmPasswordValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    
    @IBOutlet weak var firstNameError: UILabel!
    @IBOutlet weak var lastNameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var samePasswordError: UILabel!
    
    var firstName:String = ""
    var lastName:String = ""
    var email:String = ""
    
    
    var token:String?
    
    func patchUser(){
        let url = URL(string: "http://51.91.10.19:2666/users")!
        
        
        var body:Any = []
        
        if passwordValue.text=="" {
            body=["email":emailValue.text!,"firstName":firstNameValue.text!,"name":lastNameValue.text!]
        }
        else{
            body=["email":emailValue.text!,"password":passwordValue.text!,"firstName":firstNameValue.text!,"name":lastNameValue.text!]
        }
        
        guard let JSONbody = try? JSONSerialization.data(withJSONObject: body) else{return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("BEARER \(self.token!)", forHTTPHeaderField: "Authorization")
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
                        self.firstNameError.text = firstName
                    }
                    else{self.firstNameError.text = ""}
                    
                    if let name = finalAnswer.name{
                        self.lastNameError.text = name
                    }
                    else{self.lastNameError.text = ""}
                    
                    if let password = finalAnswer.password{
                        self.passwordError.text = password
                    }
                    else{self.passwordError.text = ""}
                    
                    if let email = finalAnswer.email{
                        self.emailError.text = email
                    }
                    else{self.emailError.text = ""}
                }
                return
            }
            
            DispatchQueue.main.async {
                
                let alertController = UIAlertController(title: "Modification de vos données réaliser avec succès \(self.firstName)",message: "", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default){ _ in
                    self.navigationController?.pushViewController(GetUserViewController(), animated: true)
                }
                
                alertController.addAction(action)
                self.present(alertController,animated: true,completion: nil)
            }
        }
        task.resume()
    }
    
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
            self.firstName = userParse.firstName
            self.lastName = userParse.name
            self.email = userParse.email
            
            
            DispatchQueue.main.async {
                self.firstNameValue.text = userParse.firstName
                self.lastNameValue.text = userParse.name
                self.emailValue.text  = userParse.email
            }
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        
        self.lastNameError.text = ""
        self.firstNameError.text = ""
        self.emailError.text = ""
        self.passwordError.text = ""
        self.samePasswordError.text = ""
    }
    
    @IBAction func resetToDefault(_ sender: Any) {
        self.firstNameValue.text = firstName
        self.lastNameValue.text = lastName
        self.emailValue.text = email
        self.passwordValue.text = ""
        self.confirmPasswordValue.text = ""
        
        self.emailError.text = ""
        self.passwordError.text = ""
        self.samePasswordError.text = ""
        self.firstNameError.text = ""
        self.lastNameError.text = ""
    }
    
    @IBAction func sendData(_ sender: Any) {
        
        var oneFieldIsEmpty : Int = 0
        
        if self.passwordValue.text != self.confirmPasswordValue.text {
            self.samePasswordError.text = "Mot de passe non identique"
            return
        }
        
        if self.firstNameValue.text == "" {
            self.firstNameError.text = "Merci de renseigner ce champ"
            oneFieldIsEmpty = 1
        }
        
        if self.emailValue.text == "" {
            self.emailError.text = "Merci de renseigner ce champ"
            oneFieldIsEmpty = 1
        }
        
        if self.lastNameValue.text == "" {
            self.lastNameError.text = "Merci de renseigner ce champ"
            oneFieldIsEmpty = 1
        }
        
        if oneFieldIsEmpty == 1 {return}
        
        patchUser()
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
