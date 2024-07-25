import Foundation

public struct NetworkManager: Sendable {

    private(set) static var shared = NetworkManager()

    private let networkManagerQueue = DispatchQueue(label: "NetworkManagerMutation", qos: .utility)
    private var _baseScheme: String? = nil
    public var baseScheme: String? {
            networkManagerQueue.sync { return _baseScheme }
    }
    private init() {}

    public enum NetworkError: Error {
        case requestBuildError(message: String?)
    }

    public enum RequestType: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }

    public class RequestBuilder {
        public typealias BuildClosure = (RequestBuilder) -> Void

        var scheme: String?
        var path: String?
        var method: RequestType = .get
        private var queryParameters = Set<URLQueryItem>()
        private var body: Data?
        private var headers = [String: String]()

        public init(_ buildClosure: BuildClosure) {
            buildClosure(self)
        }

        public func addQueryParam(for name: String, with value: String) {
            let item = URLQueryItem(name: name, value: value)
            queryParameters.insert(item)
        }

        public func setHeaders(for key: String, with value: String ) {
            headers[key] = value
        }

        public func setBody<T: Encodable>(body: T) {
            guard let bodyData = try? JSONEncoder().encode(body) else { return }
            self.body = bodyData
        }

        public func build() throws -> URLRequest {
            guard let scheme = scheme, var base = URLComponents(string: scheme) else {
                throw NetworkError.requestBuildError(message: "Failed Building URL")
            }
            if let path = path { base.path = path }
            if !queryParameters.isEmpty { base.queryItems = Array(queryParameters) }
            guard let url = base.url else {
                throw NetworkError.requestBuildError(message: "Failed Building URL")
            }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = body
            request.allHTTPHeaderFields = headers
            return request
        }
    }

    public mutating func setBaseScheme(baseScheme: String) {
        networkManagerQueue.sync { self._baseScheme = baseScheme }
    }

    public func makeRequest<ResponseType: Decodable>(_ request: URLRequest,
                                                     returning: ResponseType.Type) async throws -> (HTTPURLResponse?, ResponseType?) {
        let (data, response) = try await URLSession.shared.data(for: request)
        let responseData = try JSONDecoder().decode(returning, from: data)
        let httpResponse = response as? HTTPURLResponse
        return (httpResponse, responseData)
    }

    public func makeRequest(_ request: URLRequest) async throws -> (HTTPURLResponse?, Data?) {
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        return (httpResponse, data)
    }
}
