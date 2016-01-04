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
  flightStatusNavVC.tabBarItem = UITabBarItem(title: "Flight", image: Image.greenCircle.image(), selectedImage: nil)
  
  let dashboardNavVC = UINavigationController(rootViewController: DashboardVC())
  dashboardNavVC.tabBarItem = UITabBarItem(title: "Dashboard", image: Image.greenCircle.image(), selectedImage: nil)
  
  let shortTripNavVC = UINavigationController(rootViewController: ShortTripVC())
  shortTripNavVC.tabBarItem = UITabBarItem(title: "Trip", image: Image.blueCircle.image(), selectedImage: nil)
  
  mainTabBarController.viewControllers = [
    flightStatusNavVC,
    dashboardNavVC,
    shortTripNavVC
  ]
  
  mainTabBarController.selectedIndex = 1

  return mainTabBarController
}
