//
//  TapBar.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupTabs()
    }
    
    private func setupTabs(){
        let navigationController1 = UINavigationController(rootViewController: TableViewController())
        let tabImage = UIImage(systemName: "text.justify")!
        navigationController1.tabBarItem = UITabBarItem(title: "TableView", image: tabImage, tag:0)
        
        let navigationController2 = UINavigationController(rootViewController: MapViewController())
        let tabImage2 = UIImage(systemName: "map")!
        navigationController2.tabBarItem = UITabBarItem(title: "Map", image: tabImage2, tag:1)
        
        let navigationController3 = UINavigationController(rootViewController: UserViewController())
        let tabImage3 = UIImage(systemName: "person.fill")!
        navigationController3.tabBarItem = UITabBarItem(title: "Profile", image: tabImage3, tag:2)
        
        viewControllers = [navigationController1,navigationController2,navigationController3]
    }
    
    private func setupLayout(){
        tabBar.backgroundColor = .systemBackground
    }
    


}
