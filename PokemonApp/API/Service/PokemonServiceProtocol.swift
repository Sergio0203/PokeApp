//
//  PokemonServiceProtocol.swift
//  PokemonApp
//
//  Created by Sérgio César Lira Júnior on 23/09/24.
//

import Combine

protocol PokemonServiceProtocol {
    func getPokemon(pokemonNumber: Int) -> AnyPublisher<Pokemon, Error>
}
