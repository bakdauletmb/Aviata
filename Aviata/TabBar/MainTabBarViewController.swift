//
//  MainTabBarViewController.swift
//  Aviata
//
//  Created by Bakdaulet Myrzakerov on 10/3/20.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    //MARK: - setup
    private func setupTabBar(){
        let mainPageVC = MainPageViewController().inNavigation()
        mainPageVC.tabBarItem = UITabBarItem.init(title: "Main", image: #imageLiteral(resourceName: "Home"), tag: 0)
        
        let savedPagesVC = SavedArtcilesViewController().inNavigation()
        savedPagesVC.tabBarItem = UITabBarItem.init(title: "Saved", image: #imageLiteral(resourceName: "Heart"), tag: 1)
        
        viewControllers = [mainPageVC,savedPagesVC]
    }
}
