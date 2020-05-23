import Foundation

///@mockable
protocol WebServicing: class {
    func login(username: String, password: String, handler: @escaping (Result<String, Error>) -> Void)
}

final class WebService: WebServicing {
    func login(username: String, password: String, handler: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            if password == "" {
                handler(.success("userID"))
            } else {
                handler(.failure(WebServiceError.generic))
            }
        }
    }
}

enum WebServiceError: Error {
    case generic
}
