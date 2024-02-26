//
//  HomeViewController.swift
//  iosFrontApp
//
//  Created by Etudiant on 22/12/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    
    
    @IBOutlet weak var valueOfAPIMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valueOfAPIMessage.text = ""
    }


    @IBAction func connexion(_ sender: Any) {
        
        let url = URL(string: "http://51.91.10.19:2666/login")!
        
        let body = ["email":emailValue.text!,"password":passwordValue.text!]
        
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
                print("HERE request bug \(json)")
                
                let answer = json as? [String : String]
                
                DispatchQueue.main.async{
                    self.valueOfAPIMessage.text = answer?["message"]!
                }
                return
            }
            
            guard let answerSuccess = json as? [String : Any] else {return}
            
            guard let resSuccess = ParseUserSucces.fromJSON(dict: answerSuccess) else {return}
            
            //guard let UserRes = ParseUser.fromJSON(dict: resSuccess.user) else{return}
            
            DispatchQueue.main.async {
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                
                appdelegate.token = resSuccess.token
                
                print(appdelegate.token!)
                
                print(resSuccess.message)
                
                self.navigationController?.pushViewController(UserNoteViewController(), animated: true)
            }
        }
        task.resume()
    }
    @IBAction func moveToInscription(_ sender: Any) {
        print("Here")
        self.navigationController?.pushViewController(InscriptionViewController(), animated: true)
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
