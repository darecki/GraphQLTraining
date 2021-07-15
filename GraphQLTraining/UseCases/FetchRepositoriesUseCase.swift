//
//  FetchRepositoriesUseCase.swift
//  GraphQLTraining
//
//  Created by Dariusz Ciesla on 14/07/2021.
//

import Apollo

protocol FetchRepositoriesUseCaseProtocol: AnyObject {
    func fetch(cursor: String?, completion: GraphQLResultHandler<ReposQuery.Data>?)
}

class FetchRepositoriesUseCase: FetchRepositoriesUseCaseProtocol {
    func fetch(cursor: String?, completion: GraphQLResultHandler<ReposQuery.Data>?) {
        Network.shared.apollo
            .fetch(query: ReposQuery(cursor: cursor), resultHandler: completion)
    }
}
