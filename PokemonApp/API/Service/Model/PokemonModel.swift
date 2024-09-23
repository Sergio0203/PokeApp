//
//  PokemonModel.swift
//  PokemonApp
//
//  Created by Sérgio César Lira Júnior on 13/09/24.
//

struct Pokemon: Codable{
    var name: String
    var sprites: Sprite
    var id: Int
}

struct Sprite: Codable {
    var front_default: String?
}
