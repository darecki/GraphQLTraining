//
//  RepositoryListViewModel.swift
//  GraphQLTraining
//
//  Created by Dariusz Ciesla on 14/07/2021.
//

import Foundation

typealias Repo = ReposQuery.Data.Organization.Repository.Edge.Node
typealias PageInfo = ReposQuery.Data.Organization.Repository.PageInfo

final class RepositoryListViewModel {
    var lastPageInfo: PageInfo?

    private let fetchRepositoriesUseCase: FetchRepositoriesUseCaseProtocol

    init(fetchRepositoriesUseCase: FetchRepositoriesUseCaseProtocol) {
        self.fetchRepositoriesUseCase = fetchRepositoriesUseCase
    }

    // input
    func fetchData() {
        guard let lastPageInfo = lastPageInfo else {
            loadRepos(cursor: nil)
            return
        }
        if lastPageInfo.hasNextPage {
            loadRepos(cursor: lastPageInfo.endCursor)
        }
    }

    // output
    private(set) var repos: [Repo] = []
    var didUpdate: (([Repo]) -> Void)?
    var didError: ((String) -> Void)?

    private func loadRepos(cursor: String?) {
        // there is no visual feedback that the request is in progress
        fetchRepositoriesUseCase
            .fetch(cursor: cursor) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let graphQLResult):
                    if let edges = graphQLResult.data?.organization?.repositories.edges {
                        self.repos.append(contentsOf: edges.compactMap { $0?.node })
                        self.didUpdate?(self.repos)
                    }
                    if let pageInfo = graphQLResult.data?.organization?.repositories.pageInfo {
                        self.lastPageInfo = pageInfo
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
