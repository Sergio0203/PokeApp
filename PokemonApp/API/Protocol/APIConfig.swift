//
//  APIConfig.swift
//  PokemonApp
//
//  Created by Sérgio César Lira Júnior on 13/09/24.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
}

enum UserEndpoint: APIEndpoint {
    
    case getPokemon(with: Int)
    
    var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2/")!
    }
    
    var path: String {
        switch self {
        case .getPokemon(let pokemonNumber):
            return "pokemon-form/\(pokemonNumber)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPokemon:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getPokemon:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getPokemon:
            return nil
        }
    }
}


