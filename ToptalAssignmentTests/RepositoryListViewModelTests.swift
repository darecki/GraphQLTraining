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

let json1 = """
{
   "organization":{
      "__typename":"",
      "repositories":{
         "__typename":"",
         "totalCount":65,
         "edges":[
            {
               "__typename":"",
               "cursor":"Y3Vyc29yOnYyOpHOAF3qhg==",
               "node":{
                  "__typename":"",
                  "name":"htmlshell",
                  "url":"https://github.com/toptal/htmlshell",
                  "openIssues":{
                     "__typename":"",
                     "totalCount":9
                  },
                  "closedIssues":{
                     "__typename":"",
                     "totalCount":3
                  },
                  "openPullRequests":{
                     "__typename":"",
                     "totalCount":0
                  },
                  "closedPullRequests":{
                     "__typename":"",
                     "totalCount":2
                  }
               }
            }
         ],
         "pageInfo":{
            "__typename":"",
            "endCursor":"Y3Vyc29yOnYyOpHOAF3qhg==",
            "startCursor":"Y3Vyc29yOnYyOpHOAF3qhg==",
            "hasNextPage": true,
            "hasPreviousPage": false
         }
      }
   }
}
"""

private func makeRepoResponseObject() throws -> ReposQuery.Data {
    let data = json1.data(using: .utf8)!
    let json = try JSONSerializationFormat.deserialize(data: data)
    let jsonObject = try JSONObject(jsonValue: json)
    return try ReposQuery.Data(jsonObject: jsonObject)
}

private func makeSuccessfulResponse() throws -> GraphQLResult<ReposQuery.Data> {
    GraphQLResult<ReposQuery.Data>(
        data: try makeRepoResponseObject(),
        extensions: nil,
        errors: nil,
        source: .cache,
        dependentKeys: nil)
}

class FetchRepositoriesUseCaseMock: FetchRepositoriesUseCaseProtocol {
    static let simulateError = "simulateError"
    var functionCallCount = 0

    func fetch(cursor: String?, completion: GraphQLResultHandler<ReposQuery.Data>?) {
        functionCallCount += 1

        if cursor == Self.simulateError {
            completion?(.failure(TestError.testError))
        } else {
            completion?(.success(try! makeSuccessfulResponse()))
        }
    }
}

class RepositoryListViewModelTests: XCTestCase {

    var sut: RepositoryListViewModel!
    var fetchRepositoriesUseCase: FetchRepositoriesUseCaseMock!

    var didCallUpdateClosure = false
    var didCallErrorClosure = false

    override func setUpWithError() throws {
        try super.setUpWithError()
        didCallUpdateClosure = false
        didCallErrorClosure = false

        fetchRepositoriesUseCase = FetchRepositoriesUseCaseMock()
        sut = RepositoryListViewModel(fetchRepositoriesUseCase: fetchRepositoriesUseCase)

        sut.didError = { _ in
            self.didCallErrorClosure = true
        }
        sut.didUpdate = { _ in
            self.didCallUpdateClosure = true
        }
    }

    override func tearDownWithError() throws {
        sut = nil
        fetchRepositoriesUseCase = nil
        try super.tearDownWithError()
    }

    func testDataShouldBeRequestedOnStart() {
        XCTAssertEqual(fetchRepositoriesUseCase.functionCallCount, 0)
        sut.fetchData()
        XCTAssertEqual(fetchRepositoriesUseCase.functionCallCount, 1, "When called fetchData function should be called")
    }

    func testSuccessfulRequestShouldCallUpdateClosure() {
        sut.fetchData()
        XCTAssertTrue(didCallUpdateClosure)
        XCTAssertFalse(didCallErrorClosure)
    }

    func testSuccessfulRequestShouldPopulateStore() {
        XCTAssertEqual(sut.repos.count, 0)
        sut.fetchData()
        XCTAssertEqual(sut.repos.count, 1)
        sut.fetchData()
        XCTAssertEqual(sut.repos.count, 2)
    }
}
