//
//  NotesControllerViewModelType.swift
//  NotesLab
//
//  Created by Александр on 31.05.2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import Foundation

protocol NotesControllerViewModelType {
    init(repository: Repository)
    func addNote(with title: String, description: String)
    func fetchNotes()
    func numberOfRows() -> Int
    func delete(at indexPath: IndexPath)
    func edit(_ note: Note, at indexPath: IndexPath)
    func viewModelForDetail(at indexPath: IndexPath) -> NoteDetailControllerViewModelType?
    func viewModelForRow(at indexPath: IndexPath) -> NoteCellViewModelType?
}
