//
//  ViewController.swift
//  news-app
//
//  Created by huseyin on 14.07.2023.
//

import UIKit

class ViewController: UIViewController, NewsViewModelDelegate {

    var newsTableView = UITableView()
    var viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsTableView)
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.rowHeight = 400
        newsTableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        setNewsTableConstraints()
       
        viewModel.delegate = self
        
        Task {
            await fetchData()
        }
        
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableCell")
    }

    
    func setNewsTableConstraints() {
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func fetchData() async {
        await viewModel.fetchData()
    }
    
    func viewModelDidUpdateData() {
        Task {
            self.newsTableView.reloadData()
        }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableCell", for: indexPath) as! NewsTableViewCell
        
        let article = viewModel.article(at: indexPath.row)
        cell.set(article: article)
        
        return cell
    }
}
