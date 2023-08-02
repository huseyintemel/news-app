//
//  TabBarViewController.swift
//  news-app
//
//  Created by huseyin on 2.08.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DependencyContainer.shared.registerViewModels()
        let viewModel = DependencyContainer.shared.container.resolve(NewsViewModel.self)!
        let firstViewController = NewsViewController(viewModel: viewModel)
            
        firstViewController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "house"), tag: 0)
            
        let secondViewController = SearchViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
            
            
        self.viewControllers = [firstViewController,secondViewController]
            
        self.tabBar.tintColor = UIColor.darkGray
        self.tabBar.barTintColor = UIColor.white
    }
}
