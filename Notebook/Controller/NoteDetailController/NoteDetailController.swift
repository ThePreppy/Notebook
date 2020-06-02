//
//  NoteDetailController.swift
//  NotesLab
//
//  Created by Александр on 31.05.2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import UIKit

protocol NoteDetailControllerDelegate: class {
    func didEdit(_ note: Note, at indexPath: IndexPath)
}

class NoteDetailController: UIViewController {

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    var viewModel: NoteDetailControllerViewModelType?
    weak var delegate: NoteDetailControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.systemOrange.cgColor
        setupNavigationBar()
        guard let viewModel = self.viewModel else { return }
        titleTextField.text = viewModel.title
        descriptionTextView.text = viewModel.description
    }
    
    private func setupNavigationBar() {
        let saveBarButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNote))
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc private func saveNote() {
        guard let viewModel = self.viewModel else { return }
        guard let title = titleTextField.text, let description = descriptionTextView.text else { return }
        guard !title.isEmpty, !description.isEmpty else { return }
        let note = viewModel.editNote(title: title, description: description)
        navigationController?.popViewController(animated: true)
        delegate?.didEdit(note, at: viewModel.indexPath)
    }

}
