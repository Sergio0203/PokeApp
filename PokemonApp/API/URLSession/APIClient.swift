//
//  NetWork.swift
//  PokemonApp
//
//  Created by Sérgio César Lira Júnior on 13/09/24.
//
import Combine
import Foundation

protocol APIClient {
    func request<T: Decodable, U: APIEndpoint>(_ endpoint: U) -> AnyPublisher<T, Error>
}
final class URLSessionAPIClient: APIClient {
    func request<T: Decodable, U: APIEndpoint>(_ endpoint:  U) -> AnyPublisher<T, Error> {
        
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...399).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
