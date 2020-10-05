import Foundation

public protocol NetworkManager {
    func request<T: Decodable>(_ route: EndpointType, completion: @escaping (Results<T>) -> Void)
    func cancel()
}

