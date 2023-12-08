//
//  TabCotrollerTableViewController.swift
//  Weather
//
//  Created by Sudhir Pawar on 21/09/23.
//
import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = true // Set this to true for the blur effect

        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .regular) // You can adjust the style to your preference

        // Create a visual effect view with the blur effect
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.alpha = 0.15
        // Set the frame of the visual effect view to cover the entire tab bar
        blurEffectView.frame  = view.bounds
        
        tabBar.tintColor = .cyan
        tabBar.unselectedItemTintColor = .white
        
        // Add the visual effect view as a subview of the tab bar
        tabBar.addSubview(blurEffectView)

        let homeVC = ViewController()
        let favVC = ListViewController()

        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: favVC)
        ]

        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
        favVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "list.bullet"), tag: 1)
        
        
    }
}
