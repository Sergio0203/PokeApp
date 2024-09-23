import Foundation
import Combine

final class PokemonService: PokemonServiceProtocol {
    let apiClient: APIClient
    
    init(client: APIClient = URLSessionAPIClient()) {
        apiClient = client
    }
    
    func getPokemon(pokemonNumber: Int) -> AnyPublisher<Pokemon, Error> {
        return apiClient.request(UserEndpoint.getPokemon(with: pokemonNumber))
    }
}
