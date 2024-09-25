//
//  PokemonServiceProtocol.swift
//  PokemonApp
//
//  Created by Sérgio César Lira Júnior on 23/09/24.
//

protocol PokemonServiceProtocol {
    func getPokemon(pokemonNumber: Int, completion: @escaping (Result<Pokemon, APIError>) -> Void)
}
