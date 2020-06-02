//
//  NoteDetailControllerViewModel.swift
//  NotesLab
//
//  Created by Александр on 31.05.2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import Foundation

class NoteDetailControllerViewModel: NoteDetailControllerViewModelType {
    
    private let note: Note
    private let _indexPath: IndexPath
    
    var title: String {
        return note.title
    }
    
    var description: String {
        return note.body
    }
    
    var indexPath: IndexPath {
        return _indexPath
    }
    
    required init(_ note: Note, indexPath: IndexPath) {
        self.note = note
        self._indexPath = indexPath
    }
    
    func editNote(title: String, description: String) -> Note {
        let note = Note()
        note.id = self.note.id
        note.title = title
        note.body = description
        
        return note
    }
    
}
