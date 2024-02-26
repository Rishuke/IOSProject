//
//  Notes.swift
//  iosFrontApp
//
//  Created by Etudiant on 17/02/2024.
//

import Foundation

class Note {
    
    var noteId:String? = nil
    var payload : String? = nil
    var title : String? = nil
    var grade:Int? = nil
    var createdAt:String
    var updatedAt:String
    var userId:String
    var idRecette:String? = nil
    
    init(noteId: String?, payload: String?,title:String?,grade:Int?, createdAt:String,updatedAt:String,userId:String,idRecette:String?) {
        self.noteId = noteId
        self.payload = payload
        self.title = title
        self.grade = grade
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.userId = userId
        self.idRecette = idRecette
    }
    
    static func fromJSON(dict: [String:Any]) -> Note?{
        guard let noteId = (dict["noteId"] as? String),
              let payload = (dict["payload"] as? String),
              let title = (dict["title"] as? String),
              let grade = (dict["grade"] as? Int),
              let createdAt = (dict["createdAt"] as? String),
              let updatedAt = (dict["updatedAt"] as? String),
              let idRecette = (dict["idRecette"] as? String),
              let userId = (dict["userId"] as? String)
        else{
            return nil
        }
        
        
        return Note(noteId: noteId, payload: payload, title: title, grade: grade, createdAt: createdAt, updatedAt: updatedAt, userId: userId, idRecette: idRecette)
    }
}
