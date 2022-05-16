// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GRIGAPI namespace
public extension GRIGAPI {
  final class GithubUserQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query GithubUser($login: String!, $from: DateTime!, $to: DateTime!) {
        user(login: $login) {
          __typename
          avatarUrl
          contributionsCollection(from: $from, to: $to) {
            __typename
            contributionCalendar {
              __typename
              weeks {
                __typename
                contributionDays {
                  __typename
                  date
                  contributionCount
                }
              }
              totalContributions
            }
          }
          bio
          followers {
            __typename
            totalCount
          }
          following {
            __typename
            totalCount
          }
          login
          name
          pullRequests {
            __typename
            totalCount
          }
          issues {
            __typename
            totalCount
          }
        }
      }
      """

    public let operationName: String = "GithubUser"

    public var login: String
    public var from: String
    public var to: String

    public init(login: String, from: String, to: String) {
      self.login = login
      self.from = from
      self.to = to
    }

    public var variables: GraphQLMap? {
      return ["login": login, "from": from, "to": to]
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
            GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
            GraphQLField("contributionsCollection", arguments: ["from": GraphQLVariable("from"), "to": GraphQLVariable("to")], type: .nonNull(.object(ContributionsCollection.selections))),
            GraphQLField("bio", type: .scalar(String.self)),
            GraphQLField("followers", type: .nonNull(.object(Follower.selections))),
            GraphQLField("following", type: .nonNull(.object(Following.selections))),
            GraphQLField("login", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("pullRequests", type: .nonNull(.object(PullRequest.selections))),
            GraphQLField("issues", type: .nonNull(.object(Issue.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(avatarUrl: String, contributionsCollection: ContributionsCollection, bio: String? = nil, followers: Follower, following: Following, login: String, name: String? = nil, pullRequests: PullRequest, issues: Issue) {
          self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "contributionsCollection": contributionsCollection.resultMap, "bio": bio, "followers": followers.resultMap, "following": following.resultMap, "login": login, "name": name, "pullRequests": pullRequests.resultMap, "issues": issues.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A URL pointing to the user's public avatar.
        public var avatarUrl: String {
          get {
            return resultMap["avatarUrl"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "avatarUrl")
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

        /// The user's public profile bio.
        public var bio: String? {
          get {
            return resultMap["bio"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bio")
          }
        }

        /// A list of users the given user is followed by.
        public var followers: Follower {
          get {
            return Follower(unsafeResultMap: resultMap["followers"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "followers")
          }
        }

        /// A list of users the given user is following.
        public var following: Following {
          get {
            return Following(unsafeResultMap: resultMap["following"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "following")
          }
        }

        /// The username used to login.
        public var login: String {
          get {
            return resultMap["login"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "login")
          }
        }

        /// The user's public profile name.
        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// A list of pull requests associated with this user.
        public var pullRequests: PullRequest {
          get {
            return PullRequest(unsafeResultMap: resultMap["pullRequests"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pullRequests")
          }
        }

        /// A list of issues associated with this user.
        public var issues: Issue {
          get {
            return Issue(unsafeResultMap: resultMap["issues"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "issues")
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
                GraphQLField("weeks", type: .nonNull(.list(.nonNull(.object(Week.selections))))),
                GraphQLField("totalContributions", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(weeks: [Week], totalContributions: Int) {
              self.init(unsafeResultMap: ["__typename": "ContributionCalendar", "weeks": weeks.map { (value: Week) -> ResultMap in value.resultMap }, "totalContributions": totalContributions])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of the weeks of contributions in this calendar.
            public var weeks: [Week] {
              get {
                return (resultMap["weeks"] as! [ResultMap]).map { (value: ResultMap) -> Week in Week(unsafeResultMap: value) }
              }
              set {
                resultMap.updateValue(newValue.map { (value: Week) -> ResultMap in value.resultMap }, forKey: "weeks")
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

            public struct Week: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["ContributionCalendarWeek"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("contributionDays", type: .nonNull(.list(.nonNull(.object(ContributionDay.selections))))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(contributionDays: [ContributionDay]) {
                self.init(unsafeResultMap: ["__typename": "ContributionCalendarWeek", "contributionDays": contributionDays.map { (value: ContributionDay) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The days of contributions in this week.
              public var contributionDays: [ContributionDay] {
                get {
                  return (resultMap["contributionDays"] as! [ResultMap]).map { (value: ResultMap) -> ContributionDay in ContributionDay(unsafeResultMap: value) }
                }
                set {
                  resultMap.updateValue(newValue.map { (value: ContributionDay) -> ResultMap in value.resultMap }, forKey: "contributionDays")
                }
              }

              public struct ContributionDay: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["ContributionCalendarDay"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("date", type: .nonNull(.scalar(String.self))),
                    GraphQLField("contributionCount", type: .nonNull(.scalar(Int.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(date: String, contributionCount: Int) {
                  self.init(unsafeResultMap: ["__typename": "ContributionCalendarDay", "date": date, "contributionCount": contributionCount])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The day this square represents.
                public var date: String {
                  get {
                    return resultMap["date"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "date")
                  }
                }

                /// How many contributions were made by the user on this day.
                public var contributionCount: Int {
                  get {
                    return resultMap["contributionCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "contributionCount")
                  }
                }
              }
            }
          }
        }

        public struct Follower: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["FollowerConnection"]

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
            self.init(unsafeResultMap: ["__typename": "FollowerConnection", "totalCount": totalCount])
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

        public struct Following: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["FollowingConnection"]

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
            self.init(unsafeResultMap: ["__typename": "FollowingConnection", "totalCount": totalCount])
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

        public struct PullRequest: GraphQLSelectionSet {
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

        public struct Issue: GraphQLSelectionSet {
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
      }
    }
  }
}
