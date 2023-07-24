//
//  DependencyContainer.swift
//  news-app
//
//  Created by huseyin on 24.07.2023.
//

import Swinject

class DependencyContainer {
    static let shared = DependencyContainer()
    let container = Container()

    func registerViewModels() {
        container.register(NewsViewModel.self) { _ in
            NewsViewModel()
        }
    }
}
