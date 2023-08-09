//
//  CategoriesViewController.swift
//  news-app
//
//  Created by huseyin on 8.08.2023.
//

import UIKit
import Swinject

class CategoriesViewController: UIViewController {
    let viewModel: CategoryViewModel
    
    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.minimumInteritemSpacing = 16
           layout.minimumLineSpacing = 16
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.backgroundColor = .white
           return collectionView
       }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = NSLocalizedString("categories_text", comment: "")

        collectionView.dataSource = self
        collectionView.delegate = self
                
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCell")
        view.addSubview(collectionView)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
        ])
    }
}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCategories()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCollectionViewCell
            
            let category = viewModel.collectionCategory(at: indexPath.item)
            cell.configure(category: category)
    
            return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemWidth = (collectionView.bounds.width - 16) / 2
            return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = viewModel.collectionCategory(at: indexPath.item)
        let categoryType = selectedCategory.type
        
        navigationController?.pushViewController(CategoryDetailViewController(categoryType: categoryType,viewModel: viewModel), animated: true)
    }
    
}
