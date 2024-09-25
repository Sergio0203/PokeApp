//
//  HomeView.swift
//  PokemonApp
//
//  Created by Sérgio César Lira Júnior on 13/09/24.
//
import SwiftUI
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .foregroundStyle(.red.gradient)
            VStack(spacing: 20){
                
                scores
                    .fontWidth(.condensed)
                    .fontWeight(.bold)
                
                pokemonImage
                
                pokemonName
            
                TextField("Pokemon Name", text: $viewModel.text)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 60)
                
                Button(action: guessPokemon){
                    Text("Guess")
                }
                .disabled(viewModel.text.isEmpty || viewModel.isGuessed)
                .buttonStyle(.borderedProminent)
                
                Button(action: getNewPokemon){
                    Text("Get new pokemon")
                }
                .buttonStyle(.borderedProminent)
            }
            .foregroundStyle(.white)
        }
        .onChange(of: scenePhase) { phase in
            viewModel.handleScenePhase(phase: phase)
        }
    }
    
    @ViewBuilder
    private var pokemonImage: some View {
        if let sprite = viewModel.pokemon?.sprites.front_default{
            AsyncImage(url: URL(string: sprite)){ phase in
                switch phase {
                case .success(let image):
                    image
                        .brightness(viewModel.isGuessed ? 0 : -2)
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
    
    @ViewBuilder
    private var scores: some View {
        HStack {
            Text("Score: \(viewModel.score)")
            Spacer()
            Text("High Score: \(viewModel.highScore)")
        }
        .font(.headline)
        .padding(.horizontal, 20)
    }
    private func guessPokemon() {
        viewModel.guessPokemon()
    }
    
    private func getNewPokemon() {
        viewModel.newPokemon()
    }
    
    @ViewBuilder
    private var pokemonName: some View {
        if viewModel.isGuessed {
            if let pokemonName = viewModel.pokemon?.name {
                Text(pokemonName.capitalized)
            }
        }
    }
}

#Preview {
    HomeView()
}
