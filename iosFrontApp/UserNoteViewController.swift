//
//  UserNoteViewController.swift
//  iosFrontApp
//
//  Created by Etudiant on 17/02/2024.
//

import UIKit

class UserNoteViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var noteTableView: UITableView!
    var notes : [Note] = []
    var token:String?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = self.notes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NOTE_CELL_ID", for: indexPath) as! GetNoteTableViewCell
        
        cell.reload(with: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            // Return the desired height for the cell at the specified index path
            return 80 // Adjust this value as needed
        }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "GetNoteTableViewCell", bundle: nil)
        self.noteTableView.register(cellNib, forCellReuseIdentifier: "NOTE_CELL_ID")
        self.noteTableView.dataSource = self
        self.noteTableView.delegate = self
        
        fetchNote()
    }
    
    func fetchNote(){
        let url = URL(string: "http://51.91.10.19:2666/notes")!
        
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        self.token = appdelegate.token
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("BEARER \(self.token!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let allNotes = json as? [[String:Any]] else{return}
            
            let notes = allNotes.compactMap(Note.fromJSON(dict:))
            
            self.notes = notes
            
            
            DispatchQueue.main.async {
                self.noteTableView.reloadData()
            }
        }
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = PatchNoteViewController.newInstance(note: self.notes[indexPath.row])
        
        if self.splitViewController != nil {
            self.splitViewController!.viewControllers[1] = next
                    
        } else if self.navigationController != nil {
            self.navigationController?.pushViewController(next, animated: true)
        }
    }

    @IBAction func GoToCreation(_ sender: Any) {
        
        self.navigationController?.pushViewController(PostNoteViewController(), animated: true)
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
