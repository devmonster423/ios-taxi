//
//  MainTabBarController.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/4/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit

var MainTabBarController: UITabBarController {

  let mainTabBarController = UITabBarController()
  
  let flightStatusNavVC = UINavigationController(rootViewController: TerminalSummaryVC())
  flightStatusNavVC.tabBarItem = UITabBarItem(title: "", image: Image.flightsIcon.image(), selectedImage: nil)
  flightStatusNavVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
  
  let dashboardNavVC = UINavigationController(rootViewController: DashboardVC())
  dashboardNavVC.tabBarItem = UITabBarItem(title: "", image: Image.dashboardIcon.image(), selectedImage: nil)
  dashboardNavVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
  
  let shortTripNavVC = UINavigationController(rootViewController: ShortTripVC())
  shortTripNavVC.tabBarItem = UITabBarItem(title: "", image: Image.tripIcon.image(), selectedImage: nil)
  shortTripNavVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
  
  mainTabBarController.viewControllers = [
    flightStatusNavVC,
    dashboardNavVC,
    shortTripNavVC
  ]
  
  mainTabBarController.selectedIndex = 1
  mainTabBarController.tabBar.barTintColor = Color.TabBar.background
  mainTabBarController.tabBar.tintColor = UIColor.whiteColor()
  mainTabBarController.tabBar.translucent = false

  return mainTabBarController
}
