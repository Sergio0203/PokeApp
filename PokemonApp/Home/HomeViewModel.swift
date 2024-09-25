//
//  File.swift
//  PokemonApp
//
//  Created by Sérgio César Lira Júnior on 18/09/24.
//

import SwiftUI
import Combine
import WidgetKit
final class HomeViewModel: ObservableObject {
    
    @AppStorage("pokemonData", store: UserDefaults(suiteName: "group.com.scljr.PokemonApp")) private var pokemonData: Data?
    @AppStorage("isGuessed", store: UserDefaults(suiteName: "group.com.scljr.PokemonApp")) var isGuessed: Bool = false
    @AppStorage("score", store: UserDefaults(suiteName: "group.com.scljr.PokemonApp")) var score: Int = 0
    @AppStorage("highScore", store: UserDefaults(suiteName: "group.com.scljr.PokemonApp")) var highScore: Int = 0
    @Published var text: String = ""
    private var cancellables = Set<AnyCancellable>()
    let pokemonService: PokemonServiceProtocol
    
    init(pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemonService = pokemonService
    }
    
    var pokemon: Pokemon? {
        get {
            guard let data = pokemonData else { return Pokemon(name: "", sprites: Sprite(), id: 0) }
            return (try? JSONDecoder().decode(Pokemon.self, from: data)) ?? Pokemon(name: "", sprites: Sprite(), id: 0)
        }
        set {
            pokemonData = try? JSONEncoder().encode(newValue)
            isGuessed = false
        }
    }
    
    func guessPokemon() {
        isGuessed = text.lowercased() == pokemon?.name.lowercased()
        text.removeAll()
        if isGuessed {
            score += 1
            if score > highScore {
                highScore = score
            }
        }
    }
    func newPokemon() {
        text.removeAll()
        if !isGuessed {
            score = 0
        }
        fetchPokemon()
    }
    
    private func reloadWidget() {
        WidgetCenter.shared.reloadTimelines(ofKind: "PokemonWidget")
    }
    
    func fetchPokemon(pokemonNumber: Int = Int.random(in: 1...151)) {
        pokemonService.getPokemon(pokemonNumber: pokemonNumber){ [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.pokemon = pokemon
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func handleScenePhase(phase: ScenePhase){
        switch phase {
        case .background:
            reloadWidget()
        default:
            break
        }
    }
}
