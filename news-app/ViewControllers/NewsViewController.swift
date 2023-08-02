//
//  ViewController.swift
//  news-app
//
//  Created by huseyin on 14.07.2023.
//

import UIKit
import Swinject

class NewsViewController: UIViewController, NewsViewModelDelegate {

    var newsTableView = UITableView()
    var viewModel: NewsViewModel
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = NSLocalizedString("news_title", comment: "")
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsTableView)
        view.addSubview(collectionView)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.rowHeight = 400
        newsTableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        setNewsTableConstraints()
       
        viewModel.delegate = self
        
        Task {
            await fetchData()
            await fetchCollectionData()
        }
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableCell")
    }

    
    func setNewsTableConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 240),
                        
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchData() async {
        await viewModel.fetchData()
    }
    
    func fetchCollectionData() async {
        await viewModel.fetchCollectionData()
    }
    
    func viewModelDidUpdateData() {
        Task {
            self.newsTableView.reloadData()
            self.collectionView.reloadData()
        }
    }
}


extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableCell", for: indexPath) as! NewsTableViewCell
        
        let article = viewModel.article(at: indexPath.row)
        cell.selectionStyle = .none
        cell.set(article: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = viewModel.article(at: indexPath.row)
        let detailPage = NewsDetailViewController(article: selectedNews)
        
        detailPage.modalPresentationStyle = .popover
        present(detailPage, animated: true,completion: nil)
    }
    
}

extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.numberOfCollectionNews()
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionCell", for: indexPath) as! NewsCollectionViewCell
           
           let article = viewModel.collectionArticle(at:indexPath.item)
           cell.scrollIndicator.currentPage = indexPath.item
           cell.set(article: article)
                      
           return cell
       }
       
       // MARK: - UICollectionViewDelegateFlowLayout
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Adjust the item size as needed
           return CGSize(width: view.bounds.width, height: 240)
       }
}
