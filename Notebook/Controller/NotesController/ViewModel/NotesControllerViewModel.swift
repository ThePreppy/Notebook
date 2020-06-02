//
//  NotesControllerViewModel.swift
//  NotesLab
//
//  Created by Александр on 31.05.2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import Foundation

class NotesControllerViewModel: NotesControllerViewModelType {
    
    private let repository: Repository
    private var notes: [Note]?
    
    required init(repository: Repository) {
        self.repository = repository
        self.notes = repository.getAllNotes()
    }
    
    func addNote(with title: String, description: String) {
        let note = Note()
        note.body = description
        note.title = title
        notes?.append(note)
        repository.create(note: note)
    }
    
    func delete(at indexPath: IndexPath) {
        guard let note = notes?[indexPath.row] else { return }
        notes?.remove(at: indexPath.row)
        repository.deleteNoteBy(id: note.id)
    }
    
    func edit(_ note: Note, at indexPath: IndexPath) {
        guard let note = repository.editNoteBy(id: note.id, with: note) else { return }
        notes?[indexPath.row] = note
    }
    
    func fetchNotes() {
        notes = repository.getAllNotes()
    }
    
    func numberOfRows() -> Int {
        return notes?.count ?? 0
    }
    
    func viewModelForRow(at indexPath: IndexPath) -> NoteCellViewModelType? {
        guard let note = notes?[indexPath.row] else { return nil }
        return NoteCellViewModel(note)
    }
    
    func viewModelForDetail(at indexPath: IndexPath) -> NoteDetailControllerViewModelType? {
        guard let note = notes?[indexPath.row] else { return nil }
        return NoteDetailControllerViewModel(note, indexPath: indexPath)
    }
    
}
