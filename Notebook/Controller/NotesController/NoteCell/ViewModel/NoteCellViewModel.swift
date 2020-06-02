//
//  NoteCellViewModel.swift
//  NotesLab
//
//  Created by Александр on 31.05.2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import Foundation

class NoteCellViewModel: NoteCellViewModelType {
    
    private let note: Note
    
    var title: String {
        return note.title
    }
    
    var description: String {
        return note.body
    }
    
    required init(_ note: Note) {
        self.note = note
    }
    
}
