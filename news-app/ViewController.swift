//
//  ViewController.swift
//  news-app
//
//  Created by huseyin on 14.07.2023.
//

import UIKit

class ViewController: UIViewController {

    var newsTableView = UITableView()
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsTableView)
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.rowHeight = 400
        newsTableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        setNewsTableConstraints()
       
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
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=7054e46161114bafaaeb518f3ddfaf09"
        NetworkManager.shared.request(News.self, url: url) { result in
            switch result {
            case .success(let newsAPIResponse):
                // Access the articles
                self.articles = newsAPIResponse.articles
                self.newsTableView.reloadData()
                print(self.articles.count)
            case .failure(let error):
                // Handle the error
                print("Request failed with error: \(error)")
            }
        }
    }

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableCell", for: indexPath) as! NewsTableViewCell
        
        let article = article(at: indexPath.row)
        cell.set(article: article)
        
        return cell
    }
    
    func article(at index: Int) -> Article {
           return articles[index]
    }
}
