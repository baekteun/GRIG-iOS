// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GRIGAPI namespace
public extension GRIGAPI {
  final class TotalContributionQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query TotalContribution($login: String!) {
        user(login: $login) {
          __typename
          contributionsCollection {
            __typename
            contributionCalendar {
              __typename
              totalContributions
            }
          }
        }
      }
      """

    public let operationName: String = "TotalContribution"

    public var login: String

    public init(login: String) {
      self.login = login
    }

    public var variables: GraphQLMap? {
      return ["login": login]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("user", arguments: ["login": GraphQLVariable("login")], type: .object(User.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
      }

      /// Lookup a user by login.
      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("contributionsCollection", type: .nonNull(.object(ContributionsCollection.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(contributionsCollection: ContributionsCollection) {
          self.init(unsafeResultMap: ["__typename": "User", "contributionsCollection": contributionsCollection.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The collection of contributions this user has made to different repositories.
        public var contributionsCollection: ContributionsCollection {
          get {
            return ContributionsCollection(unsafeResultMap: resultMap["contributionsCollection"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "contributionsCollection")
          }
        }

        public struct ContributionsCollection: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ContributionsCollection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("contributionCalendar", type: .nonNull(.object(ContributionCalendar.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(contributionCalendar: ContributionCalendar) {
            self.init(unsafeResultMap: ["__typename": "ContributionsCollection", "contributionCalendar": contributionCalendar.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A calendar of this user's contributions on GitHub.
          public var contributionCalendar: ContributionCalendar {
            get {
              return ContributionCalendar(unsafeResultMap: resultMap["contributionCalendar"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "contributionCalendar")
            }
          }

          public struct ContributionCalendar: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ContributionCalendar"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalContributions", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(totalContributions: Int) {
              self.init(unsafeResultMap: ["__typename": "ContributionCalendar", "totalContributions": totalContributions])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The count of total contributions in the calendar.
            public var totalContributions: Int {
              get {
                return resultMap["totalContributions"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "totalContributions")
              }
            }
          }
        }
      }
    }
  }
}
