//
//  DataService.swift
//  PokemonApp
//
//  Created by Sérgio César Lira Júnior on 18/09/24.
//

import SwiftUI

final class DataService {    
    var pokemonData: Pokemon {
        get {
            @AppStorage("pokemonData", store: UserDefaults(suiteName: "group.com.scljr.PokemonApp")) var pokemonData: Data?
            guard let data = pokemonData else { return Pokemon(name: "", sprites: Sprite(), id: 0) }
            return (try? JSONDecoder().decode(Pokemon.self, from: data)) ?? Pokemon(name: "", sprites: Sprite(), id: 0)
        }
    }
    @AppStorage("score", store: UserDefaults(suiteName: "group.com.scljr.PokemonApp")) var score: Int = 0
    @AppStorage("highScore", store: UserDefaults(suiteName: "group.com.scljr.PokemonApp")) var highScore: Int = 0
    @AppStorage("isGuessed", store: UserDefaults(suiteName: "group.com.scljr.PokemonApp")) var isGuessed: Bool = false
}
