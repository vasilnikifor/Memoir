import FirebaseAnalytics

protocol AnalyticsServiceProtocol {
    func sendEvent(_ name: String, parameters: [String : Any]?)
}

extension AnalyticsServiceProtocol {
    func sendEvent(_ name: String) {
        sendEvent(name, parameters: nil)
    }
}

final class AnalyticsService: AnalyticsServiceProtocol {
    func sendEvent(_ name: String, parameters: [String : Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
}
