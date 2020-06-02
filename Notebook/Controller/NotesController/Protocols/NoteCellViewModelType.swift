//
//  NoteCellViewModelType.swift
//  NotesLab
//
//  Created by Александр on 31.05.2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import Foundation

protocol NoteCellViewModelType: class {
    var title: String { get }
    var description: String { get }
    init(_ note: Note)
}
