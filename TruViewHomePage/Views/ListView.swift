//
//  ListView.swift
//  TruViewHomePage
//
//  Created by Liana Norman on 2/11/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class ListView: UIView {

    // MARK: - UI Objects
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(ListViewCVCell.self, forCellWithReuseIdentifier: CellIdentifiers.listViewCVCell.rawValue)
        return cv
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        constrainCV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(collectionView)
    }
    
    private func addConstraints() {
        constrainCV()
    }
    
    private func constrainCV() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        [collectionView.topAnchor.constraint(equalTo: topAnchor), collectionView.leadingAnchor.constraint(equalTo: leadingAnchor), collectionView.trailingAnchor.constraint(equalTo: trailingAnchor), collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)].forEach({$0.isActive = true})
    }
    
}
