//
//  ArticleViewModel.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

class ArticleViewModel {

    typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies

    let pageTitleText = "article_scene.page_title_text".localized
    var pokemons: Pokemons?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    private let apiClient: PokemonAPIClient = APIClient()

    func fetchPokemons(offset: Int, limit: Int, _ completion: @escaping ()->()) {
        apiClient.fetchPokemons( offset: offset, limit: limit) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                completion()
            case .success(let response):
                self?.pokemons = response
            }
        }
    }
}
