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
        return label
    }()
    
    lazy var bedAndBathLabel: UILabel = {
        let label = UILabel()
        label.text = "Bed: 2, Bath: 1"
        return label
    }()
    
    lazy var sqFootageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVCViews()
        addSubViews()
        addConstraints()
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
        
        
    }
    
    private func addConstraints() {
        constrainSearchBar()
        constrainFilterMenuButton()
        constrainSegmentedController()
        constrainMapView()
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

}
