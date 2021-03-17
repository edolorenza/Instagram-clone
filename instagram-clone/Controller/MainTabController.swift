//
//  MainTabController.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 17/03/21.
//

import UIKit

class MainTabController: UITabBarController{
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
       
    }
    
    //MARK: - Helpers
    
    func configureViewControllers() {
        view.backgroundColor = .white
        
        let feed = FeedController()
        
        let search = SearchController()
        
        let imageSelector = ImageSelectorController()
        
        let notification = NotificationController()
        
        let profile = ProfileController()
        
        viewControllers = [feed, search, imageSelector, notification, profile]
        
    }
}
