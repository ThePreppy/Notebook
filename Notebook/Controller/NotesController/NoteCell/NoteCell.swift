//
//  NoteCell.swift
//  NotesLab
//
//  Created by Александр on 31.05.2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import UIKit

protocol NoteCellDelegate: class {
    func editDidTap(_ cell: NoteCell)
    func deleteDidTap(_ cell: NoteCell)
}

class NoteCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    weak var viewModel: NoteCellViewModelType? {
        didSet {
            guard let viewModel = self.viewModel else { return }
            titleLabel.text = viewModel.title
            descriptionLabel.text = viewModel.description
        }
    }
    
    weak var delegate: NoteCellDelegate?
    
    static let reuseID = String(describing: NoteCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func editAction(_ sender: Any) {
        delegate?.editDidTap(self)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteDidTap(self)
    }
    
}
