// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum CoreAsset {
  public enum Colors {
    public static let girgGray = CoreColors(name: "GIRG_Gray")
    public static let grigBackground = CoreColors(name: "GRIG_Background")
    public static let grigBlack = CoreColors(name: "GRIG_Black")
    public static let grigCompetePrimary = CoreColors(name: "GRIG_CompetePrimary")
    public static let grigCompeteSecondary = CoreColors(name: "GRIG_CompeteSecondary")
    public static let grigOnboardMain = CoreColors(name: "GRIG_OnboardMain")
    public static let grigPrimary = CoreColors(name: "GRIG_Primary")
    public static let grigPrimaryTextColor = CoreColors(name: "GRIG_PrimaryTextColor")
    public static let grigSecondaryTextColor = CoreColors(name: "GRIG_SecondaryTextColor")
    public static let grigWhite = CoreColors(name: "GRIG_White")
  }
  public enum Images {
    public static let grigCompeteIcon = CoreImages(name: "GRIG_CompeteIcon")
    public static let grigGithubIcon = CoreImages(name: "GRIG_GithubIcon")
    public static let grigLogo = CoreImages(name: "GRIG_Logo")
    public static let grigOnboard1 = CoreImages(name: "GRIG_Onboard1")
    public static let grigOnboard2 = CoreImages(name: "GRIG_Onboard2")
    public static let grigOnboard3 = CoreImages(name: "GRIG_Onboard3")
    public static let grigOnboard4 = CoreImages(name: "GRIG_Onboard4")
    public static let grigSword = CoreImages(name: "GRIG_Sword")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class CoreColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension CoreColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: CoreColors) {
    let bundle = CoreResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct CoreImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = CoreResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension CoreImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the CoreImages.image property")
  convenience init?(asset: CoreImages) {
    #if os(iOS) || os(tvOS)
    let bundle = CoreResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
