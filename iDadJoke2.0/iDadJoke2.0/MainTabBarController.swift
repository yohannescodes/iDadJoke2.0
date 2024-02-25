//
//  MainTabBarViewController.swift
//  iDadJoke2.0
//
//  Created by Yohannes Haile on 2/25/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTabBarController()
    }
    
    private func createTabBarController(){
        
        view.backgroundColor = .black
        
        let homeVC = createViewController(viewController: HomeViewController(), title: "Home", unselectedImage: "house", selectedImage: "house.fill")
        
        let savedVC = createViewController(viewController: SavedViewController(), title: "Saved", unselectedImage: "heart", selectedImage: "heart.fill")
        
        let aboutVC = createViewController(viewController: AboutViewController(), title: "About", unselectedImage: "person.crop.circle.badge.questionmark", selectedImage: "person.crop.circle.badge.questionmark.fill")
        
        setViewControllers([homeVC, savedVC, aboutVC], animated: true)
        
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .black
    
        
        
        
    }
    
    private func createViewController(viewController: UIViewController, title: String, unselectedImage: String, selectedImage: String) -> UINavigationController {
        let viewController = UINavigationController(rootViewController: viewController)
        viewController.title = title
        viewController.tabBarItem.image = UIImage(systemName: unselectedImage)
        viewController.tabBarItem.selectedImage = UIImage(systemName: selectedImage)
        return viewController
    }
}
