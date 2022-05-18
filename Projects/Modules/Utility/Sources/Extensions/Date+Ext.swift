import Foundation

public extension Date {
    func toISO8601() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = .init(identifier: "UTC")
        return formatter.string(from: self)
    }
}
