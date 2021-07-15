//
//  Network.swift
//  GraphQLTraining
//
//  Created by Dariusz Ciesla on 11/07/2021.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()

    private(set) lazy var apollo: ApolloClient = {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)

        let url = URL(string: "https://api.github.com/graphql")!

        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: DefaultInterceptorProvider(store: store),
                                                                 endpointURL: url,
                                                                 additionalHeaders: ["Authorization": "Bearer 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"])
        return ApolloClient(networkTransport: requestChainTransport,
                            store: store)
    }()
}

