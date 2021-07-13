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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.addConstraints(to: view)

        bindToViewModel()
        viewModel.fetchData()
    }

    private func bindToViewModel() {
        self.viewModel.didUpdate = { [weak self] _ in
            self?.viewModelDidUpdate()
        }
        self.viewModel.didError = { [weak self] error in
            self?.viewModelDidError(error)
        }
    }

    private func viewModelDidUpdate() {
        tableView.reloadData()
    }
    
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
            return self.viewModel.repos.count
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
            let repo = self.viewModel.repos[indexPath.row]
            cell.textLabel?.text = "\(repo.name) (\(repo.url))"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension RepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = self.viewModel.repos[indexPath.row]
        let vc = RepositoryDetailsViewController(repo: repo)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
