//
//  PostNoteViewController.swift
//  iosFrontApp
//
//  Created by Etudiant on 17/02/2024.
//

import UIKit

class PostNoteViewController: UIViewController {

    @IBOutlet weak var mark: UILabel!
    
    @IBOutlet weak var text: UITextView!
    
  
    @IBOutlet weak var warning: UILabel!
    @IBOutlet weak var titre: UITextField!
    
    var grade:String? = "2"
    
    
    var token:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func postNote(){
        let url = URL(string: "http://51.91.10.19:2666/notes")!
        
        
        
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        self.token = appdelegate.token

    
        
        let body = ["title": self.titre.text!, "payload": self.text.text!, "grade": self.grade!, "idRecette": "food"]

       
          
       
        
        
        guard let JSONbody = try? JSONSerialization.data(withJSONObject: body) else{return}
        
        print("here")
        
        var request = URLRequest(url: url)
    
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("BEARER \(self.token!)", forHTTPHeaderField: "Authorization")
        request.httpBody = JSONbody
        
        print("here")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else{return}
            print("here")
            guard let dataIsNotNull = data else{return}
            print("here"
            )
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            print("here")
            
           
            
            guard let answerSuccess = json as? [String : Any] else {return}
            
            //print(answerSuccess)
            
           
            
            DispatchQueue.main.async{
                
                let splitViewController = UISplitViewController()
                
                
                
                splitViewController.viewControllers = [UserNoteViewController(), UIViewController()]
                   
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [
                    
                    splitViewController,
                    
                ]
                
                
                self.navigationController?.pushViewController(tabBarController, animated: true)
                    
                
            return
    
                
                
            }
        }
        task.resume()
        
    }
    

    
    @IBAction func slider(_ sender: UISlider) {
        mark.text = "\(Int(sender.value)) /5"
        grade = "\(Int(sender.value))"
    }
    
    
    
    @IBAction func save(_ sender: UIButton) {
        warning.text = ""
                
               
                if titre.text?.isEmpty ?? true {
                    warning.text = "N'oubliez pas le titre"
                    return
                }
                if text.text?.isEmpty ?? true {
                    warning.text = "Le corps du texte est vide"
                    return
                }
                
                postNote()
        
    }
    
}

    

