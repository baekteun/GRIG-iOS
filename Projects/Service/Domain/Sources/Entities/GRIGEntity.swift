public struct GRIGEntity: Equatable {
    public init(name: String, nickname: String, generation: Int, bio: String, avatarUrl: String, result: Int) {
        self.name = name
        self.nickname = nickname
        self.generation = generation
        self.bio = bio
        self.avatarUrl = avatarUrl
        self.result = result
    }
    
    public let name: String
    public let nickname: String
    public let generation: Int
    public let bio: String
    public let avatarUrl: String
    public let result: Int
}

