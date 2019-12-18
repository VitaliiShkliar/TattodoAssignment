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
    private var activityIndicator: UIActivityIndicatorView?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        wireViewModel()
        viewModel.getPosts()
    }
    
    private func wireViewModel() {
        viewModel.onPostSelected = { [weak self] post in
            self?.delegate?.didSelect(post: post)
        }
        
        viewModel.onNewItems = { [weak self] indexesToInsert in
            self?.tableView.beginUpdates()
            self?.tableView.insertRows(at: indexesToInsert, with: .fade)
            self?.tableView.endUpdates()
        }
        
        viewModel.onLoadingStateChange = { [weak self] isLoading in
            isLoading ? self?.activityIndicator?.startAnimating() : self?.activityIndicator?.stopAnimating()
        }
        
        viewModel.onErrorMessageReceived = { [weak self] errorMessage in
            self?.alert(message: errorMessage)
        }
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.contentInset.bottom = 100
        tableView.tableFooterView = getTableFooterView()
    }
    
    private func getTableFooterView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        self.activityIndicator = activityIndicator
        return view
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
        viewModel.userDidSelect(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.bounds.height / 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentSize.height > scrollView.frame.size.height, scrollView.isNearBottomEdge(edgeOffset: tableView.bounds.height) else { return }
        viewModel.didScrollToBottom()
    }
}
