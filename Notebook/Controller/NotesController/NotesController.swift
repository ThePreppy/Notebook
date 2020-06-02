//
//  NotesController.swift
//  NotesLab
//
//  Created by Александр on 31.05.2020.
//  Copyright © 2020 Alexander. All rights reserved.
//

import UIKit

class NotesController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    let viewModel: NotesControllerViewModelType = NotesControllerViewModel(repository: NotesRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NoteCell.reuseID, bundle: nil), forCellReuseIdentifier: NoteCell.reuseID)
    }
    
    private func setupNavigationBar() {
        let addNoteBarButton = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(addNote))
        navigationItem.rightBarButtonItem = addNoteBarButton
        navigationItem.title = "Notes"
    }
    
    @objc private func addNote() {
        let addNoteAlert = UIAlertController(title: "Add note", message: nil, preferredStyle: .alert)
        addNoteAlert.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        addNoteAlert.addTextField { (textField) in
            textField.placeholder = "Description"
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] (alert) in
            guard let self = self else { return }
            guard let title = addNoteAlert.textFields?[0].text, let description = addNoteAlert.textFields?[1].text else { return }
            guard !title.isEmpty, !description.isEmpty else { return }
            
            self.viewModel.addNote(with: title, description: description)
            let lastIndexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0), section: 0)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [lastIndexPath], with: .right)
            self.tableView.endUpdates()
        }
        
        addNoteAlert.addAction(okAction)
        
        present(addNoteAlert, animated: true, completion: nil)
    }

}

extension NotesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseID, for: indexPath) as? NoteCell else { return UITableViewCell() }
        
        cell.viewModel = viewModel.viewModelForRow(at: indexPath)
        cell.delegate = self
        
        return cell
    }
    
}

extension NotesController: UITableViewDelegate {
    
}

extension NotesController: NoteCellDelegate {
    
    func editDidTap(_ cell: NoteCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let noteDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteDetailController") as? NoteDetailController else { return }
        noteDetailController.viewModel = viewModel.viewModelForDetail(at: indexPath)
        noteDetailController.delegate = self
        navigationController?.pushViewController(noteDetailController, animated: true)
    }
    
    func deleteDidTap(_ cell: NoteCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        viewModel.delete(at: indexPath)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.endUpdates()
    }
    
}

extension NotesController: NoteDetailControllerDelegate {
    
    func didEdit(_ note: Note, at indexPath: IndexPath) {
        viewModel.edit(note, at: indexPath)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}
