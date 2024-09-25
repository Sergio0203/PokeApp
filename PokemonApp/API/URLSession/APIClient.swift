//
//  NetWork.swift
//  PokemonApp
//
//  Created by Sérgio César Lira Júnior on 13/09/24.
//
import Foundation

protocol APIClient {
    func request<T: Decodable, U: APIEndpoint>(_ endpoint: U, completion: @escaping (Result<T, APIError>) -> Void)
}

final class URLSessionAPIClient: APIClient {
    func request<T: Decodable, U: APIEndpoint>(_ endpoint:  U, completion: @escaping (Result<T, APIError>) -> Void) {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            } catch {
                completion(.failure(.parsingError))
            }
        }.resume()
    }
}

