//
//  RepositoryListViewModel.swift
//  ToptalAssignment
//
//  Created by Dariusz Ciesla on 14/07/2021.
//

import Foundation
import Apollo

final class RepositoryListViewModel {
    typealias Repo = ReposQuery.Data.Organization.Repository.Edge.Node

    private let apollo: ApolloClient
    private var cursor: String?

    init(apollo: ApolloClient = Network.shared.apollo) {
        self.apollo = apollo
    }

    // input
    func fetchData() {
        loadRepos(cursor: nil)
    }

    // output
    private(set) var repos: [Repo] = []
    var didUpdate: (([Repo]) -> Void)?
    var didError: ((String) -> Void)?

    private func loadRepos(cursor: String?) {
        Network.shared.apollo
            .fetch(query: ReposQuery(cursor: cursor)) { [weak self] result in
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
