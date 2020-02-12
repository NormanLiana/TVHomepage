//
//  SlideCardView.swift
//  TruViewHomePage
//
//  Created by Liana Norman on 2/11/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class SlideCardView: UIView {

    // MARK: - UI Objects
    lazy var upArrowIndicator: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrowtriangle.up")
        img.tintColor = .black
        return img
    }()
    
    lazy var aptThumbnail: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "bed.double")
        img.backgroundColor = .blue
        return img
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$2000"
        label.textAlignment = .right
        return label
    }()
    
    lazy var bedAndBathLabel: UILabel = {
        let label = UILabel()
        label.text = "Beds: 2 Baths: 1"
        return label
    }()
    
    lazy var sqFootageLabel: UILabel = {
        let label = UILabel()
        label.text = "700 Sq. Feet"
        return label
    }()
    
    lazy var aptDescriptionTextView: UITextView = {
        let txtView = UITextView()
        txtView.text = "Decription goes here"
        return txtView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        addConstraints()
        setUpViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        addSubview(upArrowIndicator)
        addSubview(aptThumbnail)
        addSubview(priceLabel)
        addSubview(bedAndBathLabel)
        addSubview(sqFootageLabel)
        addSubview(aptDescriptionTextView)
    }
    
    private func addConstraints() {
        constrainArrowImage()
        constrainAptThumbnailImage()
        constrainBedAndBathlabel()
        constrainSqFootagelabel()
        constrainPricelabel()
        constrainAptTextView()
    }
    
    private func setUpViewUI() {
        backgroundColor = .gray
        layer.cornerRadius = 20
    }
    
    // MARK: - Constraint Methods
    private func constrainArrowImage() {
        upArrowIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        [upArrowIndicator.topAnchor.constraint(equalTo: topAnchor), upArrowIndicator.centerXAnchor.constraint(equalTo: centerXAnchor), upArrowIndicator.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.031), upArrowIndicator.widthAnchor.constraint(equalTo: upArrowIndicator.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainAptThumbnailImage() {
        aptThumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        [aptThumbnail.topAnchor.constraint(equalTo: upArrowIndicator.bottomAnchor, constant: 10), aptThumbnail.leadingAnchor.constraint(equalTo: leadingAnchor), aptThumbnail.trailingAnchor.constraint(equalTo: trailingAnchor), aptThumbnail.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)].forEach({$0.isActive = true})
    }
    
    private func constrainBedAndBathlabel() {
        bedAndBathLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [bedAndBathLabel.topAnchor.constraint(equalTo: aptThumbnail.bottomAnchor), bedAndBathLabel.leadingAnchor.constraint(equalTo: leadingAnchor), bedAndBathLabel.trailingAnchor.constraint(equalTo: centerXAnchor), bedAndBathLabel.heightAnchor.constraint(equalTo: aptThumbnail.heightAnchor, multiplier: 0.2)].forEach({$0.isActive = true})
    }
    
    private func constrainSqFootagelabel() {
        sqFootageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [sqFootageLabel.topAnchor.constraint(equalTo: bedAndBathLabel.bottomAnchor), sqFootageLabel.leadingAnchor.constraint(equalTo: leadingAnchor), sqFootageLabel.trailingAnchor.constraint(equalTo: centerXAnchor), sqFootageLabel.heightAnchor.constraint(equalTo: bedAndBathLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainPricelabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [priceLabel.topAnchor.constraint(equalTo: aptThumbnail.bottomAnchor), priceLabel.leadingAnchor.constraint(equalTo: centerXAnchor), priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor), priceLabel.bottomAnchor.constraint(equalTo: bedAndBathLabel.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainAptTextView() {
        aptDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        [aptDescriptionTextView.topAnchor.constraint(equalTo: centerYAnchor), aptDescriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor), aptDescriptionTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85), aptDescriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor)].forEach({$0.isActive = true})
    }
}
