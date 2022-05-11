//
//  ArticleAPIClient.swift
//  SportsMax
//
//  Created by MohammadBarek on 12/24/20.
//

import Foundation

protocol PokemonAPIClient {
    func fetchPokemons(offset: Int, limit: Int, completion: @escaping (Swift.Result<Pokemons, APIError>) -> Void)
}

extension APIClient: PokemonAPIClient {
    func fetchPokemons(offset: Int, limit: Int, completion: @escaping (Result<Pokemons, APIError>) -> Void) {
        let request = PokemonFetchRequest(offset: offset)
        genericRequest(forRequest: request, forType: Pokemons.self) { result in
            completion(result)
        }
    }
}
