//
//  TabBarController.swift
//  NewsApp
//
//  Created by ihor on 04.11.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let newsViewController = UINavigationController(rootViewController: NewsViewController())
        newsViewController.tabBarItem.title = "News"
        newsViewController.tabBarItem.image = UIImage(named: "news")
        
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        searchViewController.tabBarItem.image = UIImage(named: "search")
        searchViewController.tabBarItem.title = "Search"
        
        let homeViewController = UINavigationController(rootViewController: UIViewController())
        homeViewController.tabBarItem.title = "Home"
        homeViewController.view.backgroundColor = .white
        homeViewController.tabBarItem.image = UIImage(named: "home")
        
        let profileViewController = UINavigationController(rootViewController: UIViewController())
        profileViewController.tabBarItem.title = "Profile"
        profileViewController.view.backgroundColor = .white
        profileViewController.tabBarItem.image = UIImage(named: "profile")
        
        let moreViewController = UINavigationController(rootViewController: UIViewController())
        moreViewController.tabBarItem.title = "More"
        moreViewController.view.backgroundColor = .white
        moreViewController.tabBarItem.image = UIImage(named: "more")
        
        self.viewControllers = [homeViewController, newsViewController, searchViewController, profileViewController, moreViewController]
    }
}
