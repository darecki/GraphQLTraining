//
//  RepositoryListViewModelTests.swift
//  ToptalAssignmentTests
//
//  Created by Dariusz Ciesla on 14/07/2021.
//

import XCTest
import Apollo
@testable import ToptalAssignment

enum TestError: Error {
    case testError
}

class FetchRepositoriesUseCaseMock: FetchRepositoriesUseCaseProtocol {
    var functionCallCount = 0

    func fetch(cursor: String?, completion: GraphQLResultHandler<ReposQuery.Data>?) {
        functionCallCount += 1
        completion?(.failure(TestError.testError))
    }
}

class RepositoryListViewModelTests: XCTestCase {

    var sut: RepositoryListViewModel!
    var fetchRepositoriesUseCase: FetchRepositoriesUseCaseMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fetchRepositoriesUseCase = FetchRepositoriesUseCaseMock()
        sut = RepositoryListViewModel(fetchRepositoriesUseCase: fetchRepositoriesUseCase)
    }

    override func tearDownWithError() throws {
        sut = nil
        fetchRepositoriesUseCase = nil
        try super.tearDownWithError()
    }

    func testDataShouldBeRequestedOnStart() {
        var didErrorCalled = false
        sut.didError = { _ in
            didErrorCalled = true
        }
        XCTAssertEqual(fetchRepositoriesUseCase.functionCallCount, 0)
        sut.fetchData()
        XCTAssertEqual(fetchRepositoriesUseCase.functionCallCount, 1, "When called fetchData function should be called")
        XCTAssertTrue(didErrorCalled)
    }

}
