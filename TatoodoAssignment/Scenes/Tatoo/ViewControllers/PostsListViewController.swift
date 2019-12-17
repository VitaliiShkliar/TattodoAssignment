//
//  TatooListViewController.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit

protocol PostsListViewControllerDelegate: class {
    func didSelect(post: PostListModel)
}

class PostsListViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    var viewModel: PostsListControllerViewModeling!
    weak var delegate: PostsListViewControllerDelegate?
    private let cellIdentifier = PostListTableViewCell.reuseIdentifier
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        wireViewModel()
        viewModel.getPosts()
    }
    
    private func wireViewModel() {
        viewModel.onSelect = { [weak self] post in
            self?.delegate?.didSelect(post: post)
        }
        
        viewModel.onNewItems = { [weak self] indexesToInsert in
            self?.tableView.beginUpdates()
            self?.tableView.insertRows(at: indexesToInsert, with: .fade)
            self?.tableView.endUpdates()
        }
        
        viewModel.onLoadingStateChange = { [weak self] bool in
            print("IsLoading", bool)
            //TODO: loader
        }
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.contentInset.bottom = 100
    }
}

extension PostsListViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostListTableViewCell else { fatalError("Failed to deque a cell") }
        let model = viewModel.displayModelForCell(at: indexPath.row)
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.userDidSelect(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.bounds.height / 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isNearBottomEdge(edgeOffset: tableView.bounds.height / 4) else { return }
        viewModel.didScrollToBottom()
    }
}
