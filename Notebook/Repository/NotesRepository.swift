//
//  NotesRepository.swift
//  NotesLab
//
//  Created by Александр on 31.05.2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import Foundation
import RealmSwift

protocol Repository {
    func getAllNotes() -> [Note]?
    func getNoteBy(id: String) -> Note?
    func editNoteBy(id: String, with note: Note) -> Note?
    func create(note: Note)
    func deleteNoteBy(id: String)
}

class NotesRepository: Repository {
    
    private let realmInstance = try? Realm()
    
    func getAllNotes() -> [Note]? {
        guard let objects = realmInstance?.objects(Note.self) else { return nil }
        return Array(objects)
    }
    
    func getNoteBy(id: String) -> Note? {
        guard let note = realmInstance?.objects(Note.self).filter("id = %@", id).first else { return nil }
        return note
    }
    
    func create(note: Note) {
        do {
            try realmInstance?.write({
                realmInstance?.add(note)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editNoteBy(id: String, with note: Note) -> Note? {
        guard let object = realmInstance?.objects(Note.self).filter("id = %@", id).first else { return nil }
        
        do {
            try realmInstance?.write({
                object.title = note.title
                object.body = note.body
            })
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
        return object
    }
    
    func deleteNoteBy(id: String) {
        guard let object = realmInstance?.objects(Note.self).filter("id = %@", id).first else { return }
        do {
            try realmInstance?.write({
                realmInstance?.delete(object)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
