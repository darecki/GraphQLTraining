//
//  RepositoryListViewController.swift
//  ToptalAssignment
//
//  Created by Dariusz Ciesla on 08/07/2021.
//

import UIKit

enum ListSection: Int, CaseIterable {
    case repos
}

class RepositoryListViewController: UIViewController {
    static let cellIdentifier = "RepoCell"
    private let viewModel: RepositoryListViewModel
    private let tableView = UITableView()

    init(viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.addConstraints(to: view)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Load more", style: .plain, target: self, action: #selector(loadMore))
        bindToViewModel()
        viewModel.fetchData()
    }

    @objc private func loadMore() {
        viewModel.fetchData()
    }

    // Simple view model bindings. In a production app I'd use RxSwift or Combine.
    private func bindToViewModel() {
        viewModel.didUpdate = { [weak self] _ in
            self?.viewModelDidUpdate()
        }
        viewModel.didError = { [weak self] error in
            self?.viewModelDidError(error)
        }
    }

    // In production I'd update only index paths that have changed.
    private func viewModelDidUpdate() {
        tableView.reloadData()
    }

    // Error message should be displayed on screen. We should use a logger rather than `print`.
    private func viewModelDidError(_ errorMessage: String) {
        print(errorMessage)
    }
}

extension RepositoryListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ListSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = ListSection(rawValue: section) else {
            assertionFailure("Invalid section")
            return 0
        }

        switch listSection {
        case .repos:
            return viewModel.repos.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
        guard let listSection = ListSection(rawValue: indexPath.section) else {
            assertionFailure("Invalid section")
            return cell
        }

        switch listSection {
        case .repos:
            let repo = viewModel.repos[indexPath.row]
            cell.textLabel?.text = repo.name
            cell.detailTextLabel?.text = repo.url
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension RepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = viewModel.repos[indexPath.row]
        let vc = RepositoryDetailsViewController(repo: repo)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
