//
//  RepositoryListViewModel.swift
//  ToptalAssignment
//
//  Created by Dariusz Ciesla on 14/07/2021.
//

import Foundation

typealias Repo = ReposQuery.Data.Organization.Repository.Edge.Node

final class RepositoryListViewModel {
    private var cursor: String?
    private let fetchRepositoriesUseCase: FetchRepositoriesUseCaseProtocol

    init(fetchRepositoriesUseCase: FetchRepositoriesUseCaseProtocol) {
        self.fetchRepositoriesUseCase = fetchRepositoriesUseCase
    }

    // input
    func fetchData() {
        loadRepos(cursor: nil)
    }

    // output
    private(set) var repos: [Repo] = []
    var didUpdate: (([Repo]) -> Void)?
    var didError: ((String) -> Void)?

    func loadRepos(cursor: String?) {
        fetchRepositoriesUseCase
            .fetch(cursor: cursor) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let graphQLResult):
                    if let edges = graphQLResult.data?.organization?.repositories.edges {
                        self.repos.append(contentsOf: edges.compactMap { $0?.node })
                        self.didUpdate?(self.repos)
                    }
                    if let errors = graphQLResult.errors {
                        let message = errors
                            .map { $0.localizedDescription }
                            .joined(separator: "\n")
                        self.didError?(message)
                    }
                case .failure(let error):
                    self.didError?(error.localizedDescription)
                }
            }
    }
}
