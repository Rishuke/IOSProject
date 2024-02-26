

import UIKit

class PatchNoteViewController: UIViewController {
    @IBOutlet weak var titre: UITextField!
    
    
    
    @IBOutlet weak var mark: UILabel!
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var warning: UILabel!
    
    var grade:String? = "2"
    
    var token:String?
    
    var note: Note!



  
    func patchNote(){
        let url = URL(string: "http://51.91.10.19:2666/notes/\(note.noteId!)")!
        
        
        print("\(self.titre.text!) \(self.text.text!) \(self.grade!)")
        let body = ["title": self.titre.text!, "payload": self.text.text!, "grade": self.grade!, "idRecette": "food"]
        
        
        guard let JSONbody = try? JSONSerialization.data(withJSONObject: body) else{return}
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        self.token = appdelegate.token
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("BEARER \(self.token!)", forHTTPHeaderField: "Authorization")
        request.httpBody = JSONbody
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            
            guard let answerSuceces = json as? [String : Any] else {return}
            
            
            print(answerSuceces)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Note supprimée avec succès")
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(UserNoteViewController(), animated: true)
                }
            } else {
                print("La suppression de la note a échoué")
            }
            return
    
                
                
           
        }
        task.resume()
                
                
                
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titre.text = note.title!
        self.mark.text = "\(note.grade!) /5"
        self.text.text = note.payload!
        self.grade = "\(note.grade!)"
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
                
                patchNote()
    }
    
    
    @IBAction func slider(_ sender: UISlider) {
        mark.text = "\(Int(sender.value)) /5"
        grade = "\(Int(sender.value))"
    }
    
    static func newInstance(note: Note) -> PatchNoteViewController {
        let notePageViewController = PatchNoteViewController()
        
        notePageViewController.note = note
        return notePageViewController
    }

    
    @IBAction func supprimer(_ sender: Any) {
        guard let noteId = note?.noteId else {
                print("L'ID de la note est manquant")
                return
            }

            let urlString = "http://51.91.10.19:2666/notes/\(noteId)"
            guard let url = URL(string: urlString) else {
                print("L'URL est invalide")
                return
            }
        
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            self.token = appdelegate.token

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("BEARER \(token!)", forHTTPHeaderField: "Authorization")

            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Erreur lors de la suppression de la note: \(error.localizedDescription)")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("Note supprimée avec succès")
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(UserNoteViewController(), animated:true)
                    }
                } else {
                    print("La suppression de la note a échoué")
                }
            }
            task.resume()
    }
}

