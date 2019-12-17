//
//  TatooListViewController.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit

protocol TattooListViewControllerDelegate: class {
    
}

class TattooListViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: Properties
    var viewModel: TattoListControllerViewModeling!
    weak var delegate: TattooListViewControllerDelegate?
    private let cellIdentifier = TattoListTableViewCell.reuseIdentifier
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.contentInset.bottom = 100
    }
}

extension TattooListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TattoListTableViewCell else { fatalError("Failed to deque a cell") }
        //Setup
        //Get display model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
