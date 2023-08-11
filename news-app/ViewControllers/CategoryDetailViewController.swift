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
    var isLoading = true
        
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
        title = LocalizeHelper.shared.localizeCategoryTitle(categoryType: categoryType)
        
        view.addSubview(categoryTable)
        categoryTable.translatesAutoresizingMaskIntoConstraints = false
        categoryTable.dataSource = self
        categoryTable.rowHeight = UITableView.automaticDimension
        categoryTable.rowHeight = 400
        categoryTable.register(NewsTablePlaceHolderCell.self, forCellReuseIdentifier: "PlaceHolderCell")
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
        isLoading = false
        Task {
            self.categoryTable.reloadData()
        }
    }
    

}

extension CategoryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 10 : viewModel.numberOfNews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let placeHolderCell = tableView.dequeueReusableCell(withIdentifier: "PlaceHolderCell", for: indexPath) as! NewsTablePlaceHolderCell
            
            return placeHolderCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryNewsCell",for: indexPath) as! CategoryTableViewCell
            
            let article = viewModel.article(at: indexPath.row)
            cell.selectionStyle = .none
            cell.set(article: article)
            
            return cell
        }
    }
    
}
