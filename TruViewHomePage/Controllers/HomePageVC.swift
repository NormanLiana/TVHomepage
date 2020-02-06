//
//  HomePageVC.swift
//  TruViewHomePage
//
//  Created by Liana Norman on 2/6/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

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
        let items = ["List View", "Map View"]
        let sc = UISegmentedControl(items: items)
        return sc
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
    }
    
    private func addConstraints() {
        constrainSearchBar()
    }
    
    // MARK: - Constraint Methods
    private func constrainSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        [searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor), searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825), searchBar.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)].forEach({$0.isActive = true})
    }

}
