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
        return sb
    }()
    
    lazy var filterMenuButton: UIButton = {
        let btn = UIButton()
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

    }
    

}
