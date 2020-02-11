//
//  ListViewCVCell.swift
//  TruViewHomePage
//
//  Created by Liana Norman on 2/11/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class ListViewCVCell: UICollectionViewCell {
    
    // MARK: - UI Objects
    lazy var aptThumbnail: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "bed.double")
        return imgView
    }()
    
    lazy var priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "$2000"
        return lbl
    }()
    
    lazy var bedAndbathLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "2 Bed 2 Bath"
        return lbl
    }()
    
    lazy var sqFootageLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "600 sq Feet"
        return lbl
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        addSubview(aptThumbnail)
        addSubview(priceLabel)
        addSubview(bedAndbathLabel)
        addSubview(sqFootageLabel)
    }
}
