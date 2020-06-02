//
//  NoteDetailControllerViewModelType.swift
//  NotesLab
//
//  Created by Александр on 31.05.2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import Foundation

protocol NoteDetailControllerViewModelType {
    var title: String { get }
    var description: String { get }
    var indexPath: IndexPath { get }
    init(_ note: Note, indexPath: IndexPath)
    func editNote(title: String, description: String) -> Note
}
