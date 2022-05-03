import Network

public struct NetworkMonitor {
    public static let shared = NetworkMonitor()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(handler: @escaping ((NWPath) -> Void)) {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = handler
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
}
