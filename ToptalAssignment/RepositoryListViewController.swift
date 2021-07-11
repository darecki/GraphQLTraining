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

    private let tableView = UITableView()

    var repos = [ReposQuery.Data.Organization.Repository.Node]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        loadRepos()
    }

    private func loadRepos() {
        Network.shared.apollo
            .fetch(query: ReposQuery()) { [weak self] result in
                guard let self = self else { return }

                defer {
                    self.tableView.reloadData()
                }

                switch result {
                case .success(let graphQLResult):
                    if let nodes = graphQLResult.data?.organization?.repositories.nodes {
                        self.repos.append(contentsOf: nodes.compactMap { $0 })
                    }
                    if let errors = graphQLResult.errors {
                        let message = errors
                            .map { $0.localizedDescription }
                            .joined(separator: "\n")
                        print(message)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
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
            return self.repos.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        guard let listSection = ListSection(rawValue: indexPath.section) else {
            assertionFailure("Invalid section")
            return cell
        }

        switch listSection {
        case .repos:
            let repo = self.repos[indexPath.row]
            cell.textLabel?.text = "\(repo.name) (\(repo.url))"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension RepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = self.repos[indexPath.row]
        let vc = RepositoryDetailsViewController(repo: repo)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
