//
//  RepositoryDetailsViewController.swift
//  ToptalAssignment
//
//  Created by Dariusz Ciesla on 11/07/2021.
//

import UIKit

final class RepositoryDetailsViewController: UIViewController {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let repo: ReposQuery.Data.Organization.Repository.Edge.Node

    init(repo: ReposQuery.Data.Organization.Repository.Edge.Node) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeLabel(_ string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        return label
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = repo.name

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addConstraints(to: view)
        stackView.addConstraints(to: scrollView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        stackView.addArrangedSubview(makeLabel("Open issues: \(repo.openIssues.totalCount)"))
        stackView.addArrangedSubview(makeLabel("Closed issues: \(repo.closedIssues.totalCount)"))
        stackView.addArrangedSubview(makeLabel("Open pull requests: \(repo.openPullRequests.totalCount)"))
        stackView.addArrangedSubview(makeLabel("Closed pull requests: \(repo.closedPullRequests.totalCount)"))
        view.backgroundColor = .white
    }
}
