import Foundation

final class PokemonService: PokemonServiceProtocol {
    let apiClient: APIClient
    init(client: APIClient = URLSessionAPIClient()) {
        apiClient = client
    }
    
    func getPokemon(pokemonNumber: Int, completion: @escaping (Result<Pokemon, APIError>) -> Void) {
        apiClient.request(PokemonEndpoint.getPokemon(with: pokemonNumber), completion: completion)
    }
}
