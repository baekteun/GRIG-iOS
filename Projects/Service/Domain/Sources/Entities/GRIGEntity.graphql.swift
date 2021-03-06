// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GRIGAPI namespace
public extension GRIGAPI {
  final class GrigEntityQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query GRIGEntity($criteria: String, $count: Int, $page: Int, $generation: Int) {
        ranking(
          criteria: $criteria
          count: $count
          page: $page
          generation: $generation
        ) {
          __typename
          name
          nickname
          bio
          avatar_url
          pullRequests
          stared
          issues
          generation
          forked
          following
          followers
          contributions
        }
      }
      """

    public let operationName: String = "GRIGEntity"

    public var criteria: String?
    public var count: Int?
    public var page: Int?
    public var generation: Int?

    public init(criteria: String? = nil, count: Int? = nil, page: Int? = nil, generation: Int? = nil) {
      self.criteria = criteria
      self.count = count
      self.page = page
      self.generation = generation
    }

    public var variables: GraphQLMap? {
      return ["criteria": criteria, "count": count, "page": page, "generation": generation]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("ranking", arguments: ["criteria": GraphQLVariable("criteria"), "count": GraphQLVariable("count"), "page": GraphQLVariable("page"), "generation": GraphQLVariable("generation")], type: .list(.object(Ranking.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(ranking: [Ranking?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "ranking": ranking.flatMap { (value: [Ranking?]) -> [ResultMap?] in value.map { (value: Ranking?) -> ResultMap? in value.flatMap { (value: Ranking) -> ResultMap in value.resultMap } } }])
      }

      public var ranking: [Ranking?]? {
        get {
          return (resultMap["ranking"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Ranking?] in value.map { (value: ResultMap?) -> Ranking? in value.flatMap { (value: ResultMap) -> Ranking in Ranking(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Ranking?]) -> [ResultMap?] in value.map { (value: Ranking?) -> ResultMap? in value.flatMap { (value: Ranking) -> ResultMap in value.resultMap } } }, forKey: "ranking")
        }
      }

      public struct Ranking: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("nickname", type: .scalar(String.self)),
            GraphQLField("bio", type: .scalar(String.self)),
            GraphQLField("avatar_url", type: .scalar(String.self)),
            GraphQLField("pullRequests", type: .scalar(Int.self)),
            GraphQLField("stared", type: .scalar(Int.self)),
            GraphQLField("issues", type: .scalar(Int.self)),
            GraphQLField("generation", type: .scalar(Int.self)),
            GraphQLField("forked", type: .scalar(Int.self)),
            GraphQLField("following", type: .scalar(Int.self)),
            GraphQLField("followers", type: .scalar(Int.self)),
            GraphQLField("contributions", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, nickname: String? = nil, bio: String? = nil, avatarUrl: String? = nil, pullRequests: Int? = nil, stared: Int? = nil, issues: Int? = nil, generation: Int? = nil, forked: Int? = nil, following: Int? = nil, followers: Int? = nil, contributions: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "name": name, "nickname": nickname, "bio": bio, "avatar_url": avatarUrl, "pullRequests": pullRequests, "stared": stared, "issues": issues, "generation": generation, "forked": forked, "following": following, "followers": followers, "contributions": contributions])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var nickname: String? {
          get {
            return resultMap["nickname"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "nickname")
          }
        }

        public var bio: String? {
          get {
            return resultMap["bio"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bio")
          }
        }

        public var avatarUrl: String? {
          get {
            return resultMap["avatar_url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "avatar_url")
          }
        }

        public var pullRequests: Int? {
          get {
            return resultMap["pullRequests"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "pullRequests")
          }
        }

        public var stared: Int? {
          get {
            return resultMap["stared"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "stared")
          }
        }

        public var issues: Int? {
          get {
            return resultMap["issues"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "issues")
          }
        }

        public var generation: Int? {
          get {
            return resultMap["generation"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "generation")
          }
        }

        public var forked: Int? {
          get {
            return resultMap["forked"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "forked")
          }
        }

        public var following: Int? {
          get {
            return resultMap["following"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "following")
          }
        }

        public var followers: Int? {
          get {
            return resultMap["followers"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "followers")
          }
        }

        public var contributions: Int? {
          get {
            return resultMap["contributions"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "contributions")
          }
        }
      }
    }
  }
}
