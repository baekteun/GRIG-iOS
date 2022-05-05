import Network

public struct NetworkMonitor {
    public static var shared = NetworkMonitor()
    private let queue = DispatchQueue.global()
    private var isStarted = false
    private let monitor: NWPathMonitor
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public mutating func startMonitoring(handler: @escaping ((NWPath) -> Void)) {
        if isStarted {
            return
        }
        isStarted = true
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = handler
    }
    
    public mutating func stopMonitoring() {
        if !isStarted {
            return
        }
        isStarted = false
        monitor.cancel()
    }
}
