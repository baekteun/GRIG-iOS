import ProjectDescription

public extension TargetScript {
    static let generateApolloGraphQLAPI = TargetScript.pre(
        path: .relativeToRoot("Scripts/Generate-Apollo-GraphQL-API.sh"),
        name: "Generate Apollo GraphQL API"
    )
}
