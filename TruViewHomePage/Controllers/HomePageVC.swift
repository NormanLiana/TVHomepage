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
        view.backgroundColor = .gray
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    
    
    // MARK: - Properties
    let slideCardHeight: CGFloat = 900
    var slideCardState: SlideCardState = .collapsed
    
    var collapsedslideCardViewTopConstraint: NSLayoutConstraint?
    var halfOpenSlideCardViewTopConstraint: NSLayoutConstraint?
    var fullScreenSlideCardTopConstraint: NSLayoutConstraint?
    
    unowned var listView: ListView { return self.view as! ListView}
    unowned var listCV: UICollectionView { return listView.collectionView}
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVCViews()
        addSubViews()
        addConstraints()
        delegation()
        loadGestures()
    }
    
    override func loadView() {
        self.view = ListView()
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
    }
    
    private func addConstraints() {
        constrainSearchBar()
        constrainFilterMenuButton()
        constrainSegmentedController()
        constrainMapView()
        // MARK: - Slide Card Constraint Methods
        constrainSlideCardView()
    }
    
    private func delegation() {
        listCV.delegate = self
        listCV.dataSource = self
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
        collapsedslideCardViewTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.bottomAnchor, constant:  -slideCardHeight + 400)
        collapsedslideCardViewTopConstraint?.isActive = false

        halfOpenSlideCardViewTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
        halfOpenSlideCardViewTopConstraint?.isActive = true

        fullScreenSlideCardTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        fullScreenSlideCardTopConstraint?.isActive = false
    }
    
    private func constrainSlideCardView() {
        slideCardView.translatesAutoresizingMaskIntoConstraints = false
        
        [slideCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor), slideCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor), slideCardView.heightAnchor.constraint(equalToConstant: slideCardHeight)].forEach({$0.isActive = true})
        createSlideCardViewConstraints()
    }
    
    private func activateFullOpenSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = true
        collapsedslideCardViewTopConstraint?.isActive = false
        halfOpenSlideCardViewTopConstraint?.isActive = false
    }
    
    private func activateHalfOpenSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = false
        collapsedslideCardViewTopConstraint?.isActive = true
        halfOpenSlideCardViewTopConstraint?.isActive = false
    }
    
    private func activateClosedSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = false
        collapsedslideCardViewTopConstraint?.isActive = false
        halfOpenSlideCardViewTopConstraint?.isActive = true
    }
    

}

// MARK: - Extensions
extension HomePageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = listCV.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.listViewCVCell.rawValue, for: indexPath) as? ListViewCVCell {
            cell.aptThumbnail.image = UIImage(systemName: "bed.double")
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension HomePageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 125)
    }
}

extension HomePageVC: UICollectionViewDelegate {}
