import ProjectDescription

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager:[
        .remote(url: "https://github.com/uber/RIBs.git", requirement: .upToNextMajor(from: "0.10.0")),
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.0.0")),
        .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2.0.0")),
        .remote(url: "https://github.com/AliSoftware/Reusable.git", requirement: .upToNextMajor(from: "4.0.0")),
        .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMajor(from: "6.0.0")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.0.0")),
        .remote(url: "https://github.com/Quick/Quick.git", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/Quick/Nimble.git", requirement: .upToNextMajor(from: "9.0.0")),
        .remote(url: "https://github.com/apollographql/apollo-ios.git", requirement: .upToNextMajor(from: "0.50.0")),
        .remote(url: "https://github.com/slackhq/PanModal.git", requirement: .upToNextMajor(from: "1.2.7")),
        .remote(url: "https://github.com/RxSwiftCommunity/RxGesture.git", requirement: .upToNextMajor(from: "4.0.0"))
    ],
    platforms: [.iOS]
)
