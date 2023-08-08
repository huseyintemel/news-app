//
//  SearchViewController.swift
//  news-app
//
//  Created by huseyin on 2.08.2023.
//

import UIKit

class SearchViewController: UIViewController, NewsViewModelDelegate, UISearchBarDelegate {
  
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
    
    let noResultLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("search_table_text", comment: "")
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = NSLocalizedString("search_title", comment: "title")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        newsTable.rowHeight = UITableView.automaticDimension
        newsTable.rowHeight = 400
        newsTable.register(SearchNewsTableViewCell.self, forCellReuseIdentifier: "SearchNewsCell")
        newsTable.dataSource = self
        newsTable.delegate = self
        
        view.addSubview(newsTable)
        view.addSubview(noResultLabel)
        setConstraints()
        
        viewModel.delegate = self
        searchController.searchBar.delegate = self
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noResultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            noResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func fetchSearchData(query: String) async {
        await viewModel.searchArticlesData(query: query)
    }
    
    func viewModelDidUpdateData() {
        Task {
            self.newsTable.reloadData()
        }
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = viewModel.searchArticle(at: indexPath.row)
        let detailPage = NewsDetailViewController(article: selectedNews)
        
        detailPage.modalPresentationStyle = .popover
        present(detailPage, animated: true,completion: nil)
    }
}


extension SearchViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            Task {
                noResultLabel.isHidden = true
                newsTable.isHidden = false
                await viewModel.searchArticlesData(query: searchText)
                self.newsTable.reloadData()
                
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        noResultLabel.isHidden = false
        newsTable.isHidden = true
    }
}
