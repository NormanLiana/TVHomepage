//
//  HomePageVC.swift
//  TruViewHomePage
//
//  Created by Liana Norman on 2/6/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomePageVC: UIViewController {

    // MARK: - UI Objects
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        return sb
    }()
    
    lazy var filterMenuButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Filter", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    lazy var mapListViewSegController: UISegmentedControl = {
        let items = ["Map View", "List View"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    lazy var mapView: MKMapView = {
        let mv = MKMapView()
        return mv
    }()
    
    // MARK: - Slide card UI Objects
    lazy var slideCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
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
    
    // MARK: - Properties
    let slideCardHeight: CGFloat = 900
    var slideCardState: SlideCardState = .collapsed
    
    var slideCardViewTopConstraint: NSLayoutConstraint?
    var newSlideCardViewTopConstraint: NSLayoutConstraint?
    var fullScreenSlideCardViewConstraint: NSLayoutConstraint?
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVCViews()
        addSubViews()
        addConstraints()
        loadGestures()
    }
    
    // MARK: - ObjC Methods
    @objc func respondToSwipeGesture(gesture: UISwipeGestureRecognizer?) {
        if let swipeGesture = gesture {
            switch swipeGesture.direction {
            case .down:
                switch slideCardState {
                case .fullOpen:
                    activateHalfOpenSliderViewConstraints()
                    slideCardState = .halfOpen
                case .halfOpen:
                    activateClosedSliderViewConstraints()
                    slideCardState = .collapsed
                case .collapsed:
                    print("Its closed already")
                }
                
                UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
                
                self?.view.layoutIfNeeded()
                
                    if self?.slideCardState == .collapsed {
                    self?.slideCardView.alpha = 0.5
                }
                
                }, completion: nil)
            case .up:
                switch slideCardState {
                case .fullOpen:
                    print("Its already fully open")
                case .halfOpen:
                    activateFullOpenSliderViewConstraints()
                    slideCardState = .fullOpen
                case .collapsed:
                    activateHalfOpenSliderViewConstraints()
                    slideCardState = .halfOpen
                }
                
                UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
                
                self?.view.layoutIfNeeded()
                
                self?.slideCardView.alpha = 1.0
                }, completion: nil)
                
            default:
                break
                
            }
        }
    }
    
    // MARK: - Private Methods
    private func setUpVCViews() {
        view.backgroundColor = .white
    }
    private func addSubViews() {
        view.addSubview(searchBar)
        view.addSubview(filterMenuButton)
        view.addSubview(mapListViewSegController)
        view.addSubview(mapView)
        view.addSubview(slideCardView)
        
        slideCardView.addSubview(upArrowIndicator)
        slideCardView.addSubview(aptThumbnail)
        slideCardView.addSubview(priceLabel)
        slideCardView.addSubview(bedAndBathLabel)
        slideCardView.addSubview(sqFootageLabel)
    }
    
    private func addConstraints() {
        constrainSearchBar()
        constrainFilterMenuButton()
        constrainSegmentedController()
        constrainMapView()
        // MARK: - Slide Card Constraint Methods
        constrainSlideCardView()
        constrainArrowImage()
        constrainAptThumbnailImage()
        constrainBedAndBathlabel()
        constrainSqFootagelabel()
        constrainPricelabel()
    }
    
    private func loadGestures() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = .down
        self.slideCardView.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = .up
        self.slideCardView.addGestureRecognizer(swipeUp)
    }
    
    // MARK: - Constraint Methods
    private func constrainSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        [searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor), searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825), searchBar.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)].forEach({$0.isActive = true})
    }
    
    private func constrainFilterMenuButton() {
        filterMenuButton.translatesAutoresizingMaskIntoConstraints = false
        
        [filterMenuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), filterMenuButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor), filterMenuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor), filterMenuButton.heightAnchor.constraint(equalTo: searchBar.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainSegmentedController() {
        mapListViewSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [mapListViewSegController.topAnchor.constraint(equalTo: searchBar.bottomAnchor), mapListViewSegController.leadingAnchor.constraint(equalTo: view.leadingAnchor), mapListViewSegController.trailingAnchor.constraint(equalTo: view.trailingAnchor), mapListViewSegController.heightAnchor.constraint(equalTo: searchBar.heightAnchor, multiplier: 0.4)].forEach({$0.isActive = true})
    }
    
    private func constrainMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        [mapView.topAnchor.constraint(equalTo: mapListViewSegController.bottomAnchor), mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor), mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor), mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    // MARK: - Constraint Methods for Slide Card View
    private func createSlideCardViewConstraints() {
        slideCardViewTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.bottomAnchor, constant:  -slideCardHeight + 400)
        slideCardViewTopConstraint?.isActive = false

        newSlideCardViewTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
        newSlideCardViewTopConstraint?.isActive = true

        fullScreenSlideCardViewConstraint = slideCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        fullScreenSlideCardViewConstraint?.isActive = false
    }
    
    private func constrainSlideCardView() {
        slideCardView.translatesAutoresizingMaskIntoConstraints = false
        
        [slideCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor), slideCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor), slideCardView.heightAnchor.constraint(equalToConstant: slideCardHeight)].forEach({$0.isActive = true})
        createSlideCardViewConstraints()
    }
    
    private func constrainArrowImage() {
        upArrowIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        [upArrowIndicator.topAnchor.constraint(equalTo: slideCardView.topAnchor), upArrowIndicator.centerXAnchor.constraint(equalTo: slideCardView.centerXAnchor), upArrowIndicator.heightAnchor.constraint(equalTo: slideCardView.heightAnchor, multiplier: 0.031), upArrowIndicator.widthAnchor.constraint(equalTo: upArrowIndicator.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainAptThumbnailImage() {
        aptThumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        [aptThumbnail.topAnchor.constraint(equalTo: upArrowIndicator.bottomAnchor, constant: 10), aptThumbnail.leadingAnchor.constraint(equalTo: slideCardView.leadingAnchor), aptThumbnail.trailingAnchor.constraint(equalTo: slideCardView.trailingAnchor), aptThumbnail.heightAnchor.constraint(equalTo: slideCardView.widthAnchor, multiplier: 0.7)].forEach({$0.isActive = true})
    }
    
    private func constrainBedAndBathlabel() {
        bedAndBathLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [bedAndBathLabel.topAnchor.constraint(equalTo: aptThumbnail.bottomAnchor), bedAndBathLabel.leadingAnchor.constraint(equalTo: slideCardView.leadingAnchor), bedAndBathLabel.trailingAnchor.constraint(equalTo: slideCardView.centerXAnchor), bedAndBathLabel.heightAnchor.constraint(equalTo: aptThumbnail.heightAnchor, multiplier: 0.2)].forEach({$0.isActive = true})
    }
    
    private func constrainSqFootagelabel() {
        sqFootageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [sqFootageLabel.topAnchor.constraint(equalTo: bedAndBathLabel.bottomAnchor), sqFootageLabel.leadingAnchor.constraint(equalTo: slideCardView.leadingAnchor), sqFootageLabel.trailingAnchor.constraint(equalTo: slideCardView.centerXAnchor), sqFootageLabel.heightAnchor.constraint(equalTo: bedAndBathLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainPricelabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [priceLabel.topAnchor.constraint(equalTo: aptThumbnail.bottomAnchor), priceLabel.leadingAnchor.constraint(equalTo: slideCardView.centerXAnchor), priceLabel.trailingAnchor.constraint(equalTo: slideCardView.trailingAnchor), priceLabel.bottomAnchor.constraint(equalTo: bedAndBathLabel.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    private func activateFullOpenSliderViewConstraints() {
        fullScreenSlideCardViewConstraint?.isActive = true
        slideCardViewTopConstraint?.isActive = false
        newSlideCardViewTopConstraint?.isActive = false
    }
    
    private func activateHalfOpenSliderViewConstraints() {
        fullScreenSlideCardViewConstraint?.isActive = false
        slideCardViewTopConstraint?.isActive = true
        newSlideCardViewTopConstraint?.isActive = false
    }
    
    private func activateClosedSliderViewConstraints() {
        fullScreenSlideCardViewConstraint?.isActive = false
        slideCardViewTopConstraint?.isActive = false
        newSlideCardViewTopConstraint?.isActive = true
    }
    

}

