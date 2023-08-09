//
//  CategoryDetailViewController.swift
//  news-app
//
//  Created by huseyin on 9.08.2023.
//

import UIKit

class CategoryDetailViewController: UIViewController, CategoryViewModelDelegate {
    var categoryType: String
    var categoryTable = UITableView()
    var viewModel: CategoryViewModel
        
    init(categoryType: String,viewModel: CategoryViewModel) {
        self.categoryType = categoryType
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = categoryType.capitalized
        
        view.addSubview(categoryTable)
        categoryTable.translatesAutoresizingMaskIntoConstraints = false
        categoryTable.dataSource = self
        categoryTable.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryNewsCell")

        setConstraints()
        viewModel.delegate = self
        
        Task {
            await fetchCategoryData()
        }
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            categoryTable.topAnchor.constraint(equalTo: view.topAnchor),
            categoryTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func fetchCategoryData() async {
        await viewModel.fetchCategoryData(category: categoryType)
    }
    
    func viewModelDidUpdateData() {
        Task {
            self.categoryTable.reloadData()
        }
    }
    

}

extension CategoryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryNewsCell",for: indexPath) as! CategoryTableViewCell
        
        let article = viewModel.article(at: indexPath.row)
        cell.selectionStyle = .none
        cell.set(article: article)
        
        return cell
    }
    
}
