//
//  CollectionViewCellPlaceHolder.swift
//  news-app
//
//  Created by huseyin on 11.08.2023.
//

import UIKit

class CollectionViewCellPlaceHolder: UICollectionViewCell {
    
    lazy var placeHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(placeHolderView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            placeHolderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            placeHolderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeHolderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            placeHolderView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
}
