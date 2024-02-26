//
//  GetNoteTableViewCell.swift
//  iosFrontApp
//
//  Created by Etudiant on 17/02/2024.
//

import UIKit

class GetNoteTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var payload: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var grade: UILabel!
    var noteId:String?
    
    func reload(with note:Note){
        self.noteId = note.noteId
        
        if let title = note.title{
            self.title.text = title
        }
        if let grade = note.grade{
            self.grade.text = "\(grade)/5"
        }
        if let payload = note.payload{
            self.payload.text = "\(payload)"
        }
    }
}
