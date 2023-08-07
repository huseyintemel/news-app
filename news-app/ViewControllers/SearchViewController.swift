//
//  SearchViewController.swift
//  news-app
//
//  Created by huseyin on 2.08.2023.
//

import UIKit

class SearchViewController: UIViewController, NewsViewModelDelegate, UISearchResultsUpdating {
  
    var viewModel: NewsViewModel
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
      
    let newsTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        newsTable.rowHeight = UITableView.automaticDimension
        newsTable.rowHeight = 400
        newsTable.register(SearchNewsTableViewCell.self, forCellReuseIdentifier: "SearchNewsCell")
        newsTable.dataSource = self
        searchController.searchResultsUpdater = self
        
        view.addSubview(newsTable)
        setConstraints()
        
        viewModel.delegate = self
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func fetchSearchData(query: String) async {
        await viewModel.searchArticlesData(query: query)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            return
        }

        // Call the data fetch with the updated query
        Task {
            await viewModel.searchArticlesData(query: query)
            self.newsTable.reloadData()
        }
    }
    
    func viewModelDidUpdateData() {
        Task {
            self.newsTable.reloadData()
        }
    }

}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSearchNews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchNewsCell", for: indexPath) as! SearchNewsTableViewCell
        
        
        let article = viewModel.searchArticle(at: indexPath.row)
        cell.selectionStyle = .none
        cell.set(article: article)
        
        return cell
    }
}
