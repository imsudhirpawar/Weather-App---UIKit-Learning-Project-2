//
//  ListViewController.swift
//  Weather
//
//  Created by Sudhir Pawar on 21/09/23.
//

import UIKit
import GooglePlaces

class ListViewController: UIViewController {
    
    
    var resultsViewController = GMSAutocompleteResultsViewController()
    var resultView = UITextView()
    var searchController = UISearchController()
    
    var delegate: CustomLocationDelegate?
    
    var viewModel = UserLocationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController.delegate = self
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.searchResultsUpdater = resultsViewController
        
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        resultsViewController.autocompleteFilter = filter

        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search city"
        navigationItem.searchController = searchController
        
    }
}

extension ListViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        
        searchController.isActive = false
        
        delegate?.didReceivedCustomLocation(userLocationString: place.name!)
        self.present(ViewController(), animated:true, completion:nil)
        self.dismiss(animated: true, completion: nil)
        print("Place name: \(place.name!)")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
        // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

