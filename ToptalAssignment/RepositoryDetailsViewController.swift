//
//  RepositoryDetailsViewController.swift
//  ToptalAssignment
//
//  Created by Dariusz Ciesla on 11/07/2021.
//

import UIKit

final class RepositoryDetailsViewController: UIViewController {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let repo: ReposQuery.Data.Organization.Repository.Node

    init(repo: ReposQuery.Data.Organization.Repository.Node) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func makeLabel(_ string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        return label
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = repo.name

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        stackView.addArrangedSubview(makeLabel("Open issues: \(repo.openIssues.totalCount)"))
        stackView.addArrangedSubview(makeLabel("Closed issues: \(repo.closedIssues.totalCount)"))
        stackView.addArrangedSubview(makeLabel("Open pull requests: \(repo.openPullRequests.totalCount)"))
        stackView.addArrangedSubview(makeLabel("Closed pull requests: \(repo.closedPullRequests.totalCount)"))
        view.backgroundColor = .white
    }
}
