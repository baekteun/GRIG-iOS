// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GRIGAPI namespace
public extension GRIGAPI {
  final class GrigGenerationQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query GRIGGeneration {
        generation {
          __typename
          count
          _id
        }
      }
      """

    public let operationName: String = "GRIGGeneration"

    public init() {
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("generation", type: .list(.object(Generation.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(generation: [Generation?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "generation": generation.flatMap { (value: [Generation?]) -> [ResultMap?] in value.map { (value: Generation?) -> ResultMap? in value.flatMap { (value: Generation) -> ResultMap in value.resultMap } } }])
      }

      public var generation: [Generation?]? {
        get {
          return (resultMap["generation"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Generation?] in value.map { (value: ResultMap?) -> Generation? in value.flatMap { (value: ResultMap) -> Generation in Generation(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Generation?]) -> [ResultMap?] in value.map { (value: Generation?) -> ResultMap? in value.flatMap { (value: Generation) -> ResultMap in value.resultMap } } }, forKey: "generation")
        }
      }

      public struct Generation: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Generation"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("count", type: .scalar(Int.self)),
            GraphQLField("_id", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(count: Int? = nil, _id: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "Generation", "count": count, "_id": _id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var count: Int? {
          get {
            return resultMap["count"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "count")
          }
        }

        public var _id: Int? {
          get {
            return resultMap["_id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }
      }
    }
  }
}
