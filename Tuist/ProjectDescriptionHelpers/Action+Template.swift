import ProjectDescription

public extension TargetScript {
    static let swiftLint = TargetScript.pre(
        path: .relativeToRoot("Scripts/SwiftLintRunScript.sh"),
        name: "SwiftLint"
    )
    static let generateApolloGraphQLAPI = TargetScript.pre(
        path: .relativeToRoot("Scripts/Generate-Apollo-GraphQL-API.sh"),
        name: "Generate Apollo GraphQL API"
    )
}
