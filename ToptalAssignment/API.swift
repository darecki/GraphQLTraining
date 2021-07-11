// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ReposQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Repos {
      organization(login: "toptal") {
        __typename
        repositories(first: 100) {
          __typename
          totalCount
          nodes {
            __typename
            name
            url
            openIssues: issues(first: 1, states: OPEN) {
              __typename
              totalCount
            }
            closedIssues: issues(first: 1, states: CLOSED) {
              __typename
              totalCount
            }
            openPullRequests: pullRequests(first: 1, states: OPEN) {
              __typename
              totalCount
            }
            closedPullRequests: pullRequests(first: 1, states: CLOSED) {
              __typename
              totalCount
            }
          }
        }
      }
    }
    """

  public let operationName: String = "Repos"

  public let operationIdentifier: String? = "17fd7879a164e0a56bbf305916deee23521e73b8775bb803e6bddb53d944f675"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("organization", arguments: ["login": "toptal"], type: .object(Organization.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(organization: Organization? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "organization": organization.flatMap { (value: Organization) -> ResultMap in value.resultMap }])
    }

    /// Lookup a organization by login.
    public var organization: Organization? {
      get {
        return (resultMap["organization"] as? ResultMap).flatMap { Organization(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "organization")
      }
    }

    public struct Organization: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Organization"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("repositories", arguments: ["first": 100], type: .nonNull(.object(Repository.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(repositories: Repository) {
        self.init(unsafeResultMap: ["__typename": "Organization", "repositories": repositories.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of repositories that the user owns.
      public var repositories: Repository {
        get {
          return Repository(unsafeResultMap: resultMap["repositories"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "repositories")
        }
      }

      public struct Repository: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["RepositoryConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(totalCount: Int, nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "RepositoryConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return resultMap["totalCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalCount")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Repository"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("url", type: .nonNull(.scalar(String.self))),
              GraphQLField("issues", alias: "openIssues", arguments: ["first": 1, "states": "OPEN"], type: .nonNull(.object(OpenIssue.selections))),
              GraphQLField("issues", alias: "closedIssues", arguments: ["first": 1, "states": "CLOSED"], type: .nonNull(.object(ClosedIssue.selections))),
              GraphQLField("pullRequests", alias: "openPullRequests", arguments: ["first": 1, "states": "OPEN"], type: .nonNull(.object(OpenPullRequest.selections))),
              GraphQLField("pullRequests", alias: "closedPullRequests", arguments: ["first": 1, "states": "CLOSED"], type: .nonNull(.object(ClosedPullRequest.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String, url: String, openIssues: OpenIssue, closedIssues: ClosedIssue, openPullRequests: OpenPullRequest, closedPullRequests: ClosedPullRequest) {
            self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "url": url, "openIssues": openIssues.resultMap, "closedIssues": closedIssues.resultMap, "openPullRequests": openPullRequests.resultMap, "closedPullRequests": closedPullRequests.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The name of the repository.
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// The HTTP URL for this repository
          public var url: String {
            get {
              return resultMap["url"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }

          /// A list of issues that have been opened in the repository.
          public var openIssues: OpenIssue {
            get {
              return OpenIssue(unsafeResultMap: resultMap["openIssues"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "openIssues")
            }
          }

          /// A list of issues that have been opened in the repository.
          public var closedIssues: ClosedIssue {
            get {
              return ClosedIssue(unsafeResultMap: resultMap["closedIssues"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "closedIssues")
            }
          }

          /// A list of pull requests that have been opened in the repository.
          public var openPullRequests: OpenPullRequest {
            get {
              return OpenPullRequest(unsafeResultMap: resultMap["openPullRequests"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "openPullRequests")
            }
          }

          /// A list of pull requests that have been opened in the repository.
          public var closedPullRequests: ClosedPullRequest {
            get {
              return ClosedPullRequest(unsafeResultMap: resultMap["closedPullRequests"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "closedPullRequests")
            }
          }

          public struct OpenIssue: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["IssueConnection"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(totalCount: Int) {
              self.init(unsafeResultMap: ["__typename": "IssueConnection", "totalCount": totalCount])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Identifies the total count of items in the connection.
            public var totalCount: Int {
              get {
                return resultMap["totalCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "totalCount")
              }
            }
          }

          public struct ClosedIssue: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["IssueConnection"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(totalCount: Int) {
              self.init(unsafeResultMap: ["__typename": "IssueConnection", "totalCount": totalCount])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Identifies the total count of items in the connection.
            public var totalCount: Int {
              get {
                return resultMap["totalCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "totalCount")
              }
            }
          }

          public struct OpenPullRequest: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["PullRequestConnection"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(totalCount: Int) {
              self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "totalCount": totalCount])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Identifies the total count of items in the connection.
            public var totalCount: Int {
              get {
                return resultMap["totalCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "totalCount")
              }
            }
          }

          public struct ClosedPullRequest: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["PullRequestConnection"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(totalCount: Int) {
              self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "totalCount": totalCount])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Identifies the total count of items in the connection.
            public var totalCount: Int {
              get {
                return resultMap["totalCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "totalCount")
              }
            }
          }
        }
      }
    }
  }
}
